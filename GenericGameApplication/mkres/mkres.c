#include <sys/stat.h>
#include <stdbool.h>
#include <unistd.h>
#include <dirent.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef uint8_t  UInt8;
typedef uint16_t UInt16;
typedef uint32_t UInt32;
typedef uint64_t UInt64;

typedef int8_t  SInt8;
typedef int16_t SInt16;
typedef int32_t SInt32;
typedef int64_t SInt64;

typedef void *MemoryAddress;
typedef char *CString;
typedef UInt64 Offset;
typedef UInt64 Size;

#define CAR_EXPORT  __attribute__((visibility("default")))
#define CAR_PRIVATE __attribute__((visibility("hidden")))
#define NORETURN    __attribute__((noreturn))

#define HEADER_SIZE 33
#define ENTRY_SIZE  18
#define EXTENSION   ".res"

struct __LLENT;

typedef struct __LLENT {
    CString value;
    Size fileSize;
    struct __LLENT *next;
} *LinkedListEntry;

typedef struct __LinkedList {
    LinkedListEntry first, last;
    Size length;
} *LinkedList;

NORETURN static void usage(const char *name)
{
    printf("Usage: %s -fc directory <output>\n", name);
    printf("          -f: Fast\n"                    );
    printf("          -c: Include Checksums\n"       );

    exit(EXIT_SUCCESS);
}

CAR_PRIVATE bool CreateCAR(CString rootdir, CString car, CString *error, bool verbose, bool checksum);

int main(int argc, char *argv[])
{
    if (argc != 3 && argc != 4) usage(argv[0]);
    if (argv[1][0] != '-') usage(argv[0]);
    if (argv[1][2] != 0x0) usage(argv[0]);

    CString res;

    if (argc == 3) {
        Size dirsize = strlen(argv[2]), extsize = strlen(EXTENSION);
        res = malloc(dirsize + extsize + 1);
        memcpy(res, argv[2], dirsize);
        memcpy((res + dirsize), EXTENSION, extsize);
        res[dirsize + extsize] = 0;
    } else {
        res = argv[3];
    }

    bool fast = argv[1][1] == 'f';
    CString error = malloc(2048);

    if (!CreateCAR(argv[2], res, &error, true, !fast))
    {
        printf("Error: %s\n", error);
        return(1);
    }

    return(0);
}

CAR_PRIVATE Size GetFileNameSizes(LinkedList list, Size offset)
{
    LinkedListEntry entry = list->first;
    Size size = 0;

    while (entry)
    {
        size += strlen(entry->value + offset) + 1;
        entry = entry->next;
    }
    
    return(size);
}

CAR_PRIVATE LinkedList LLMake()
{
    LinkedList list = malloc(sizeof(struct __LinkedList));
    list->first = NULL;
    list->last = NULL;
    list->length = 0;
    return(list);
}

CAR_PRIVATE void LLKill(LinkedList list)
{
    LinkedListEntry entry = list->first, next = NULL;
    
    while (entry)
    {
        next = entry->next;
        free(entry);
        entry = next;
    }
    
    free(list);
}

CAR_PRIVATE bool LLHas(LinkedList list, CString value)
{
    LinkedListEntry entry = list->first;
    while (entry) if (!strcmp(entry->value, value)) return(true);
    return(false);
}

CAR_PRIVATE void LLAdd(LinkedList list, CString label)
{
    LinkedListEntry entry = malloc(sizeof(struct __LLENT));
    entry->value = label;
    entry->next = NULL;
    if (list->last) list->last->next = entry;
    else list->first = entry;
    list->last = entry;
    list->length++;
}

CAR_PRIVATE void LLTake(LinkedList list, CString value)
{
    LinkedListEntry entry = list->first, last = NULL;
    
    while (entry)
    {
        if (!strcmp(entry->value, value))
        {
            if (last == NULL) {
                list->first = entry->next;
                free(entry);
            } else {
                if (entry->next == NULL) list->last = last;
                last->next = entry->next;
                free(entry);
            }
        }
        
        entry = entry->next;
    }
}

CAR_PRIVATE Size AddDirectory(CString directory, LinkedList list, CString *error, bool verbose)
{
    if (access(directory, R_OK | X_OK))
    {
        (*error) = "Permissions";
        if (verbose) fprintf(stderr, "*** Error: Could not access directory: %s ***\n*** Stop. ***\n", directory);
        return(false);
    }
    
    DIR *dir;
    Size ret = 0;
    struct dirent *entry;
    dir = opendir(directory);
    Size directroyNameSize = strlen(directory);
    
    if (dir) {
        while ((entry = readdir(dir)))
        {
            if ((entry->d_name[0] == '.' && entry->d_name[1] == 0) || (entry->d_name[0] == '.' && entry->d_name[1] == '.' && entry->d_name[2] == 0)) continue;
            
            Size fullSize = directroyNameSize + strlen(entry->d_name) + 1;
            CString fullName = malloc((sizeof(char) * fullSize) + 1);
            sprintf(fullName, "%s/%s", directory, entry->d_name);
            
            struct stat stats;
            stat(fullName, &stats);
            
            if (stats.st_mode & S_IFDIR) {
                Size newDir = AddDirectory(fullName, list, error, verbose);
                if (newDir == -1) return(-1);
                ret += newDir;
            } else if (stats.st_mode & S_IFREG) {
                if (access(fullName, R_OK))
                {
                    (*error) = "Permissions";
                    if (verbose) fprintf(stderr, "*** Error: Could not access file: %s ***\n*** Stop. ***\n", fullName);
                    return(-1);
                }
                
                if (verbose) printf("L %s\n", fullName);
                LLAdd(list, fullName);
                list->last->fileSize = stats.st_size;
                ret += stats.st_size;
            } else {
                (*error) = "File Type";
                if (verbose) fprintf(stderr, "*** Error: Invalid File Type 0x%X for file %s ***\n*** Stop. ***\n", stats.st_mode, fullName);
                return(-1);
            }
        }
        
        closedir(dir);
    } else {
        (*error) = "Memory";
        if (verbose) fprintf(stderr, "*** Error: Could not open directory %s ***\n*** Stop. ***\n", directory);
        return(-1);
    }
    
    return(ret);
}


