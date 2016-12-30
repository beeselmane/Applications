#import <Foundation/Foundation.h>
#import <Engine/SMEBase.h>
#import <OpenGL/gl.h>

#import "SMAppDelegate.h"
#import "SMOpenGLView.h"

bool initGL(UInt32 width, UInt32 height)
{
    [[[SMAppDelegate delegate] glView] setup];

    glDisable(GL_DITHER);
    glDisable(GL_ALPHA_TEST);
    glDisable(GL_STENCIL_TEST);
    glDisable(GL_FOG);
    glDisable(GL_DEPTH_TEST);
    glEnable(GL_TEXTURE_2D);
    glPixelZoom(1.0, 1.0);
    
    glEnable(GL_BLEND);
    glMatrixMode(GL_MODELVIEW_MATRIX);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glClearColor(0, 0, 0, 0);

    [[[SMAppDelegate delegate] glView] executeBlockInContext:^() {
        SMEGameControllerInitGame();
    }];

    return(true);
}

void destroyGL()
{
    //
}
