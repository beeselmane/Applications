#ifndef __AACOMPRESSIONUTILITY__
#define __AACOMPRESSIONUTILITY__ 1

@class AAMemoryBuffer;

typedef enum {
    kAACompressionAlgorithmCopy  = 0,
    kAACompressionAlgorithmGZip  = 1,
    kAACompressionAlgorithmBZip  = 2,
    kAACompressionAlgorithmZip   = 3,
    kAACompressionAlgorithmLZMA2 = 4
} AACompressionAlgorithm;

@interface AACompressor : NSObject
{
    @private
        AACompressionAlgorithm algorithm;
        BOOL compressor;
}

+ (void) decompressBuffer:(AAMemoryBuffer *)buffer withAlgorithm:(AACompressionAlgorithm)algorithm;
+ (void) compressBuffer:(AAMemoryBuffer *)buffer withAlgorithm:(AACompressionAlgorithm)algorithm;

+ (instancetype) decompressorWithAlgorithm:(AACompressionAlgorithm)algorithm;
+ (instancetype) compressorWithAlgorithm:(AACompressionAlgorithm)algorithm;

- (void) passthru:(AAMemoryBuffer *)buffer;

@end

extern const AACompressor *kAACompressorCopy;
extern const AACompressor *kAACompressorGZip;
extern const AACompressor *kAACompressorBZip;
extern const AACompressor *kAACompressorZip;
extern const AACompressor *kAACompressorLZMA2;
extern const AACompressor *kAADecompressorCopy;
extern const AACompressor *kAADecompressorGZip;
extern const AACompressor *kAADecompressorBZip;
extern const AACompressor *kAADecompressorZip;
extern const AACompressor *kAADecompressorLZMA2;

#endif /* !defined(__AACOMPRESSIONUTIL__) */
