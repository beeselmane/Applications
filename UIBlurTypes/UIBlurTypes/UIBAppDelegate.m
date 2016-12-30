#import "UIBViewController.h"
#import "UIBAppDelegate.h"

@implementation UIBAppDelegate

@synthesize window;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:[[UIBViewController alloc] init]];
    [window makeKeyAndVisible];

    return YES;
}

@end
