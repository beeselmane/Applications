#import "AppDelegate.h"
#import "BlobGenerator.h"
#import "LockViewController.h"

#define kEBlobSize 2048
#define kEKeySize  2048

@implementation AppDelegate
{
    UIViewController *lockController;
    UIViewController *mainController;
}

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
    NSFileManager *fman = [NSFileManager defaultManager];
    NSString *ssddir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/SSData"];

    NSString *keyfile = [ssddir stringByAppendingString:@"/main.keyfile"];
    NSString *mainblob = [ssddir stringByAppendingString:@"/main.blob"];
    //NSString *mainalbum = [ssddir stringByAppendingString:@"/main.plist.enc"];
    NSString *albumdir = [ssddir stringByAppendingString:@"/Albums"];
    NSString *filedir = [ssddir stringByAppendingString:@"/Files"];

    if (![fman fileExistsAtPath:ssddir isDirectory:nil])
    {
        [fman createDirectoryAtPath:filedir withIntermediateDirectories:YES attributes:nil error:nil];
        [fman createDirectoryAtPath:albumdir withIntermediateDirectories:YES attributes:nil error:nil];
        [fman createFileAtPath:mainblob contents:[[BlobGenerator generator] generateBlobOfSize:kEBlobSize] attributes:nil];
        [fman createFileAtPath:keyfile contents:[[BlobGenerator generator] generateBlobOfSize:kEKeySize] attributes:nil];
    }

    NSMutableData *fullData = [NSMutableData dataWithCapacity:kEBlobSize + kEKeySize];
    [fullData appendData:[NSData dataWithContentsOfFile:mainblob]];
    [fullData appendData:[NSData dataWithContentsOfFile:keyfile]];

    NSLog(@"Encryption key for main album: %@", [[BlobGenerator generator] hashForBlob:fullData]);
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    if (!lockController) lockController = [[LockViewController alloc] init];
    mainController = [[self window] rootViewController];

    [[self window] setRootViewController:lockController];
    [[UIApplication sharedApplication] ignoreSnapshotOnNextApplicationLaunch];
}

- (void) applicationWillEnterForeground:(UIApplication *)application
{
    if (mainController) [[self window] setRootViewController:mainController];
    lockController = nil;
}

@end
