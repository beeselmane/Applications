#import <CoreFoundation/CoreFoundation.h>
#import <AppKit/AppKit.h>
#import <Engine/Engine.h>
#import <OpenGL/gl.h>

#define FIRE_INTERVAL 1

extern NSUserDefaults *defaults;

SMEConfigRef loadConfigCallback();
void saveConfigCallback();
void initConfig();

bool initGL(UInt32 width, UInt32 height);
void destroyGL();

UInt16 currentKeyMask();
bool isClosed();

void SMCustomRunLoop(CFRunLoopTimerRef timer, MemoryAddress timerInfo);
GLint loadTextureCallback(CString resource);
CString getResource(CString resource);

int main(int argc, const char *argv[])
{
    defaults = [NSUserDefaults standardUserDefaults];
    initConfig();
 
    SMESystemInitilizeCallbacks(loadConfigCallback, saveConfigCallback, initGL, destroyGL, currentKeyMask, isClosed, loadTextureCallback, getResource);

    /*CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
    CFRunLoopTimerContext context = {0, NULL, NULL, NULL, NULL};
    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(kCFAllocatorSystemDefault, CFAbsoluteTimeGetCurrent() + FIRE_INTERVAL, FIRE_INTERVAL, 0, 0, SMCustomRunLoop, &context);
    CFRunLoopAddTimer(currentRunLoop, timer, kCFRunLoopDefaultMode);*/

    return NSApplicationMain(argc, argv);
}
