#import "GGAppDelegate.h"
#import "GGOpenGLView.h"

MemoryAddress GGRequest(int code, MemoryAddress data);

@implementation GGAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationWillFinishLaunching:(NSNotification *)notification
{
    NSString *name = [NSString stringWithUTF8String:GGGetCurrentState()->gameName()];
    [window setTitle:name];

    [glView setup];
    GGGetCurrentState()->initGL(GGRequest);
}

@end
