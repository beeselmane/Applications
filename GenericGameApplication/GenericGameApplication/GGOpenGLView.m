#import "GGOpenGLView.h"
#import "GGStateObject.h"
#import <OpenGL/gl.h>
#import "gga.h"

CVReturn CVDisplayLinkCallback(CVDisplayLinkRef link, const CVTimeStamp *now, const CVTimeStamp *time, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, MemoryAddress context)
{
    [((__bridge GGOpenGLView *)context) executeRunLoop];

    return kCVReturnSuccess;
}

MemoryAddress GGRequest(int code, MemoryAddress data)
{
    if (code == kGGActionPause) {
        // Uhh.. maybe later?
        return nil;
    } else if (code == kGGActionGetResource) {
        if (!data) return nil;

        CString path = ((CString)data);
        return [GGGetCurrentState()->resourceMap getFile:[NSString stringWithUTF8String:path]];
    } else {
        return nil;
    }
}

@implementation GGOpenGLView

- (void) awakeFromNib
{
    self->paused = NO;
    self->displayLink = nil;
}

- (void) executeRunLoop
{
    @autoreleasepool
    {
        CGLLockContext([[self openGLContext] CGLContextObj]);
        [[self openGLContext] makeCurrentContext];
        glClearColor(0, 0, 0, 0);
        glClear(GL_COLOR_BUFFER_BIT);

        GGGetCurrentState()->executeRunLoop();
        glFlush();
        
        [[self openGLContext] flushBuffer];
        CGLUnlockContext([[self openGLContext] CGLContextObj]);
    }
}

- (void) setup
{
    GLint swapRate = 1;
    [[self openGLContext] setValues:&swapRate forParameter:NSOpenGLCPSwapInterval];

    CGLContextObj contextOBJ = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj pixelFormatOBJ = [[self pixelFormat] CGLPixelFormatObj];

    CVDisplayLinkCreateWithActiveCGDisplays(&self->displayLink);
    CVDisplayLinkSetOutputCallback(self->displayLink, CVDisplayLinkCallback, (__bridge void *)(self));
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(self->displayLink, contextOBJ, pixelFormatOBJ);
    CVDisplayLinkStart(self->displayLink);
}

@end