CAR_PRIVATE UInt32 GetCRC32(unsigned char *message, Size size)
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
        byte = message[i];
        crc = (crc >> 8) ^ table[(crc ^ byte) & 0xFF];
    }
    
    return ~crc;
}

CAR_PRIVATE UInt16 WriteString(FILE *fp, CString string)
{
    UInt16 length = 0;
    while ((*string)) fputc((*string++), fp), length++;
    fputc(0, fp);
    return(++length);
}

/*
 * Generate CAR File with contents of `rootdir`
 * Adds all files from all subdirectories preserving heiarchy
 *
 * Steps:
 *   1: Check if the output file is accessible
 *   2: Generate list of files to create archive with
 *        * Fails if access is denied to any file or directory
 *   3: Generate Table of Contents and dump file data into archive
 */
CAR_PRIVATE bool CreateCAR(CString rootdir, CString car, CString *error, bool verbose, bool doChecksum)
{
    if (verbose) printf("1. Checking Access...\n");
    FILE *fp;
    
    if (!doChecksum) fp = fopen(car, "wb");
    else           fp = fopen(car, "rb+");
    
    if (!fp)
    {
        (*error) = "Could not open output file!";
        if (verbose) fprintf(stderr, "*** Error: Could not open output file ***\n*** Stop. ***\n");
        return(false);
    }
    
    if (verbose) printf("Done.\n");
    if (verbose) printf("2. Listing Files...\n");

    LinkedList list = LLMake();
    Size extsize = AddDirectory(rootdir, list, error, verbose);
    
    if (extsize == -1)
    {
        fclose(fp);
        unlink(car);
        return(false);
    }
    
    if (verbose) printf("3. Creating Archive...\n");
    
    Offset shift = strlen(rootdir);
    LinkedListEntry entry = list->first;
    Size nameSizes = GetFileNameSizes(list, shift);
    
    char magic[3] = {'C', 'A', 'R'};
    UInt8 version = 1;
    UInt8 flags = 0;
    if (doChecksum) flags |= (1 << 6);
    //if (BIG_ENDIAN) flags |= (1 << 7);
    Size filecount = list->length;
    Size fullsize = extsize + HEADER_SIZE + (ENTRY_SIZE * list->length) + nameSizes;
    UInt32 checksum = 0;
    
    fwrite(magic,       sizeof(char),   3, fp);
    fwrite(&version,    sizeof(UInt8),  1, fp);
    fwrite(&flags,      sizeof(UInt8),  1, fp);
    fwrite(&filecount,  sizeof(UInt64), 1, fp);
    fwrite(&fullsize,   sizeof(Size),   1, fp);
    fwrite(&extsize,    sizeof(Size),   1, fp);
    Offset checkoff = ftell(fp);
    fwrite(&checksum,   sizeof(UInt32), 1, fp);
    
    Offset currentOffset = ftell(fp);
    Offset dataPtr = HEADER_SIZE + (ENTRY_SIZE * list->length) + nameSizes;
    
    for (int i = 0; i < list->length; i++)
    {
        if (verbose) printf("A %s\n", ((entry->value) + shift));
        fseek(fp, currentOffset, SEEK_SET);
        
        FILE *f = fopen(entry->value, "rb");
        MemoryAddress fileData = malloc(entry->fileSize);
        fread(fileData, 1, entry->fileSize, f);
        fclose(f);

        CString name = ((entry->value) + shift);
        Offset data = dataPtr;
        Size size = entry->fileSize;
        UInt16 checksum = (doChecksum ? GetCRC32(fileData, size) : 0);

        UInt16 strLen = WriteString(fp, name);
        fwrite(&data,     sizeof(Offset), 1, fp);
        fwrite(&size,     sizeof(Size),   1, fp);
        fwrite(&checksum, sizeof(UInt16), 1, fp);

        fseek(fp, dataPtr, SEEK_SET);
        fwrite(fileData, 1, entry->fileSize, fp);
        free(fileData);

        currentOffset += ENTRY_SIZE + strLen;
        dataPtr += entry->fileSize;
        entry = entry->next;
    }
    
    if (doChecksum)
    {
        Size readSize = currentOffset;
        rewind(fp);
        MemoryAddress buffer = malloc(readSize);
        fread(buffer, 1, readSize, fp);
        checksum = GetCRC32(buffer, readSize);
        fseek(fp, checkoff, SEEK_SET);
        fwrite(&checksum, sizeof(UInt32), 1, fp);
        rewind(fp);
        fflush(fp);
    }
    
    fclose(fp);
    return(true);
}
