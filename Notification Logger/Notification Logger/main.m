#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSLog(@"Callback detected: \n\t name: %@ \n\t object:%@", name, object);
}

int main(int argc, char **argv)
{
    @autoreleasepool
    {
        CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, notificationCallback, NULL, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
