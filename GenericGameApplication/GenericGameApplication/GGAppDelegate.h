#import <Cocoa/Cocoa.h>
#import "GGStateObject.h"

@class GGOpenGLView;

@interface GGAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) IBOutlet GGOpenGLView *glView;

@end

