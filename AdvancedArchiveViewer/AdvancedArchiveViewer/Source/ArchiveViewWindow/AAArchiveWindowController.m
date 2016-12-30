#import <AAArchiveWindowController.h>

static double AAViewWidthProportion = 4.0F / 15.0F;

@interface AAArchiveWindowController (Private)



@end

@implementation AAArchiveWindowController

- (void) windowDidResize:(NSNotification *)notification
{
    //
}

- (void) windowDidLoad
{
    [super windowDidLoad];

    [[self window] setAutorecalculatesContentBorderThickness:NO forEdge:NSMinYEdge];
    [[self window] setContentBorderThickness:24.0F forEdge:NSMinYEdge];

    [[self window] setDelegate:self];
}

@end
