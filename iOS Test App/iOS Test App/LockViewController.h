#import <UIKit/UIKit.h>

#define kLockBGColor [UIColor colorWithRed:(38.0F / 255.0F) green:(38.0F / 255.0F) blue:(38.0F / 255.0F) alpha:1.0F]

@interface LockViewController : UIViewController

@property (strong) UIImageView *imageView;
@property (strong) UIView *mainView;

- (instancetype) init;

@end
