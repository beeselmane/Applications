#import <IOSurface/IOSurfaceAccelerator.h>
#import <IOMobileFrameBuffer.h>
#import <IOSurface/IOSurface.h>
#import <UIKit/UIKit.h>

#import <CoreVideo/CoreVideo.h>

@interface UIImage (ScreenImage)

+ (instancetype) screenImage;

@end

@implementation UIImage (ScreenImage)

+ (instancetype) screenImage;
{
    IOMobileFramebufferConnection connect;
    IOSurfaceRef screenSurface = NULL;
    kern_return_t result;

    io_service_t framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOMobileFramebuffer"));

    if (!framebufferService) framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleH1CLCD"));
    if (!framebufferService) framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleM2CLCD"));
    if (!framebufferService) framebufferService = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleCLCD"));

    result = IOMobileFramebufferOpen(framebufferService, mach_task_self(), 0, &connect);
    result = IOMobileFramebufferGetLayerDefaultSurface(connect, 0, &screenSurface);
    io_connect_t fbConnection = *(io_connect_t *)((uint8_t *)connect + 20);

    IOSurfaceID surfaceID;
    uint32_t outCount = 1;
    IOConnectCallScalarMethod(fbConnection, 3, (uint64_t [2]){0, 0}, 2, (uint64_t *)&surfaceID, &outCount);
    screenSurface = IOSurfaceLookup(surfaceID);

    io_service_t fbService = *(io_service_t *)((uint8_t *)connect + 16);
    mach_port_t surfacePort;
    IOServiceOpen(fbService, mach_task_self(), 0, &surfacePort);

    IOMobileFramebufferDisplaySize screenSize;
    result = IOMobileFramebufferGetDisplaySize(connect, &screenSize);

    BOOL isMainScreen;
    result = IOMobileFramebufferIsMainDisplay(connect, &isMainScreen);
    NSLog(@"%d", isMainScreen);

    uint32_t aseed;
    IOSurfaceLock(screenSurface, kIOSurfaceLockReadOnly, &aseed);
    size_t width = screenSize.width;
    size_t height = screenSize.height;
    NSLog(@"%lu, %lu", width, height);
    //int m_width = 320;
    //int m_height = 480;
    CFMutableDictionaryRef dict;
    int pitch = (int)width * 4, size = (int)width * (int)height * 4;
    int bPE = 4;
    char pixelFormat[4] = {'A','R','G','B'};

    dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(dict, kIOSurfaceIsGlobal, kCFBooleanTrue);
    CFDictionarySetValue(dict, kIOSurfaceBytesPerRow, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &pitch));
    CFDictionarySetValue(dict, kIOSurfaceBytesPerElement, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bPE));
    CFDictionarySetValue(dict, kIOSurfaceWidth, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &width));
    CFDictionarySetValue(dict, kIOSurfaceHeight, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &height));
    CFDictionarySetValue(dict, kIOSurfacePixelFormat, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, pixelFormat));
    CFDictionarySetValue(dict, kIOSurfaceAllocSize, CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &size));
    
    IOSurfaceRef destSurf = IOSurfaceCreate(dict);

    IOSurfaceAcceleratorRef outAcc;
    IOSurfaceAcceleratorCreate(NULL, 0, &outAcc);
    IOSurfaceAcceleratorTransferSurface(outAcc, screenSurface, destSurf, dict, NULL);
    IOSurfaceUnlock(screenSurface, kIOSurfaceLockReadOnly, &aseed);
    CFRelease(outAcc);

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, IOSurfaceGetBaseAddress(destSurf), (width * height * 4), NULL);
    CGImageRef cgImage = CGImageCreate(width, height, 8,
                                     8*4, IOSurfaceGetBytesPerRow(destSurf),
                                     CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst |kCGBitmapByteOrder32Little,
                                     provider, NULL,
                                     YES, kCGRenderingIntentDefault);
    return [UIImage imageWithCGImage:cgImage];
}

@end
