#import "LockViewController.h"
#import "BlobGenerator.h"

@implementation LockViewController

@synthesize imageView;
@synthesize mainView;

- (instancetype) init
{
    self = [super init];

    if (self)
    {
        NSUInteger screenHeight = [[UIScreen mainScreen] bounds].size.height;
        NSUInteger screenWidth = [[UIScreen mainScreen] bounds].size.width;
        UIImage *lockImage = [UIImage imageNamed:@"locked"];

        CGFloat desiredWidth = (screenWidth / 5.0F);
        CGFloat currentWidth = [lockImage size].width;
        CGFloat scaleFactor = desiredWidth / currentWidth;

        mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [mainView setBackgroundColor:kLockBGColor];

        CGFloat red   = (CGFloat)[[BlobGenerator generator] character];
        CGFloat green = (CGFloat)[[BlobGenerator generator] character];
        CGFloat blue  = (CGFloat)[[BlobGenerator generator] character];
        [mainView setBackgroundColor:[UIColor colorWithRed:(red / 255.0F) green:(green / 255.0F) blue:(blue / 255.0F) alpha:1.0F]];

        imageView = [[UIImageView alloc] initWithImage:lockImage];
        [imageView setTransform:CGAffineTransformMakeScale(scaleFactor, scaleFactor)];

        CGRect frame = [imageView frame];
        frame.origin.y = (screenHeight - frame.size.height) / 2.0F;
        frame.origin.x = (screenWidth - frame.size.width) / 2.0F;
        [imageView setFrame:frame];

        [mainView addSubview:imageView];
        [self setView:mainView];
    }

    return self;
}

@end
