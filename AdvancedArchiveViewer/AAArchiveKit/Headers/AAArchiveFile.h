#ifndef __AAARCHIVE__
#define __AAARCHIVE__ 1

#import <Foundation/Foundation.h>

@class AAMemoryBuffer;

@interface AAArchiveFile : NSObject

+ (BOOL) canIncludeDirectories;
+ (BOOL) supportsAddingFiles;
+ (BOOL) mayBeCompressed;

- (instancetype) initWithMemoryFile:(AAMemoryBuffer *)file;
- (instancetype) initWithFileAtPath:(NSString *)path;

- (void) extractDirectory:(NSString *)name toPath:(NSString *)path;
- (void) extractFile:(NSString *)name toFile:(NSString *)outfile;
- (NSArray *) gatherFileList;

@end

#endif /* !defined(__AAARCHIVE__) */
