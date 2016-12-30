#import <Cocoa/Cocoa.h>

@class OpenGLContext;

@interface AppDelegate : NSObject <NSApplicationDelegate>

+ (instancetype) delegate;
- (void) start;

@property (strong) OpenGLContext *context;

@end

