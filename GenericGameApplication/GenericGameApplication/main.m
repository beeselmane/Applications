#import <Cocoa/Cocoa.h>
#import <dlfcn.h>

#import "GGStateObject.h"

static GGStateObject *state;

GGStateObject *GGGetCurrentState()
{
    return state;
}

__attribute__((noreturn)) void GGAlertError()
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Internal Error"];
    [alert setAlertStyle:NSCriticalAlertStyle];
    [alert runModal];

    exit(EXIT_FAILURE);
}

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *resources = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[bundle resourcePath] error:nil];
        NSString *name = [[[[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:[bundle bundleIdentifier]] lastPathComponent] stringByDeletingPathExtension];

        NSString *libName = [NSString stringWithFormat:@"lib%@.dylib", name];
        NSString *mapName = [NSString stringWithFormat:@"%@.res", name];

        if (!resources) GGAlertError();
        if (![resources containsObject:libName]) GGAlertError();
        if (![resources containsObject:mapName]) GGAlertError();

        NSString *gameLib = [NSString stringWithFormat:@"%@/%@", [bundle resourcePath], libName];
        GameLibraryHandle handle = dlopen([gameLib UTF8String], RTLD_LAZY);
        if (!handle) GGAlertError();

        state = [[GGStateObject alloc] initWithHandle:handle];
        state->resourceMap = [[GGCarFile alloc] initWithFile:[[bundle resourcePath] stringByAppendingString:[@"/" stringByAppendingString:mapName]]];
        if ([resources containsObject:@"rcache.plist"]) [state loadCacheFromFile:[[bundle resourcePath] stringByAppendingString:@"/rcache.plist"]];

        FileBufferRef vShader = [state->resourceMap getFile:@"/Shaders/Vertex.glsl"];
        if (vShader) printf("%s\n", vShader->data);

        return NSApplicationMain(argc, argv);
    }
}
