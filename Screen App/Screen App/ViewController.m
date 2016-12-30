#import "ViewController.h"

@interface UIImage (ScreenImage)

+ (instancetype) screenImage;

@end

@interface ViewController (Private)

- (void) saveScreenshotWith3SecondDelay:(id)sender;

@end

@implementation ViewController

- (void) saveScreenshotWith3SecondDelay:(id)sender
{
    /*dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0F * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^() {
        UIImageWriteToSavedPhotosAlbum(_UICreateScreenUIImage(), nil, nil, nil);
    });*/

    UIImageWriteToSavedPhotosAlbum([UIImage screenImage], nil, nil, nil);
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    UIButton *screenshotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [screenshotButton setTitle:@"Screenshot" forState:UIControlStateNormal];

    //CGFloat height = [screenshotButton frame].size.height;
    //CGFloat width = [screenshotButton frame].size.width;
    [screenshotButton setFrame:CGRectMake(100, 100, 100, 100)];

    [screenshotButton addTarget:self action:@selector(saveScreenshotWith3SecondDelay:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:screenshotButton];
}

@end
