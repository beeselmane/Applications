#import <Foundation/Foundation.h>

@interface BlobGenerator : NSObject

+ (instancetype) generator;

- (NSData *) generateBlobOfSize:(NSUInteger)size;
- (NSString *) hexID40;

- (NSData *) hashForBlob:(NSData *)blob;
- (UInt8) character;

@end
