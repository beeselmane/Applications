#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <sys/stat.h>

#define SYSTEM_VERSION "/System/Library/CoreServices/SystemVersion.plist"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        FILE *fp = fopen(SYSTEM_VERSION, "rb");
        struct stat *stats = malloc(sizeof(struct stat));
        if (stat(SYSTEM_VERSION, stats)) { perror("stat"); exit(0); }
        void *mbuf = malloc(stats->st_size);
        fread(mbuf, 1, stats->st_size, fp);
        fclose(fp);

        CFDataRef data = CFDataCreateWithBytesNoCopy(kCFAllocatorSystemDefault, mbuf, stats->st_size, kCFAllocatorMalloc);
        CFPropertyListRef plist = CFPropertyListCreateWithData(kCFAllocatorSystemDefault, data, 0, NULL, nil);
        CFRelease(data);

        CFDictionaryRef dict = (CFDictionaryRef)plist;
        NSLog(@"%@", dict);
        CFRelease(dict);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
