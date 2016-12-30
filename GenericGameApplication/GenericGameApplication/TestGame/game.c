#include <OpenGL/gl.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include "../gga.h"

#define KMOD 0.01
#define SMOD 0.01

GGRequestFunction GGRequestFunctionCallback;

bool uf = false, df = false, rf = false, lf = false;
int rl = 0, ud = 0;

bool sf = false, gf = false;
double size = 1;

bool cf[3] = {false, false, false};
double color[3] = {0.5F, 0.5F, 0.5F};

bool verbose = false;

unsigned long tc = 0;

CString NAME_FUNC()
{
    return "Test Game";
}

void KEY_FUNC(const char key, bool pressed)
{
    //printf("key 0x%02X %spressed\n", key, ((pressed) ? "" : "un"));

#define KENT(k, f) if (key == k) f = pressed;
    KENT('d', rf)
    KENT('a', lf)
    KENT('w', uf)
    KENT('s', df)

    KENT('+', gf)
    KENT('-', sf)

    KENT('r', cf[0])
    KENT('b', cf[1])
    KENT('g', cf[2])
#undef KENT

    if (key == 'v' && pressed) verbose = !verbose;
}

bool LoadSingle(CString location);

void INIT_FUNC(GGRequestFunction rFunc)
{
    GGRequestFunctionCallback = rFunc;
    GGRequestFunctionCallback(1, NULL);

    glEnable(GL_DEPTH_TEST);

    #include "loadtextures.h"

void RESIZE_FUNC(int nw, int nh, int ow, int oh)
{
    //
}

void EXEC_RUNLOOP_FUNC()
{
    glColor3d(color[0], color[1], color[2]);

    if (tc % 3)
    {
        if (rf) rl++;
        if (lf) rl--;

        if (uf) ud++;
        if (df) ud--;
    }

    if (tc % 5)
    {
        if (sf) size++;
        if (gf) size--;
    }

    if (tc % 2)
    {
        if (cf[0]) color[0] += 0.01F;
        if (cf[1]) color[1] += 0.01F;
        if (cf[2]) color[2] += 0.01F;

        if (color[0] > 1.0F) color[0] = 0.0F;
        if (color[1] > 1.0F) color[1] = 0.0F;
        if (color[2] > 1.0F) color[2] = 0.0F;
    }

    glBegin(GL_QUADS);
    {
        glVertex2d(-(size * SMOD) + (rl * KMOD),  (size * SMOD) + (ud * KMOD));
        glVertex2d(-(size * SMOD) + (rl * KMOD), -(size * SMOD) + (ud * KMOD));
        glVertex2d( (size * SMOD) + (rl * KMOD), -(size * SMOD) + (ud * KMOD));
        glVertex2d( (size * SMOD) + (rl * KMOD),  (size * SMOD) + (ud * KMOD));
    }
    glEnd();

    tc++;
}

void CLOSE_FUNC()
{
    //
}
