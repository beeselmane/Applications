#import <Foundation/Foundation.h>
#import "gga.h"

typedef struct CARFileList CARFileList;

@interface GGCarFile : NSObject
{
    CARFileList *files;
    FILE *file;
}

- (instancetype) initWithFile:(NSString *)path;
- (FileBufferRef) getFile:(NSString *)path;

@end
