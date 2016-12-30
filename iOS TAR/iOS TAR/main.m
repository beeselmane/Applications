#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define cs "/System/Library/CoreServices"

void GetFile(NSString *path)
{
    NSString *dd = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *final = [NSString stringWithFormat:@"%@/%@", dd, [path lastPathComponent]];

    NSFileManager *fm = [NSFileManager defaultManager];

    if ([fm copyItemAtPath:path toPath:final error:nil]) {
        NSLog(@"Recieved %@", path);
    } else {
        NSLog(@"Failed to recieve %@", path);
    }
}

void GetFiles(NSString *prefix, int n, char **files)
{
    for (int i = 0; i < n; i++)
        GetFile([NSString stringWithFormat:@"%@/%s", prefix, files[i]]);
}

void ClearData()
{
    NSString *dd = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dd error:nil];

    for (NSString *file in files)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", dd, file] error:nil];
        NSLog(@"Removed %@", file);
    }
}

int main(int argc, char **argv)
{
    @autoreleasepool
    {
#if 0
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:@"/System/Library/Caches/" error:nil];
        NSLog(@"%@", contents);
#endif

#if 0
        GetFile(@"/System/Library/Caches/");
#endif

#if 1
        ClearData();
#endif

#if 0
        char *files[30] = {
            "AppleIDAuthAgent",
            "AssistiveTouch.app",
            "AuthBrokerAgent",
            "CFNetworkAgent",
            "CacheDeleteAppContainerCaches",
            "CacheDeleteDaily",
            "CacheDeleteITunesStore",
            "CacheDeleteSystemFiles",
            "Checkpoint.xml",
            "CoreTypes.bundle",
            "DeviceOMatic.app",
            "DumpPanic",
            "Encodings",
            "EscrowSecurityAlert.app",
            "Firmware Updates",
            "MobileCoreTypes.bundle",
            "MobileStorageMounter.app",
            "OTACrashCopier",
            "OTALogSubmission",
            "RawCamera.bundle",
            "RawCameraSupport.bundle",
            "RegionalOverrideSoftwareBehaviors.plist",
            "ReportCrash",
            "SpringBoard.app",
            "SystemVersion.plist",
            "TimeZoneUpdates.bundle",
            "VoiceOverTouch.app",
            "mDNSResponder.bundle",
            "powerd.bundle",
            "prdaily"};

        GetFiles(@"/System/Library/CoreServices", 30, files);
#endif

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
