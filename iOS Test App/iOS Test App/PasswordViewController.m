#import "PasswordViewController.h"
#import "ViewController.h"

#define kFadeColor  [UIColor colorWithRed:1.0F green:1.0F blue:1.0F alpha:kAlphaValue]
#define kAlphaValue 0.7F

@interface NumberedButton : UIButton
{
    @public NSUInteger number;
    UILabel *stview;
}

- (instancetype) initWithNumber:(NSUInteger)number;

@end

@interface CodeView : UIView
{
    UIView *passwordDots[6];
    NSMutableString *input;
    PasswordType type;
}

- (instancetype) initWithType:(PasswordType)type frame:(CGRect)f andValidationHandler:(BOOL (^)(NSString *passcode))handler;

- (void) deleteLastInput:(UIButton *)sender;
- (void) addInput:(NSString *)newInput;

@end

@interface PasswordView ()

@property (strong) UIButton *dismissButton;

- (void) dismiss;

@end

@interface PasswordViewController ()

@property (strong) PasswordView *mainView;

- (void) dismissView;

@end

@implementation PasswordViewController

- (instancetype) initWithPasswordType:(PasswordType)type andValidationHandler:(BOOL (^)(NSString *))handler
{
    self = [super init];

    if (self)
    {
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        [self setView:[[PasswordView alloc] initWithPasswordType:type inController:self withValidationHandler:handler]];
    }

    return self;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) dismissView
{
    ViewController *pvc = (ViewController *)[self presentingViewController];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    pvc->pwc = nil;
}

@end

@implementation PasswordView
{
    UIResponder *controller;
    CodeView *codeView;
    PasswordType type;
}

@synthesize dismissButton;

- (instancetype) initWithPasswordType:(PasswordType)pwt inController:(PasswordViewController *)cntrl withValidationHandler:(BOOL (^)(NSString *))handler
{
    self = [self init];

    if (self)
    {
        controller = cntrl;
        type = pwt;

        [self setFrame:[[UIScreen mainScreen] bounds]];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:kAlphaValue];

        //UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwscreen"]];
        //[bgImage setFrame:[[UIScreen mainScreen] bounds]];
        //[self addSubview:bgImage];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [blurView setFrame:[self bounds]];
        [self addSubview:blurView];

        dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [dismissButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [dismissButton setFrame:CGRectMake(230.0F, 531.0F, 64.0F, 12.0F)];
        [dismissButton addTarget:controller action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dismissButton];

        CGFloat s = 75.0F;
        CGFloat x, y;

        #define ix x += s + 20
        #define iy y += s + 13
        #define rx x = 27.5F
        #define ry y = 162.5F

        #define b(n)    \
            NumberedButton *b ## n = [[NumberedButton alloc] initWithNumber:n];                                             \
            [b ## n addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];    \
            [b ## n setFrame:CGRectMake(x, y, s, s)];                                                                       \
            [self addSubview:b ## n]

        if (type == kPWTNumeric4 || type == kPWTNumeric6 || type == kPWTNumericN) {
            rx;   ry;   b(1); ix;   b(2); ix;
            b(3); rx;   iy;   b(4); ix;   b(5);
            ix;   b(6); rx;   iy;   b(7); ix;
            b(8); ix;   b(9); rx;   iy;   ix;
            b(0);

            codeView = [[CodeView alloc] initWithType:type frame:CGRectMake(0.0F, 100.0F, [[UIScreen mainScreen] bounds].size.width, 38.0F) andValidationHandler:handler];
            [self addSubview:codeView];
        } else {
            //
        }

        UILabel *enterLabel = [[UILabel alloc] initWithFrame:CGRectMake(95.0F, 68.0F, 132.0F, 16.0F)];
        [enterLabel setTextColor:[UIColor whiteColor]];
        [enterLabel setText:@"Enter Passcode"];
        [self addSubview:enterLabel];
    }

    return self;
}

- (void) pressButton:(NumberedButton *)button
{
    [codeView addInput:[NSString stringWithFormat:@"%lu", (unsigned long)button->number]];

    if ([[[dismissButton titleLabel] text] isEqualToString:@"Cancel"])
    {
        [dismissButton removeTarget:controller action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [dismissButton addTarget:codeView action:@selector(deleteLastInput:) forControlEvents:UIControlEventTouchUpInside];
        [dismissButton setTitle:@"Delete" forState:UIControlStateNormal];
    }
}

- (void) dismiss
{
    if ([controller respondsToSelector:@selector(dismissView)]) {
        [controller performSelector:@selector(dismissView)];
    } else {
        NSLog(@"Error: %@ cannot call %s on %@", self, sel_getName(@selector(dismissView)), controller);
        
    }
}

@end

@implementation NumberedButton

- (instancetype) initWithNumber:(NSUInteger)n
{
    self = [super init];

    if (self)
    {
        [self addTarget:self action:@selector(endAnimation) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(endAnimation) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(animatePress) forControlEvents:UIControlEventTouchDown];

        [self setTintColor:[UIColor blackColor]];
        [[self layer] setCornerRadius:37.5F];
        [self setAlpha:kAlphaValue];

        [[self layer] setBorderColor:[kFadeColor CGColor]];
        [[self layer] setBorderWidth:2.0F];

        [[self titleLabel] setFont:[UIFont systemFontOfSize:36.0F weight:0.02F]];
        [[self titleLabel] setTextColor:[UIColor whiteColor]];

        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)n] forState:UIControlStateNormal];

        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(10.0F, 0.0F, 0.0F, 0.0F)];

        switch (n)
        {
            case 0:
            case 1:
                break;

            default: {
                char bc = 'A' + ((n - 2) * 3);
                if (n > 7) bc++;

                CGRect subtitleFrame = [self frame];
                subtitleFrame.origin.y += 45.0F;
                subtitleFrame.size.height = 16.0F;
                subtitleFrame.size.width = 75.0F;

                UILabel *subtitle = [[UILabel alloc] initWithFrame:subtitleFrame];
                [subtitle setFont:[UIFont systemFontOfSize:12.0F weight:0.1F]];
                [subtitle setTextAlignment:NSTextAlignmentCenter];

                if (n != 7 && n != 9) [subtitle setText:[NSString stringWithFormat:@"%c%c%c", bc, bc + 1, bc + 2]];
                else [subtitle setText:[NSString stringWithFormat:@"%c%c%c%c", bc, bc + 1, bc + 2, bc + 3]];

                [subtitle setTextColor:[UIColor whiteColor]];
                [self addSubview:subtitle];
                stview = subtitle;
            } break;
        }

        number = n;
    }

    return self;
}

