#import <CommonCrypto/CommonDigest.h>
#import "BlobGenerator.h"

@implementation BlobGenerator
{
    NSFileHandle *randomFileHandle;
}

+ (instancetype) generator
{
    static __strong BlobGenerator *generator = nil;
    static dispatch_once_t predicate = 0;

    dispatch_once(&predicate, ^() {
        generator = [[[self class] alloc] init];
    });

    return generator;
}

- (NSData *) generateBlobOfSize:(NSUInteger)size
{
    randomFileHandle = [NSFileHandle fileHandleForReadingAtPath:@"/dev/random"];
    NSData *data = [randomFileHandle readDataOfLength:size];
    [randomFileHandle closeFile];

    return data;
}

- (NSString *) hexID40
{
    NSData *data = [self generateBlobOfSize:20];
    UInt8 *bytes = (UInt8 *)[data bytes];

    return [NSString stringWithFormat:@
            "%02x%02x%02x%02x"
            "%02x%02x%02x%02x"
            "%02x%02x%02x%02x"
            "%02x%02x%02x%02x"
            "%02x%02x%02x%02x",
            bytes[0],  bytes[1],  bytes[2],  bytes[3],
            bytes[4],  bytes[5],  bytes[6],  bytes[7],
            bytes[8],  bytes[9],  bytes[10], bytes[11],
            bytes[12], bytes[13], bytes[14], bytes[15],
            bytes[16], bytes[17], bytes[18], bytes[19]];
}

- (NSData *) hashForBlob:(NSData *)blob
{
    unsigned char hash[CC_SHA512_DIGEST_LENGTH];

    if (CC_SHA512([blob bytes], (CC_LONG)[blob length], hash)) {
        return [NSData dataWithBytes:hash length:CC_SHA512_DIGEST_LENGTH];
    } else {
        return nil;
    }
}

- (UInt8) character
{
    NSData *data = [self generateBlobOfSize:1];
    return *((UInt8 *)[data bytes]);
}

@end
