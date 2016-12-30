#import <AAArchiveKit/AAMemoryBuffer.h>
#import <AAArchiveKit/AAException.h>

#import <sys/mman.h>

@implementation AAMemoryBuffer

- (instancetype) initWithMemoryAt:(void *)addr ofSize:(size_t)size shouldUnmap:(BOOL)unmap
{
    self = [super init];

    if (self)
    {
        mapunmap = unmap;
        mapaddr = addr;
        mapsize = size;
    }

    return self;
}

- (instancetype) initWithFileAt:(NSString *)path
{
    self = [super init];

    if (self)
    {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *error = nil;

        if (![manager fileExistsAtPath:path]) @throw [AAFileNotFoundException exceptionWithFile:path];
        NSDictionary *attributes = [manager attributesOfItemAtPath:path error:&error];
        if (error) @throw [AAException exceptionWithName:kAAExceptionNameUnknownError reason:[error localizedDescription] userInfo:[error userInfo]];

        int fd = open([path UTF8String], O_RDONLY);
        if (fd == -1) @throw [AAIOError exception];

        mapsize = [attributes fileSize];
        mapaddr = mmap(NULL, mapsize, PROT_READ, MAP_SHARED | MAP_FILE, fd, 0);
        close(fd);

        if (((intptr_t)mapaddr) == -1) @throw [AAMemoryMapError exception];
    }

    return self;
}

- (void *) baseAddress
{
    return mapaddr;
}

- (size_t) fullSize
{
    return mapsize;
}

@end
