#import <UIKit/UIKit.h>

@interface UINavigationController (shouldAutorotate)

@end

@implementation UINavigationController (shouldAutorotate)

- (BOOL) shouldAutorotate
{
    if ([[self topViewController] respondsToSelector:@selector(shouldAutorotate)])
        return [[self topViewController] shouldAutorotate];

    return YES;
}

@end
