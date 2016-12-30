#import <MobileCoreServices/MobileCoreServices.h>
#import "UIBViewController.h"

static UIBlurEffectStyle blurStyles[3] = {UIBlurEffectStyleExtraLight,
                                          UIBlurEffectStyleLight,
                                          UIBlurEffectStyleDark};

@implementation UIBViewController

@synthesize backgroundView;

- (UILabel *) genericLabel
{
    UILabel *label = [UILabel new];
    [label setFont:[UIFont systemFontOfSize:50.0F]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Label"];
    [label sizeToFit];
    return label;
}

- (void) generateSubviews
{
    CGFloat effectViewWidth = [[UIScreen mainScreen] bounds].size.width / 2.0F;
    CGFloat y = 0.0F;

    NSUInteger effectViewHeightN = [[UIScreen mainScreen] bounds].size.height / 3;
    CGFloat effectViewHeight = [[UIScreen mainScreen] bounds].size.height / 3.0F;
    bool adjustHeight = NO;

    if (effectViewHeight - effectViewHeightN)
    {
        effectViewHeight = effectViewHeightN;
        adjustHeight = YES;
    }

    UILabel *label = [self genericLabel];
    CGSize labelSize = [label frame].size;
    CGFloat lbY = (effectViewHeightN - labelSize.height) / 2.0F;
    CGFloat lbX = (effectViewWidth - labelSize.width) / 2.0F;

    for (NSInteger i = 0; i < 3; i++)
    {
        if (adjustHeight && (i == 0 || i == 2)) effectViewHeight += 0.5F;

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyles[i]];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [blurView setFrame:CGRectMake(0.0F, y, effectViewWidth, effectViewHeight)];
        [[self view] addSubview:blurView];

        UIVisualEffectView *blurViewV = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        [blurViewV setFrame:CGRectMake(effectViewWidth, y, effectViewWidth, effectViewHeight)];
        [vibrancyView setFrame:[blurViewV bounds]];
        [[blurViewV contentView] addSubview:vibrancyView];
        [[self view] addSubview:blurViewV];

        UILabel *bLabel = [self genericLabel];
        UILabel *vLabel = [self genericLabel];

        [vLabel setFrame:CGRectMake(lbX, lbY, labelSize.width, labelSize.height)];
        [bLabel setFrame:CGRectMake(lbX, lbY, labelSize.width, labelSize.height)];

        [[vibrancyView contentView] addSubview:vLabel];
        [[blurView contentView] addSubview:bLabel];

        y += effectViewHeight;
        if (adjustHeight && (i == 0 || i == 2)) effectViewHeight -= 0.5F;
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    backgroundView = [[UIImageView alloc] initWithImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [self setView:backgroundView];
    [self generateSubviews];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (backgroundView) return;

    UIImagePickerController *backgroundPicker = [[UIImagePickerController alloc] init];
    [backgroundPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [backgroundPicker setModalPresentationStyle:UIModalPresentationCurrentContext];
    [backgroundPicker setMediaTypes:@[(__bridge NSString *)kUTTypeImage]];
    [backgroundPicker setDelegate:self];

    [self presentViewController:backgroundPicker animated:NO completion:nil];
}

- (void) viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [super viewDidLoad];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
