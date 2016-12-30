#import <UIKit/UIKit.h>

@interface CoreUI : NSObject

+ (NSString *) defaultsDomainName;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
