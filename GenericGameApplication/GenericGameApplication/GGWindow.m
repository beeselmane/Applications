#import "GGWindow.h"

@implementation GGWindow

- (void) awakeFromNib
{
    self->lastFlags = 0;
}

- (void) keyDown:(NSEvent *)event
{
    if (![event isARepeat]) GGGetCurrentState()->handleKeyPress([[event charactersIgnoringModifiers] characterAtIndex:0], YES);
}

- (void) flagsChanged:(NSEvent *)event
{
    SInt32 flags = (SInt32)[event modifierFlags];

#define IFP(a, b) if ( (flags & a)   && (!(self->lastFlags & a))) GGGetCurrentState()->handleKeyPress(b, YES);
#define IFU(a, b) if ((!(flags & a)) &&   (self->lastFlags & a))  GGGetCurrentState()->handleKeyPress(b, NO);

         IFP(NSAlphaShiftKeyMask, SKAlphaShiftKey)
    else IFP(NSShiftKeyMask, SKShiftKey)
    else IFP(NSControlKeyMask, SKControlKey)
    else IFP(NSAlternateKeyMask, SKAltKey)
    else IFP(NSCommandKeyMask, SKCommandKey)
    else IFP(NSNumericPadKeyMask, SKNumberPad)
    else IFP(NSHelpKeyMask, SKHelpKey)
    else IFP(NSFunctionKeyMask, SKFunctionKey)

         IFU(NSAlphaShiftKeyMask, SKAlphaShiftKey)
    else IFU(NSShiftKeyMask, SKShiftKey)
    else IFU(NSControlKeyMask, SKControlKey)
    else IFU(NSAlternateKeyMask, SKAltKey)
    else IFU(NSCommandKeyMask, SKCommandKey)
    else IFU(NSNumericPadKeyMask, SKNumberPad)
    else IFU(NSHelpKeyMask, SKHelpKey)
    else IFU(NSFunctionKeyMask, SKFunctionKey)
#undef IFP
#undef IFU

    self->lastFlags = flags;
}

- (void) keyUp:(NSEvent *)event
{
    if (![event isARepeat]) GGGetCurrentState()->handleKeyPress([[event charactersIgnoringModifiers] characterAtIndex:0], NO);
}

@end