- (void) animatePress
{
    [UIView transitionWithView:self duration:0.2F options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent animations:^() {
        [self setBackgroundColor:kFadeColor];
    } completion:nil];
}

- (void) endAnimation
{
    [UIView transitionWithView:self duration:0.2F options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent animations:^() {
        [self setBackgroundColor:[UIColor clearColor]];
    } completion:nil];
}

@end

@implementation CodeView
{
    BOOL (^validationHandler)(NSString *passcode);
}

- (instancetype) initWithType:(PasswordType)t frame:(CGRect)f andValidationHandler:(BOOL (^)(NSString *passcode))handler
{
    self = [super initWithFrame:f];

    if (self)
    {
        input = [NSMutableString string];
        validationHandler = handler;
        type = t;

        switch (type)
        {
            case kPWTNumeric4:
            case kPWTNumeric6: {
                UInt8 dots = (type == kPWTNumeric4) ? 4 : 6;
                UInt8 scount = (dots / 2);
                CGFloat separation = 24.0F;
                CGFloat size = 12.5F;

                CGFloat height = [self frame].size.height;
                CGFloat ypos = ((height - size) / 2);
                CGFloat x = ([self frame].size.width / 2) - (separation / 2);
                CGRect frame = CGRectMake(x - (((scount - 1) * separation) + (scount * size)), ypos, size, size);

                for (int i = 0; i < dots; i++)
                {
                    passwordDots[i] = [[UIView alloc] initWithFrame:frame];
                    [[passwordDots[i] layer] setBorderColor:[kFadeColor CGColor]];
                    [[passwordDots[i] layer] setBorderWidth:1.0F];

                    [[passwordDots[i] layer] setCornerRadius:(size / 2)];
                    [passwordDots[i] setTintColor:[UIColor blackColor]];
                    [passwordDots[i] setAlpha:kAlphaValue];

                    [self addSubview:passwordDots[i]];
                    frame.origin.x += size + separation;
                }
            } break;
            case kPWTNumericN: {
                //
            } break;
            case kPWTComplex: {
                //
            } break;
        }
    }

    return self;
}

- (void) deleteLastInput:(UIButton *)sender
{
    NSRange lastInputRange = NSMakeRange([input length] - 1, 1);
    [input deleteCharactersInRange:lastInputRange];

    [UIView transitionWithView:self duration:0.25F options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent animations:^() {
        [passwordDots[lastInputRange.location] setBackgroundColor:[UIColor clearColor]];
    } completion:nil];

    if ([input length] == 0)
    {
        [sender removeTarget:self action:@selector(deleteLastInput:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:[self nextResponder] action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];
    }
}

- (void) addInput:(NSString *)newInput
{
    [input appendString:newInput];

    if (type == kPWTNumeric4 || type == kPWTNumeric6)
    {
        UIView *view = passwordDots[[input length] - 1];

        [UIView transitionWithView:self duration:0.25F options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent animations:^() {
            [view setBackgroundColor:kFadeColor];
        } completion:nil];
    }

    if ((type == kPWTNumeric4 && [input length] == 4) || (type == kPWTNumeric6 && [input length] == 6))
    {
        BOOL isCorrect = validationHandler(input);

        if (isCorrect) {
            [[self nextResponder] performSelector:@selector(dismiss)];
        } else {
            /*CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
            [animation setDuration:0.07F];
            [animation setRepeatCount:4];
            [animation setRemovedOnCompletion:YES];
            [animation setAutoreverses:YES];
            [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([self center].x - 20.0F, [self center].y)]];
            [animation setToValue:[NSValue valueWithCGPoint:CGPointMake([self center].x + 20.0F, [self center].y)]];
            [[self layer] addAnimation:animation forKey:@"position"];*/

            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            [animation setValues:@[@(-50), @(+30), @(-20), @(+20), @(-20), @(+20), @(-10), @(+10), @(-5),  @(5), @(0)]];
            [animation setDuration:0.6F];
            [[self layer] addAnimation:animation forKey:@"shake"];

            [UIView transitionWithView:self duration:0.5F options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent animations:^() {
                for (int i = 0; i < 6; i++)
                    if (passwordDots[i])
                        [passwordDots[i] setBackgroundColor:[UIColor clearColor]];
            } completion:nil];

            do {
                [self deleteLastInput:[[self nextResponder] performSelector:@selector(dismissButton)]];
            } while ([input length]);
        }
    }
}

@end
