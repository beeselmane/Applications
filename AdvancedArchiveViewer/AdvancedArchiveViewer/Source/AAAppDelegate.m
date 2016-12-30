#import <AAArchiveWindowController.h>
#import <AAAppDelegate.h>

@interface AAAppDelegate (Private)

+ (AAArchiveWindowController *) spawnWindowController;

@end

@implementation AAAppDelegate
{
    __strong AAArchiveWindowController *controller;
}

@synthesize windowControllers;

+ (instancetype) delegate
{
    return [NSApp delegate];
}

+ (AAArchiveWindowController *) spawnWindowController
{
    return [[AAArchiveWindowController alloc] initWithWindowNibName:@"AAArchiveWindowController"];
}

- (void) applicationDidFinishLaunching:(NSNotification *)notification
{
    [windowControllers addObject:[AAAppDelegate spawnWindowController]];

    controller = [AAAppDelegate spawnWindowController];
    [controller showWindow:self];

    [windowControllers addObject:controller];

    for (AAArchiveWindowController *wc in windowControllers)
        [wc showWindow:self];
}

@end
