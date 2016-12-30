#ifndef __AAEXCEPTION__
#define __AAEXCEPTION__ 1

#import <Foundation/Foundation.h>

#define kAAExceptionUnknown      0xFFFF
#define kAAExceptionFileNotFound 0x0001
#define kAAExceptionMMap         0x0002
#define kAAExceptionIOError      0x0003

extern NSString *const kAAExceptionNameFileNotFound;
extern NSString *const kAAExceptionNameMemoryMap;
extern NSString *const kAAExceptionNameIOError;
extern NSString *const kAAExceptionNameUnknownError;

@interface AAException : NSException
{
    @protected UInt16 error;
}

+ (instancetype) exceptionWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo;
- (NSString *) humanReadableError;
- (UInt16) errorCode;

@end

@interface AAFileNotFoundException : AAException
{
    @private NSString *path;
}

+ (instancetype) exceptionWithFile:(NSString *)path;
- (NSString *) filename;

@end

@interface AAMemoryMapError : AAException

+ (instancetype) exception;

@end

@interface AAIOError : AAException

+ (instancetype) exception;

@end

#endif /* !defined(__AAEXCEPTION__) */
