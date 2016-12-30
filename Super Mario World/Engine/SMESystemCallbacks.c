#include "EngineInternal.h"
#include "SMESystemCallbacks.h"

void SMESystemInitilizeCallbacks(SMELoadSystemConfigCallback loadConfig, SMESaveSystemConfigCallback saveConfig, SMEInitilizeGLCallback initGL, SMEDestroyGLCallback destroyGL, SMEGetInputMask getInput, SMEIsCloseRequested closeRequested, SMELoadGLTextureCallback loadTexture, SMEGetResourceCallback getResource)
{
    SMEEngineLoadCurrentState();
    if (currentState->callbacksInitilized) return;

    VALIDATE_INPUT(getResource)
    VALIDATE_INPUT(loadConfig)
    VALIDATE_INPUT(saveConfig)
    VALIDATE_INPUT(initGL)
    VALIDATE_INPUT(destroyGL)
    VALIDATE_INPUT(getInput)
    VALIDATE_INPUT(loadTexture)

    currentState->loadConfig          = loadConfig;
    currentState->saveConfig          = saveConfig;
    currentState->initGL              = initGL;
    currentState->destroyGL           = destroyGL;
    currentState->getInput            = getInput;
    currentState->isCloseRequested    = closeRequested;
    currentState->loadTexture         = loadTexture;
    currentState->getResource         = getResource;
    currentState->callbacksInitilized = true;

    SMEConfigInitilize();
}

#define CHECK_INIT() if (!currentState->callbacksInitilized) return NULL;

SMEGetResourceCallback SMESystemGetResourceCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->getResource;
}

SMELoadGLTextureCallback SMESystemGetLoadGLTextureCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->loadTexture;
}

SMELoadSystemConfigCallback SMESystemGetLoadConfigCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->loadConfig;
}

SMESaveSystemConfigCallback SMESystemGetSaveConfigCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->saveConfig;
}

SMEInitilizeGLCallback SMESystemGetInitilizeGLCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->initGL;
}

SMEDestroyGLCallback SMESystemGetDestroyGLCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->destroyGL;
}

SMEGetInputMask SMESystemGetInputMaskCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->getInput;
}

SMEIsCloseRequested SMESystemGetIsCloseRequestedCallback()
{
    SMEEngineLoadCurrentState();
    CHECK_INIT();
    return currentState->isCloseRequested;
}

SMERunLoopCallback SMESystemGetRunLoop()
{
    return SMEEngineExecuteRunLoop;
}
