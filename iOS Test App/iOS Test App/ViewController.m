#import "ViewController.h"
#import "PasswordViewController.h"
#import "UIImage+AverageColor.h"

#define kImageBGColor [UIColor colorWithRed:(1.0F / 13.0F) green:(1.0F / 13.0F) blue:(1.0F / 13.0F) alpha:1.0F]
#define kSBGColor     [UIColor colorWithRed:(38.0F / 255.0F) green:(38.0F / 255.0F) blue:(38.0F / 255.0F) alpha:1.0F]

static __strong ViewController *mvc = nil;

@implementation ViewController
{
    NSString *dataDirectory;
    NSString *ddir, *ldir;

    NSMutableArray *files;
    NSFileManager *fman;

    BOOL finished;
}

@synthesize gifView;

- (BOOL) prefersStatusBarHidden
{
    return finished;
}

- (void) showPWC
{
    pwc = [[PasswordViewController alloc] initWithPasswordType:kPWTNumeric6 andValidationHandler:^(NSString *passcode) {
        return [passcode isEqualToString:@"159735"];
    }];

    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:pwc animated:YES completion:nil];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) finish
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", dataDirectory, @"florian-8.gif"];
    CGFloat angle = M_PI_2;
    BOOL sbg = YES;

    finished = YES;
    [self setNeedsStatusBarAppearanceUpdate];

    UIImage *gifimage = [UIImage imageWithContentsOfFile:path];
    [gifView setContentMode:UIViewContentModeScaleAspectFit];
    [gifView setTransform:CGAffineTransformMakeRotation(angle)];
    [gifView setBackgroundColor:(sbg ? kSBGColor : [gifimage averageColor])];
    [gifView setFrame:[[UIScreen mainScreen] bounds]];
    [gifView setBounds:[[self view] bounds]];
    [gifView setImage:gifimage];

    UIButton *pwb = [UIButton buttonWithType:UIButtonTypeSystem];
    [pwb setTitle:@"Password Input" forState:UIControlStateNormal];
    [pwb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pwb setFrame:CGRectMake(0.0F, [[UIScreen mainScreen] bounds].size.height - 37.5F, [[UIScreen mainScreen] bounds].size.width, 12.0F)];
    [pwb addTarget:self action:@selector(showPWC) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:pwb];

    mvc = self;
}

- (void) presentNext:(NSUInteger)index
{
    if ([files count] <= index)
    {
        [self finish];
        return;
    }

    NSString *file = files[index];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Import" message:[NSString stringWithFormat:@"What would you like to do with %@ in %@?", [file lastPathComponent], [ddir lastPathComponent]] preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Import" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [fman moveItemAtPath:file toPath:[NSString stringWithFormat:@"%@/%@", dataDirectory, [file lastPathComponent]] error:nil];
        [self presentNext:(index + 1)];
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [fman removeItemAtPath:file error:nil];
        [self presentNext:(index + 1)];
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [[self view] setBackgroundColor:kSBGColor];

    ddir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    ldir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    dataDirectory = [ldir stringByAppendingString:@"/Photo Library"];
    fman = [NSFileManager defaultManager];
    files = [NSMutableArray array];
    BOOL directory = NO;

    if (![fman fileExistsAtPath:dataDirectory])
        [fman createDirectoryAtPath:dataDirectory withIntermediateDirectories:YES attributes:nil error:nil];

    for (NSString *file in [fman contentsOfDirectoryAtPath:ddir error:nil])
    {
        NSString *path = [NSString stringWithFormat:@"%@/%@", ddir, file];
        [fman fileExistsAtPath:path isDirectory:&directory];

        if (!([file hasPrefix:@"."] || directory))
            [files addObject:path];
    }

    [self presentNext:0];
}

- (BOOL) shouldAutorotate
{
    return(!pwc);
}

@end
