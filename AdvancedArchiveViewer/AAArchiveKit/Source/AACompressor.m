#import <AAArchiveKit/AACompressor.h>

const AACompressor *kAACompressorCopy;
const AACompressor *kAACompressorGZip;
const AACompressor *kAACompressorBZip;
const AACompressor *kAACompressorZip;
const AACompressor *kAACompressorLZMA2;
const AACompressor *kAADecompressorCopy;
const AACompressor *kAADecompressorGZip;
const AACompressor *kAADecompressorBZip;
const AACompressor *kAADecompressorZip;
const AACompressor *kAADecompressorLZMA2;

__attribute__((constructor)) static void __init_compressor(void)
{
    //
}

@interface AACompressor (Private)



@end

@implementation AACompressor



@end
