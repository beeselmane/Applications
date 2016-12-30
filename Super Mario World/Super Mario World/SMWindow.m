#import "SMAppDelegate.h"
#import "SMOpenGLView.h"
#import "SMWindow.h"

static SMWindow *window;

UInt16 currentKeyMask()
{
    return window->buttonFlags;
}

@implementation SMWindow

#if 0
    // Print Current Bit State
    - (void) printBS
    {
        SingleByte bs[9];
        for (int i = 0; i < 8; i++) bs[i] = ((self->buttonFlags >> i) & 1) ? '1' : '0';
        bs[8] = 0;
        printf("%s\n", bs);
    }
#endif /* 0 */

- (void) awakeFromNib
{
    window = self;
    self->buttonFlags = 0;

    [self setDelegate:self];
    [self reloadConfig];
}

- (void) keyDown:(NSEvent *)event
{
    if ([event isARepeat]) return;

    char character = [[event charactersIgnoringModifiers] characterAtIndex:0];

    if (character == self->pauseButton)
    {
        BOOL paused = SMEGameControllerIsPaused();
        [[[SMAppDelegate delegate] glView] setPaused:!paused];
        SMEGameControllerSetPaused(!paused);
    }

    #define CASE(k, bs) if (character == k) self->buttonFlags |= (1 << bs);

    CASE(self->upButton,    0)
    CASE(self->downButton,  1)
    CASE(self->leftButton,  2)
    CASE(self->rightButton, 3)

    #undef CASE
}

- (void) flagsChanged:(NSEvent *)event
{
    // Nothing for now...
}

- (void) keyUp:(NSEvent *)event
{
    if ([event isARepeat]) return;

    char character = [[event charactersIgnoringModifiers] characterAtIndex:0];

    #define CASE(k, bs) if (character == k) self->buttonFlags &= ~(1 << bs);
    
    CASE(self->upButton,    0)
    CASE(self->downButton,  1)
    CASE(self->leftButton,  2)
    CASE(self->rightButton, 3)
    
    #undef CASE
}

#define CGET(k) SMEConfigValueAsType(SMEConfigGet(config, k), UInt16)

- (void) reloadConfig
{
    SMEConfigRef config = SMEConfigGetDefault();
    self->upButton    = CGET(SME_CONFIG_UP_BUTTON);
    self->downButton  = CGET(SME_CONFIG_DOWN_BUTTON);
    self->leftButton  = CGET(SME_CONFIG_LEFT_BUTTON);
    self->rightButton = CGET(SME_CONFIG_RIGHT_BUTTON);
    self->pauseButton = CGET(SME_CONFIG_PAUSE_BUTTON);
}

@end
