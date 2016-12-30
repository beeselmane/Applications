#import "CIStatusBarViewController.h"
#import "CIStatusBar.h"
#import "UIStatusBar.h"
#import "OSArtwork.h"

static CGFloat statusBarHeight = 0.0F;
static CGFloat screenWidth = 0.0F;

@implementation CIStatusBarViewController
{
    UIVisualEffectView *effectView;
}

+ (void) initialize
{
    static dispatch_once_t predicate = 0;

    dispatch_once(&predicate, ^() {
        statusBarHeight = [[[UIApplication sharedApplication] statusBar] frame].size.height;
        screenWidth = [[UIScreen mainScreen] bounds].size.width;
    });
}

- (void) viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [[self view] setOpaque:NO];
    [super viewDidLoad];

    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [bgView setBounds:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:bgView];

    effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [effectView setFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:effectView];

    UIImage *statusBarFadeImage = [UIImage imageNamed:@"SBG"];

    UIStatusBar *statusBar = [[UIApplication sharedApplication] statusBar];
    [statusBar setFrame:CGRectMake(0.0F, 40.0F, screenWidth, statusBarHeight)];
    [statusBar setForegroundColor:[UIColor whiteColor]];
    [statusBar setBackgroundColor:[UIColor clearColor]];

    UIImageView *uiStatusBarBgView = [[UIImageView alloc] initWithImage:statusBarFadeImage];
    [uiStatusBarBgView setFrame:[statusBar frame]];
    [[self view] addSubview:uiStatusBarBgView];

    CIStatusBar *ciStatusBar = [[CIStatusBar alloc] initWithFrame:CGRectMake(0.0F, 120.0F, screenWidth, statusBarHeight)];
    [ciStatusBar setForegroundColor:[UIColor whiteColor]];
    [statusBar setBackgroundColor:[UIColor clearColor]];

    UIImageView *ciStatusBarBgView = [[UIImageView alloc] initWithImage:statusBarFadeImage];
    [ciStatusBarBgView setFrame:[ciStatusBar frame]];
    [[self view] addSubview:ciStatusBarBgView];
    [[self view] addSubview:ciStatusBar];
}

@end
