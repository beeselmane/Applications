#import "OSArtwork.h"

static UITraitCollection *traitCollection = nil;
static NSBundle *artworkBundle = nil;

@implementation OSArtwork

+ (void) initialize
{
    static dispatch_once_t predicate = 0;

    dispatch_once(&predicate, ^() {
        traitCollection =  [UITraitCollection traitCollectionWithUserInterfaceIdiom:[[UIDevice currentDevice] userInterfaceIdiom]];

        if (TARGET_IPHONE_SIMULATOR) {
            artworkBundle = [NSBundle bundleWithPath:@"/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/UIKit.framework/Artwork.bundle"];
        } else {
            artworkBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/UIKit.framework/Artwork.bundle"];
        }
    });
}

+ (UIImage *) imageNamed:(NSString *)name
{
    return [UIImage imageNamed:name inBundle:artworkBundle compatibleWithTraitCollection:traitCollection];
}

@end

#import <objc/runtime.h>
#import "UIStatusBar.h"

/*@implementation UIApplication (StatusBar)

- (void) setStatusBar:(UIStatusBar *) newStatusBar
{
    Ivar ivar = class_getInstanceVariable([self class], "statusBar");
    object_setIvar(self, ivar, newStatusBar);
}

- (UIStatusBar *) statusBar
{
    Ivar ivar = class_getInstanceVariable([self class], "statusBar");
    return object_getIvar(self, ivar);
}

@end*/
