#ifndef __AAMEMORYFILE__
#define __AAMEMORYFILE__ 1

#import <Foundation/Foundation.h>

@interface AAMemoryBuffer : NSObject
{
    @private
        BOOL mapunmap;
        size_t mapsize;
        void *mapaddr;
}

- (instancetype) initWithMemoryAt:(void *)addr ofSize:(size_t)size shouldUnmap:(BOOL)unmap;
- (instancetype) initWithFileAt:(NSString *)path;

- (void *) baseAddress;
- (size_t) fullSize;

@end

#endif /* !defined(__AAMEMORYFILE__) */
