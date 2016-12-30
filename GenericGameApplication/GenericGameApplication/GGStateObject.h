#import <Cocoa/Cocoa.h>
#import "GGCarFile.h"
#import "gga.h"

typedef void *GameLibraryHandle;
typedef CString (*GameNameSymbol)();
typedef void (*KeyPressSymbol)(const char, bool);
typedef void (*ResizeSymbol)(int, int, int, int);
typedef void (*InitGLSymbol)(GGRequestFunction);
typedef void (*Symbol)();

@interface GGStateObject : NSObject
{
    @public
        GameLibraryHandle handle;
        GGCarFile *resourceMap;
        BOOL hasResourceCache;
        NSDictionary *resourceCache;
        KeyPressSymbol handleKeyPress;
        Symbol executeRunLoop;
        GameNameSymbol gameName;
        ResizeSymbol resize;
        Symbol destroyGame;
        InitGLSymbol initGL;
}

- (instancetype) initWithHandle:(GameLibraryHandle) handle;
- (instancetype) loadCacheFromFile:(NSString *)path;

@end

GGStateObject *GGGetCurrentState();
