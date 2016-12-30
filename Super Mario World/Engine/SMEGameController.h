#ifndef __ENGINE_SMEGAMECONTROLLER__
#define __ENGINE_SMEGAMECONTROLLER__

#include <Engine/SMEBase.h>

SME_EXPORT void SMEGameControllerSetPaused(bool paused);
SME_EXPORT bool SMEGameControllerIsPaused();
SME_EXPORT void SMEGameControllerInitGame();

#endif /* defined(__ENGINE_SMEGAMECONTROLLER__) */
