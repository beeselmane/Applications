#define _GG_INTERNAL_ 1

#import "GGStateObject.h"
#import "dlfcn.h"

#import <sys/cdefs.h>

@implementation GGStateObject

- (instancetype) initWithHandle:(GameLibraryHandle) gameHandle
{
    self = [super init];

    if (self)
    {
        self->hasResourceCache = NO;
        self->handleKeyPress = (KeyPressSymbol)dlsym(gameHandle, KEY_FUNC);
        self->gameName = (GameNameSymbol)dlsym(gameHandle, NAME_FUNC);
        self->executeRunLoop = (Symbol)dlsym(gameHandle, EXEC_RUNLOOP_FUNC);
        self->resize = (ResizeSymbol)dlsym(gameHandle, RESIZE_FUNC);
        self->initGL = (Symbol)dlsym(gameHandle, INIT_FUNC);
        self->destroyGame = (Symbol)dlsym(gameHandle, CLOSE_FUNC);
        self->handle = gameHandle;
    }

    return(self);
}

- (instancetype) loadCacheFromFile:(NSString *)path
{
    if (self)
    {
        //
    }

    return self;
}

@end
