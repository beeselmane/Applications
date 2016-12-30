#import <Foundation/Foundation.h>
#import <IOKit/hid/HIDLib.h>

@interface HIDKeyboardInterface : NSObject

- (BOOL) isKeyDown:(unsigned char)key;

@end
