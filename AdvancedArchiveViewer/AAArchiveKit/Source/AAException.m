#import <AAArchiveKit/AAException.h>

// Yes, I know these are immutable anyway - I just like to have it explicitly defined
NSString *const kAAExceptionNameFileNotFound = @"File Not Found Error";
NSString *const kAAExceptionNameMemoryMap    = @"Memory Map Error";
NSString *const kAAExceptionNameUnknownError = @"Unknown Error";
NSString *const kAAExceptionNameIOError      = @"IO Error";

@interface AAException (Private)

+ (NSString *) errorString:(UInt16)error;

- (instancetype) initWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo andErrorCode:(UInt16)errorCode;

@end

@implementation AAException

+ (instancetype) exceptionWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo
{
    return [[super alloc] initWithName:name reason:reason userInfo:userInfo andErrorCode:kAAExceptionUnknown];
}

- (instancetype) initWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo andErrorCode:(UInt16)errorCode
{
    self = [super initWithName:name reason:reason userInfo:userInfo];
    if (self) error = errorCode;
    return self;
}

+ (NSString *) errorString:(UInt16)error
{
    switch (error)
    {
        case kAAExceptionUnknown:       return @"Internal Error (Error Unknown)";
        case kAAExceptionFileNotFound:  return @"File not Found";
        case kAAExceptionIOError:       return @"File I/O Error";
        case kAAExceptionMMap:          return @"Computer Memory Error";
        default:                        return @"Invalid Exception!!";
    }
}

- (NSString *) humanReadableError
{
    return [AAException errorString:error];
}

- (UInt16) errorCode
{
    return error;
}

@end

@implementation AAFileNotFoundException

+ (instancetype) exceptionWithFile:(NSString *)path
{
    AAFileNotFoundException *this = [[super alloc] initWithName:kAAExceptionNameFileNotFound reason:[AAException errorString:kAAExceptionFileNotFound] userInfo:@{@"File" : path} andErrorCode:kAAExceptionFileNotFound];
    if (this) this->path = path;
    return this;
}

- (NSString *) filename
{
    return path;
}

@end

@implementation AAMemoryMapError

+ (instancetype) exception
{
    return [[super alloc] initWithName:kAAExceptionNameMemoryMap reason:[AAException errorString:kAAExceptionMMap] userInfo:nil andErrorCode:kAAExceptionMMap];
}

@end

@implementation AAIOError

+ (instancetype) exception
{
    return [[super alloc] initWithName:kAAExceptionNameIOError reason:[AAException errorString:kAAExceptionIOError] userInfo:nil andErrorCode:kAAExceptionIOError];
}

@end
