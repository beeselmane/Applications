#include "EngineInternal.h"
#include "Engine.h"

#define ENGINE_FAULT() exit(EXIT_FAILURE)
#define ENGINE_STOP() exit(EXIT_SUCCESS)

SME_GLOBAL SMEInternalStateRef globalState;

__attribute__((constructor)) static void SMEEngineInitilizer(int argc, CString *argv, CString *environ)
{
    globalState = malloc(sizeof(struct __SMEInternalState));
    globalState->callbacksInitilized = false;
    globalState->config = NULL;
}

__attribute__((destructor)) static void SMEEngineDestructor()
{
    free(globalState);
}

SMEInternalStateRef SMEEngineGetCurrentState()
{
    return globalState;
}

static int i = 0;

void SMEEngineInitTextures()
{
    UInt8 ghOrder[6] = {0, 1, 2, 1, 0, -1};
    memcpy(globalState->animatedBackgroundOrder[BACKGROUND_ANIMATED_GHOSTHOUSE], ghOrder, sizeof(ghOrder));

    CString ghAnimated1 = globalState->getResource(RESOURCE_BACKGROUND_ANIMATED_GHOSTHOUSE1);
    printf("error: %d\n", glGetError());
    //i = globalState->loadTexture(ghAnimated1, 512, 432);
    printf("i: %d\n", i);
    printf("error: %d\n", glGetError());
}

void SMEEngineDrawPauseMenu()
{
    // I don't have a pause menu actually..
    return;
}

bool wasDown = false;

void SMEEngineExecuteRunLoop()
{
    if (globalState->isPaused) return;
    UInt16 keyState = globalState->getInput();

    if (globalState->tickState % 5)
    {
        globalState->tickState = 0;

        //glBindTexture(GL_TEXTURE_2D, i);
    }

    //glBindTexture(GL_TEXTURE_2D, i);
    //glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 1);
    glColor3f(1.0F, 0.0F, 1.0F);

    glBegin(GL_QUADS);
    {
        glVertex2f(-0.0F, -2.0F);
        glVertex2f(-0.0F,  2.0F);
        glVertex2f( 2.0F,  2.0F);
        glVertex2f( 2.0F, -2.0F);
    }
    glEnd();

    globalState->tickState++;
    globalState->lastKeyState = keyState;
}

void SMEEngineEnterRunLoop(UInt64 currentTime)
{
    if (!globalState->callbacksInitilized) ENGINE_FAULT();

    if (!globalState->initGL(globalState->height, globalState->width)) ENGINE_FAULT();
    while (!globalState->isCloseRequested()) SMEEngineExecuteRunLoop(0);
    globalState->destroyGL();

    ENGINE_STOP();
}