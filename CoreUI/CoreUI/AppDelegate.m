#import "CIStatusBarViewController.h"
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:[[CIStatusBarViewController alloc] init]];
    [_window setBackgroundColor:[UIColor clearColor]];
    [_window makeKeyAndVisible];
    [_window setOpaque:NO];

    return YES;
}

@end
