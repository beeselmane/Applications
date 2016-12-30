#import <OpenGL/gl.h>
#import "AppGLView.h"

#define AppErrorOut(c, s, ...)              \
    do {                                    \
        NSLog(s, ##__VA_ARGS__);            \
        exit(c);                            \
    } while (0)

#define AppSuccess 0
#define AppFail    1

#define AppSetColor(r, g, b) glColor3f(r, g, b)
#define AppBeginFilling()    glBegin(GL_POINTS)
#define AppEndFilling()      glEnd()
#define AppPoint(x, y)       glVertex2d(x, y)

#define AppDrawRectAt(x, y, w, h)           \
    do {                                    \
        glBegin(GL_QUADS);                  \
        {                                   \
            glVertex2f(x + 0, y + 0);       \
            glVertex2f(x + 0, y + h);       \
            glVertex2f(x + w, y + h);       \
            glVertex2f(x + w, y + 0);       \
        }                                   \
        glEnd();                            \
    } while (0)

#define AppDrawTexturedRectAt(x, y, w, h)   \
    do {                                    \
        glBegin(GL_QUADS);                  \
        {                                   \
            glTexCoord2f(0.0F, 0.0F);       \
            glVertex2f(x + 0, y + 0);       \
            glTexCoord2f(1.0F, 0.0F);       \
            glVertex2f(x + 0, y + h);       \
            glTexCoord2f(1.0F, 1.0F);       \
            glVertex2f(x + w, y + h);       \
            glTexCoord2f(0.0F, 1.0F);       \
            glVertex2f(x + w, y + 0);       \
        }                                   \
        glEnd();                            \
    } while (0)

#define AppDrawCoordBlock(b)                \
    do {                                    \
        AppBeginFilling();                  \
        {                                   \
            b                               \
        }                                   \
        AppEndFilling();                    \
    } while (0)

@interface AppGLView (Private)

- (void) displayLinkCallback;

@end

CVReturn AppDisplayLinkCallback(CVDisplayLinkRef displayLink, CVTimeStamp *now, CVTimeStamp *output, CVOptionFlags flags, CVOptionFlags *flagsOut, AppGLView *instance)
{
    @autoreleasepool
    { [instance displayLinkCallback]; }

    return kCVReturnSuccess;
}

@implementation AppGLView
{
    CVDisplayLinkRef displayLink;
}

- (void) setUpGState
{
    [super setUpGState];

    CGLContextObj context = [[self openGLContext] CGLContextObj];
    CGLLockContext(context);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glOrtho(0.0F, +20.0F, 0.0F, +20.0F, +1.0F, -1.0F);
    glPushMatrix();

    CGLUnlockContext(context);
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    if (/* DISABLES CODE */ (1)) return;

    GLint swapRate = 1;
    [[self openGLContext] setValues:&swapRate forParameter:NSOpenGLCPSwapInterval];

    CVReturn dlStatus = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    if (dlStatus != kCVReturnSuccess) AppErrorOut(AppFail, @"Could not create display link! [Error = 0x%02X]", dlStatus);
    dlStatus = CVDisplayLinkSetOutputCallback(displayLink, (CVDisplayLinkOutputCallback)AppDisplayLinkCallback, (__bridge void *)self);
    if (dlStatus != kCVReturnSuccess) AppErrorOut(AppFail, @"Could not set display link callback! [Error = 0x%02X]", dlStatus);
    dlStatus = CVDisplayLinkStart(displayLink);
    if (dlStatus != kCVReturnSuccess) AppErrorOut(AppFail, @"Could not start display link! [Error = 0x%02X]", dlStatus);
}

- (void) drawRect:(NSRect)rect
{
    [self displayLinkCallback];
    [super drawRect:rect];
}

- (void) displayLinkCallback
{
    NSOpenGLContext *context = [self openGLContext];
    CGLLockContext([context CGLContextObj]);
    [context makeCurrentContext];

    glClearColor(0.0F, 0.0F, 0.0F, 0.0F);
    glClear(GL_COLOR_BUFFER_BIT);
    glPopMatrix();

    AppSetColor(0.7F, 0.0F, 0.7F);
    AppDrawCoordBlock({AppPoint(9.5F, 9.5F);});

    // (x - 9.5)^2 + (y - 9.5)^2 = 9
    // 9.5, 9.5
    // Radius 3

    double selection = 0.001F;
    double center = 9.5;
    double radius = 3;

    // center is for x and y
    // radius is from center

    AppDrawCoordBlock({
        for (double theta = 0; theta < (2 * M_PI); theta += selection)
        {
            double x = center + (radius * cos(theta));
            double y = center + (radius * sin(theta));
            AppPoint(x, y);

            //NSLog(@"Point @ (%f, %f)", x, y);
        }

        AppPoint(center + radius, center + radius);
        AppPoint(center + radius, center - radius);
        AppPoint(center - radius, center - radius);
        AppPoint(center - radius, center + radius);
    });

    glFlush();
    glPushMatrix();
    CGLUnlockContext([context CGLContextObj]);
}

@end
