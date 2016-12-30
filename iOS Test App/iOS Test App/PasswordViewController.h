#import <UIKit/UIKit.h>

typedef enum {
    kPWTNumeric4,
    kPWTNumeric6,
    kPWTNumericN,
    kPWTComplex
} PasswordType;

@class NumberedButton;

@interface PasswordViewController : UIViewController

- (instancetype) initWithPasswordType:(PasswordType)type andValidationHandler:(BOOL (^)(NSString *passcode))handler;

@end

@interface PasswordView : UIView

- (instancetype) initWithPasswordType:(PasswordType)pwt inController:(PasswordViewController *)controller withValidationHandler:(BOOL (^)(NSString *passcode))handler;
- (void) pressButton:(NumberedButton *)button;

@end
