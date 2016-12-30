#import "AppDelegate.h"
#import "OpenGLContext.h"

static AppDelegate *gAppDelegate = nil;

@implementation AppDelegate

@synthesize context;

+ (instancetype) delegate
{
    return gAppDelegate;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    gAppDelegate = [super allocWithZone:zone];
    return gAppDelegate;
}

- (BOOL) grabScreen:(NSScreen *)screen
{
    NSDictionary *screenInfo = [screen deviceDescription];
    NSNumber *screenID = [screenInfo objectForKey:@"NSScreenNumber"];
    CGDisplayErr error = CGDisplayCapture([screenID unsignedIntValue]);

    if (error != CGDisplayNoErr) NSLog(@"Error Capturing Display %u!", [screenID unsignedIntValue]);
    return (error == CGDisplayNoErr);
}

- (void) releaseScreens
{
    CGReleaseAllDisplays();
}

- (OpenGLContext *) makeGLContext
{
    NSOpenGLPixelFormatAttribute attributes[] = {
        NSOpenGLPFAFullScreen,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFADepthSize, 32,
        0
    };

    NSOpenGLPixelFormat *format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
    if (!format) return nil;

    return [[OpenGLContext alloc] initWithFormat:format shareContext:NO];
}

- (void) alertFailureWithMessage:(NSString *)message
{
    [self releaseScreens];
    NSAlert *alert = [NSAlert alertWithMessageText:@"Internal Error" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@", message];
    [alert runModal];
    exit(EXIT_FAILURE);
}

- (void) start
{
    BOOL didGetScreen = [self grabScreen:[NSScreen mainScreen]];
    if (!didGetScreen) [self alertFailureWithMessage:@"Could not Capture Screen"];
    context = [self makeGLContext];
    if (!context) [self alertFailureWithMessage:@"Could not create Drawing Context"];
    [context setFullScreen];
    [context makeCurrentContext];
    [context startRunLoop];
}

@end
