#ifndef __ENGINE_INTERN__
#define __ENGINE_INTERN__ 1

#include "SMEBase.h"
#include "SMESystemCallbacks.h"

#define SME_PRIVATE __attribute__((visibility("hidden")))

typedef struct __SMEInternalState {
    // General Engine Variables
    UInt32 height, width; // Display Height + Width (for GL)
    Boolean isPaused;
    UInt64 tickState;
    UInt16 lastKeyState;

    // System Callbacks
    SMELoadSystemConfigCallback loadConfig;
    SMESaveSystemConfigCallback saveConfig;
    SMEInitilizeGLCallback      initGL;
    SMEDestroyGLCallback        destroyGL;
    SMEIsCloseRequested         isCloseRequested;
    SMEGetInputMask             getInput;
    SMELoadGLTextureCallback    loadTexture;
    SMEGetResourceCallback      getResource;
    Boolean                     callbacksInitilized;

    // Engine Config
    SMEConfigRef config;

    // Textures
    GLint animatedBackgrounds[5][4];
    UInt8 animatedBackgroundOrder[5][6];
} *SMEInternalStateRef;

#define BACKGROUND_ANIMATED_CAVE        0
#define BACKGROUND_ANIMATED_UNDERWATER  1
#define BACKGROUND_ANIMATED_GHOSTHOUSE  2
#define BACKGROUND_ANIMATED_CASTLE      3
#define BACKGROUND_ANIMATED_STARRY      4

#include "resources.h"

SME_PRIVATE SMEInternalStateRef SMEEngineGetCurrentState();
#define SMEEngineLoadCurrentState() SMEInternalStateRef currentState = SMEEngineGetCurrentState()

#include <assert.h>

#define VALIDATE_INPUT(x) assert(x != NULL);

SME_PRIVATE void SMEEngineExecuteRunLoop(UInt64 currentTime);
SME_PRIVATE void SMEEngineDrawPauseMenu();
SME_PRIVATE void SMEEngineInitTextures();
SME_PRIVATE void SMEConfigInitilize();

#endif /* !defined(__ENGINE_INTERN__) */
