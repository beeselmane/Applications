/*#import "HIDKeyboardInterface.h"
#import <IOKit/hid/IOHIDManager.h>
#import <IOKit/hid/IOHIDKeyboard.h>

static IOHIDKeyboard keyboard;

@implementation HIDKeyboardInterface

- (instancetype) init
{
    self = [super init];

    if (self)
    {
        IOHIDManagerRef manager = IOHIDManagerCreate(kCFAllocatorSystemDefault, 0);

        CFRelease(manager);
    }

    return self;
}

- (BOOL) isKeyDown:(unsigned char)key
{
    //
}

@end
*/