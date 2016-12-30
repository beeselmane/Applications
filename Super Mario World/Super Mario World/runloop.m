#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <Engine/Engine.h>

#import "SMOpenGLView.h"

CVReturn SMCustomRunLoop(CVDisplayLinkRef displayLink, const CVTimeStamp *now, const CVTimeStamp *outputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, SMOpenGLView *caller)
{
    //printf("Frame for time: %llu\n", now->hostTime);

    if (SMESystemGetIsCloseRequestedCallback()())
    {
        SMESystemGetDestroyGLCallback()();
        exit(EXIT_SUCCESS);
    }
    
    [caller executeRunLoop];
    return kCVReturnSuccess;
}
