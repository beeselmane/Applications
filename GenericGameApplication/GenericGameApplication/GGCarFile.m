#import "GGCarFile.h"
#import "gga.h"
#import "car.h"

struct CARFileList {
    Length size;

    struct CARFileListEntry {
        CString name;
        Length namesize;
        Length size;
        Offset offset;
        UInt16 checksum;
    } **entries;
};

typedef struct CARFileListEntry CARFileListEntry;

@implementation GGCarFile

- (instancetype) initWithFile:(NSString *)path
{
    self = [super init];

    if (self)
    {
        CFIteratorRef iterator = CARFileCreateIterator([path UTF8String]);
        if (!iterator) return nil;

        Length filecount = CARFileGetIteratorFileCount(iterator);
        self->files = malloc(sizeof(struct CARFileList));
        self->files->size = filecount;
        self->files->entries = malloc(sizeof(struct CARFileListEntry *) * filecount);

        for (int i = 0; i < filecount; i++)
        {
            struct CARFileEntry *entry = CARFileIteratorGetNext(iterator);
            self->files->entries[i] = malloc(sizeof(struct CARFileListEntry));
            memcpy(self->files->entries[i], entry, sizeof(struct CARFileListEntry));
            free(entry);
        }

        CARFileDestroyIterator(iterator);
        self->file = fopen([path UTF8String], "rb");
    }

    return(self);
}

- (FileBufferRef) getFile:(NSString *)path
{
    CString pathString = [path UTF8String];

    for (int i = 0; i < self->files->size; i++)
    {
        if (!strncmp(pathString, self->files->entries[i]->name, self->files->entries[i]->namesize))
        {
            CARFileListEntry *entry = self->files->entries[i];
            MemoryAddress buffer = malloc(entry->size);
            fseek(self->file, entry->offset, SEEK_SET);
            fread(buffer, 1, entry->size, self->file);
            FileBufferRef ret = malloc(sizeof(struct FileBuffer));
            ret->size = entry->size;
            ret->data = buffer;
            return(ret);
        }
    }

    return(NULL);
}

@end
