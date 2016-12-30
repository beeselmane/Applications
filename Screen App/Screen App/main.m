#import <UIKit/UIKit.h>
#import "AppDelegate.h"

extern BOOL IOServiceOpen_RemoveProtection(void);

int main(int argc, char *const *argv, char **environ, char **apple)
{
    @autoreleasepool
    {
        /*if (!IOServiceOpen_RemoveProtection())
        {
            NSLog(@"Error: Could not remove protection from IOServiceOpen()");
            exit(EXIT_FAILURE);
        }*/

        return UIApplicationMain(argc, (char **)argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
