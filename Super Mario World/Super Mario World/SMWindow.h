#import <Engine/Engine.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/gl.h>

@interface SMWindow : NSWindow <NSWindowDelegate>
{
    @package
        UInt16 buttonFlags;

    @private
        UInt16 upButton, downButton, leftButton, rightButton;
        UInt16 pauseButton;
}

- (void) reloadConfig;

@end
