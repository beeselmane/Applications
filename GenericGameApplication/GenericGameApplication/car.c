#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "car.h"

#define HEADER_SIZE 33
#define ENTRY_SIZE  18

struct CFIterator {
    CString file;
    Offset offset;
    Length filecount;
    FILE *fp;
};

__attribute__((visibility("hidden"))) UInt32 CARGetCRC32(unsigned char *message, Length size)
{
    static UInt32 table[256];
    UInt32 crc, byte;

    if (table[1] == 0)
    {
        for (byte = 0; byte <= 255; byte++)
        {
            crc = byte;

            for (int j = 7; j >= 0; j--)
            {
                UInt32 mask = -(crc & 1);
                crc = (crc >> 1) ^ (0xEDB88320 & mask);
            }

            table[byte] = crc;
        }
    }

    crc = 0xFFFFFFFF;

    for (int i = 0; i < size; i++)
    {
        byte = (*message++ ^ (crc >> 8)) & 0xFF;
        crc = table[byte] ^ (crc << 8);

        //byte = message[i];
        //crc = (crc >> 8) ^ table[(crc ^ byte) & 0xFF];
    }

    return ~crc;
}

__attribute__((visibility("hidden"))) Length CARFileReadString(FILE *fp, String string)
{
    Length size = 0;
    while (((*string) = fgetc(fp))) string++, size++;
    string -= size;
    return(++size);
}

Length CARFileValidate(FILE *fp)
{
    char magic[3];
    UInt8 version;
    UInt8 flags;
    Length filecount;
    Length fullsize;
    Length extsize;
    UInt32 checksum;

    rewind(fp);
    fread(magic,      sizeof(char),   3, fp);
    fread(&version,   sizeof(UInt8),  1, fp);
    fread(&flags,     sizeof(UInt8),  1, fp);
    fread(&filecount, sizeof(Length), 1, fp);
    fread(&fullsize,  sizeof(Length), 1, fp);
    fread(&extsize,   sizeof(Length), 1, fp);
    fread(&checksum,  sizeof(UInt32), 1, fp);
    rewind(fp);

    bool doCheck = (flags & (1 << 6));
    if (flags & (1 << 7)) return 0;

    if (doCheck)
    {
        Length hsize = fullsize - extsize;
        MemoryAddress hbuf = malloc(hsize);
        fread(hbuf, 1, hsize, fp);
        UInt32 correctCheck = CARGetCRC32(hbuf, hsize);
        if (checksum != correctCheck) return 0;
    }

    rewind(fp);
    return filecount;
}

CFIteratorRef CARFileCreateIterator(CString file)
{
    FILE *fp = fopen(file, "rb");
    if (!fp) return(NULL);

    CFIteratorRef iterator = malloc(sizeof(struct CFIterator));
    iterator->offset = HEADER_SIZE;
    iterator->file = file;
    iterator->fp = fp;

    if (!(iterator->filecount = CARFileValidate(fp)))
    {
        free(iterator);
        fclose(fp);

        return(NULL);
    }

    fseek(iterator->fp, iterator->offset, SEEK_SET);
    return(iterator);
}

struct CARFileEntry *CARFileIteratorGetNext(CFIteratorRef iterator)
{
    struct CARFileEntry *entry = malloc(sizeof(struct CARFileEntry));
    char name[2048];
    entry->namesize = CARFileReadString(iterator->fp, name);
    entry->name = malloc(entry->namesize);
    memcpy(((String)entry->name), name, entry->namesize);
    fread(&entry->offset,   sizeof(Length), 1, iterator->fp);
    fread(&entry->size,     sizeof(Length), 1, iterator->fp);
    fread(&entry->checksum, sizeof(UInt16), 1, iterator->fp);
    iterator->offset += entry->namesize + ENTRY_SIZE;

    return(entry);
}

Length CARFileGetIteratorFileCount(CFIteratorRef iterator)
{
    return iterator->filecount;
}

void CARFileDestroyIterator(CFIteratorRef iterator)
{
    fclose(iterator->fp);
    free(iterator);
}
