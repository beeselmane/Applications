#import <Engine/Engine.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/gl.h>

@interface SMOpenGLView : NSOpenGLView
{
    @private
        CVDisplayLinkRef displayLink;
}

- (void) setPaused:(BOOL) paused;
- (void) executeRunLoop;
- (void) setup;

- (void) executeBlockInContext:(void (^)())block;

@end
