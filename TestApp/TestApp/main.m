#import <UIKit/UIKit.h>
#import <sys/utsname.h>

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        struct utsname sysname;
        uname(&sysname);

        NSLog(@"Loaded on '%s' version '%s'", sysname.release, sysname.version);
        NSLog(@"System named '%s' on node '%s'", sysname.sysname, sysname.nodename);
        NSLog(@"Machine is '%s'", sysname.machine);

        return(0);
    }
}
