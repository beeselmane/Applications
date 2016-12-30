#import "ViewController.h"
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *rvc = [[ViewController alloc] init];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:rvc];
    [window setOpaque:NO];
    [window setBackgroundColor:[UIColor clearColor]];
    [[rvc view] setOpaque:NO];
    [[rvc view] setBackgroundColor:[UIColor whiteColor]];
    [window makeKeyAndVisible];
    return YES;
}

@end
