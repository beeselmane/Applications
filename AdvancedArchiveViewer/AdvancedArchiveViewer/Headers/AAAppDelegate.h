@class AAArchiveWindowController;

@interface AAAppDelegate : NSObject <NSApplicationDelegate>

@property (strong, atomic) NSMutableArray *windowControllers;

+ (instancetype) delegate;

@end
