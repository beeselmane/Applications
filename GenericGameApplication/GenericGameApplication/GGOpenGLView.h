#import <Cocoa/Cocoa.h>

@interface GGOpenGLView : NSOpenGLView
{
    CVDisplayLinkRef displayLink;
    BOOL paused;
}

- (void) executeRunLoop;
- (void) setup;

@end
