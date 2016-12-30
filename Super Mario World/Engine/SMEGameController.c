#include "EngineInternal.h"
#include "SMEGameController.h"

void SMEGameControllerSetPaused(bool paused)
{
    SMEEngineLoadCurrentState();
    currentState->isPaused = paused;

    if (currentState->isPaused) SMEEngineDrawPauseMenu();
}

bool SMEGameControllerIsPaused()
{
    SMEEngineLoadCurrentState();
    return currentState->isPaused;
}

void SMEGameControllerInitGame()
{
    SMEEngineInitTextures();
}
