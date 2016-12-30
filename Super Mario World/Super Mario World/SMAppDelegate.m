#import "SMAppDelegate.h"
#import "SMPrefWindow.h"
#import "SMWindow.h"

extern void SMConfigSetHeight(UInt32 new);
extern void SMConfigSetWidth(UInt32 new);
extern void SMConfigSetUp(UInt16 new);
extern void SMConfigSetDown(UInt16 new);
extern void SMConfigSetLeft(UInt16 new);
extern void SMConfigSetRight(UInt16 new);
extern void SMConfigSetPause(UInt16 new);
extern void SMConfigSetRun(UInt16 new);
extern void SMConfigSetNJump(UInt16 new);
extern void SMConfigSetSJump(UInt16 new);
extern void SMConfigSetItem(UInt16 new);
extern void SMConfigGoDefault();

static SMAppDelegate *delegate;

@implementation SMAppDelegate

@synthesize PreferenceWindow = preferenceWindow;
@synthesize window;

- (void) applicationWillFinishLaunching:(NSNotification *)notification
{
    delegate = self;

    SMEConfigRef config = SMEConfigGetDefault();
    UInt32 height = SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_WINDOW_HEIGHT), UInt32);
    UInt32 width  = SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_WINDOW_WIDTH),  UInt32);

    NSRect bounds = [window frame];
    bounds.size.height = height;
    bounds.size.width  = width;
    [window setFrame:bounds display:YES];
    [window makeKeyAndOrderFront:nil];
    [window makeMainWindow];

    [self loadPrefDefaults];
}

- (void) applicationDidFinishLaunching:(NSNotification *)notification
{
    if (!SMESystemGetInitilizeGLCallback()([window frame].size.height, [window frame].size.width))
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"An Error Occurred During initilization!"];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert runModal];
        
        exit(EXIT_FAILURE);
    }
}

+ (instancetype) delegate
{
    return delegate;
}

- (IBAction)openPreferenceWindow:(NSMenuItem *)sender
{
    [preferenceWindow makeKeyAndOrderFront:nil];
}

- (IBAction)goFullscreen:(NSMenuItem *)sender
{
}

#pragma mark - Preference Window

@synthesize widthField;
@synthesize heightField;
@synthesize upField;
@synthesize downField;
@synthesize leftField;
@synthesize rightField;
@synthesize runField;
@synthesize jumpField;
@synthesize sjumpField;
@synthesize pauseField;
@synthesize itemField;

- (void) loadPrefDefaults
{
    SMControlFieldFormatter *controlFormatter = [[SMControlFieldFormatter alloc] init];
    [upField setFormatter:controlFormatter];
    [downField setFormatter:controlFormatter];
    [leftField setFormatter:controlFormatter];
    [rightField setFormatter:controlFormatter];
    [runField setFormatter:controlFormatter];
    [jumpField setFormatter:controlFormatter];
    [sjumpField setFormatter:controlFormatter];
    [pauseField setFormatter:controlFormatter];
    [itemField setFormatter:controlFormatter];

    SMEConfigRef config = SMEConfigGetDefault();
    [widthField  setStringValue:[NSString stringWithFormat:@"%u", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_WINDOW_WIDTH),  UInt32)]];
    [heightField setStringValue:[NSString stringWithFormat:@"%u", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_WINDOW_HEIGHT), UInt32)]];
    [upField     setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_UP_BUTTON),     UInt16)] uppercaseString]];
    [downField   setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_DOWN_BUTTON),   UInt16)] uppercaseString]];
    [leftField   setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_LEFT_BUTTON),   UInt16)] uppercaseString]];
    [rightField  setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_RIGHT_BUTTON),  UInt16)] uppercaseString]];
    [runField    setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_RUN_BUTTON),    UInt16)] uppercaseString]];
    [jumpField   setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_NJUMP_BUTTON),  UInt16)] uppercaseString]];
    [sjumpField  setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_SJUMP_BUTTON),  UInt16)] uppercaseString]];
    [pauseField  setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_PAUSE_BUTTON),  UInt16)] uppercaseString]];
    [itemField   setStringValue:[[NSString stringWithFormat:@"%c", SMEConfigValueAsType(SMEConfigGet(config, SME_CONFIG_ITEM_BUTTON),   UInt16)] uppercaseString]];
}

- (IBAction)heightBoxChanged:(NSTextField *)sender
{
    if ([[sender stringValue] intValue] <= 120 || [[sender stringValue] intValue] >= 6000) return;
    UInt32 newHeight = [[sender stringValue] intValue];
    SMConfigSetHeight(newHeight);
    SMESystemGetSaveConfigCallback()();
}

- (IBAction)widthBoxChanged:(NSTextField *)sender
{
    if ([[sender stringValue] intValue] <= 160 || [[sender stringValue] intValue] >= 6000) return;
    UInt32 newWidth = [[sender stringValue] intValue];
    SMConfigSetWidth(newWidth);
    SMESystemGetSaveConfigCallback()();
}

- (IBAction)resetButtons:(NSButton *)sender
{
    SMConfigGoDefault();
    SMESystemGetSaveConfigCallback()();

    [self loadPrefDefaults];
}

- (IBAction)changeControl:(NSTextField *)sender
{
}

@end
