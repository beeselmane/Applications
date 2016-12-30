#import "SMOpenGLView.h"
#import <objc/objc.h>

CVReturn SMCustomRunLoop(CVDisplayLinkRef displayLink, const CVTimeStamp *now, const CVTimeStamp *outputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *caller);

@implementation SMOpenGLView

- (void) setup
{
    GLint swapRate = 1;
    [[self openGLContext] setValues:&swapRate forParameter:NSOpenGLCPSwapInterval];

    CGLContextObj contextOBJ = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj pixelFormatOBJ = [[self pixelFormat] CGLPixelFormatObj];

    CVDisplayLinkCreateWithActiveCGDisplays(&self->displayLink);
    CVDisplayLinkSetOutputCallback(self->displayLink, SMCustomRunLoop, (__bridge void *)(self));
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(self->displayLink, contextOBJ, pixelFormatOBJ);
    CVDisplayLinkStart(self->displayLink);
}

- (void) setPaused:(BOOL) paused
{
    if (paused != CVDisplayLinkIsRunning(self->displayLink)) return;

    if (paused) {
        CVDisplayLinkStop(self->displayLink);
    } else {
        CVDisplayLinkStart(self->displayLink);
    }
}

- (void) executeRunLoop
{
    @autoreleasepool
    {
        CGLLockContext([[self openGLContext] CGLContextObj]);
        [[self openGLContext] makeCurrentContext];
        glClearColor(0, 0, 0, 0);
        glClear(GL_COLOR_BUFFER_BIT);

        //NSLog(@"It is now %f", CFAbsoluteTimeGetCurrent());
        SMESystemGetRunLoop()((UInt64)CFAbsoluteTimeGetCurrent());
        glFlush();

        [[self openGLContext] flushBuffer];
        CGLUnlockContext([[self openGLContext] CGLContextObj]);
    }
}

- (void) executeBlockInContext:(void (^)())block
{
    CGLLockContext([[self openGLContext] CGLContextObj]);
    [[self openGLContext] makeCurrentContext];

    block();

    CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

@end
