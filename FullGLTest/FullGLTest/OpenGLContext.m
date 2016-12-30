#import "OpenGLContext.h"
#import <OpenGL/gl.h>

static NSOpenGLPixelFormat *pixelFormat;
static OpenGLContext *context;

@implementation OpenGLContext

CVReturn CVDisplayLinkCallback(CVDisplayLinkRef link, const CVTimeStamp *now, const CVTimeStamp *time, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *data)
{
    [context executeRunLoop];
    return kCVReturnSuccess;
}

- (instancetype) initWithFormat:(NSOpenGLPixelFormat *)format shareContext:(NSOpenGLContext *)share
{
    self = [super initWithFormat:format shareContext:share];
    if (self) pixelFormat = format;
    return self;
}

- (void) startRunLoop
{
    context = self; GLint rate = 1;
    [self setValues:&rate forParameter:NSOpenGLCPSwapInterval];
    CVDisplayLinkRef link;

    CVDisplayLinkCreateWithActiveCGDisplays(&link);
    CVDisplayLinkSetOutputCallback(link, CVDisplayLinkCallback, nil);
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(link, [self CGLContextObj], [pixelFormat CGLPixelFormatObj]);
    CVDisplayLinkStart(link);
}

- (void) executeRunLoop
{
    @autoreleasepool
    {
        CGLLockContext([self CGLContextObj]);

        NSLog(@"aaa");

        CGLUnlockContext([self CGLContextObj]);
    }
}

@end
