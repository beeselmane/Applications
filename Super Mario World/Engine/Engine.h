#ifndef __ENGINE_ENGINE__
#define __ENGINE_ENGINE__ 1
#define __ENGINE__ 1

#if !defined(__ENGINE_NOSTDINC__)
    #include <string.h>
    #include <stdlib.h>
    #include <stddef.h>
    #include <stdio.h>
#endif /* !defined(__ENGINE_NOSTDINC__) */

#include <Engine/SMEBase.h>
#include <Engine/SMESystemCallbacks.h>
#include <Engine/SMEGameController.h>
#include <Engine/SMEFileManager.h>
#include <Engine/SMEInputMap.h>
#include <Engine/SMEConfig.h>

SME_EXPORT void SMEEngineEnterRunLoop() NO_RETURN;

#endif /* !defined(__ENGINE_ENGINE__) */