#import <Engine/Engine.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/gl.h>

#define SM_CONFIG_DEFAULT_HEIGHT   432
#define SM_CONFIG_DEFAULT_WIDTH    512
#define SM_CONFIG_DEFAULT_UPKEY    'w'
#define SM_CONFIG_DEFAULT_DOWNKEY  's'
#define SM_CONFIG_DEFAULT_LEFTKEY  'a'
#define SM_CONFIG_DEFAULT_RIGHTKEY 'd'
#define SM_CONFIG_DEFAULT_PAUSEKEY '\r'
#define SM_CONFIG_DEFAULT_RUNKEY   '/'
#define SM_CONFIG_DEFAULT_NJUMP    '\\'
#define SM_CONFIG_DEFAULT_SJUMP    ']'
#define SM_CONFIG_DEFAULT_ITEMKEY  '.'

@class SMOpenGLView;
@class SMPrefWindow;
@class SMWindow;

@interface SMAppDelegate : NSObject <NSApplicationDelegate>

@property (strong) IBOutlet SMPrefWindow *PreferenceWindow;
@property (weak) IBOutlet SMOpenGLView *glView;
@property (weak) IBOutlet SMWindow *window;

+ (instancetype) delegate;
- (IBAction)openPreferenceWindow:(NSMenuItem *)sender;
- (IBAction)goFullscreen:(NSMenuItem *)sender;

#pragma mark - Preference Window

- (IBAction)heightBoxChanged:(NSTextField *)sender;
- (IBAction)widthBoxChanged:(NSTextField *)sender;
- (IBAction)resetButtons:(NSButton *)sender;
- (IBAction)changeControl:(NSTextField *)sender;

@property (weak) IBOutlet NSTextField *heightField;
@property (weak) IBOutlet NSTextField *widthField;
@property (weak) IBOutlet NSTextField *upField;
@property (weak) IBOutlet NSTextField *downField;
@property (weak) IBOutlet NSTextField *leftField;
@property (weak) IBOutlet NSTextField *rightField;
@property (weak) IBOutlet NSTextField *runField;
@property (weak) IBOutlet NSTextField *jumpField;
@property (weak) IBOutlet NSTextField *sjumpField;
@property (weak) IBOutlet NSTextField *pauseField;
@property (weak) IBOutlet NSTextField *itemField;

@end
