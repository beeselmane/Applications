#ifndef __ENGINE__SMESYSTEMCALLBACKS__
#define __ENGINE__SMESYSTEMCALLBACKS__ 1

#include <Engine/SMEBase.h>
#include <Engine/SMEConfig.h>
#include <OpenGL/gl.h>

typedef SMEConfigRef (*SMELoadSystemConfigCallback)();
typedef void (*SMESaveSystemConfigCallback)();
typedef bool (*SMEIsCloseRequested)();
typedef bool (*SMEInitilizeGLCallback)(UInt32 height, UInt32 width);
typedef void (*SMEDestroyGLCallback)();
typedef UInt16 (*SMEGetInputMask)();
typedef CString (*SMEGetResourceCallback)(CString resource);
typedef GLint (*SMELoadGLTextureCallback)(CString path, Size textureWidth, Size textureHeight);

SME_EXPORT void SMESystemInitilizeCallbacks(SMELoadSystemConfigCallback loadConfig, SMESaveSystemConfigCallback saveConfig, SMEInitilizeGLCallback initGL, SMEDestroyGLCallback destroyGL, SMEGetInputMask getInput, SMEIsCloseRequested closeRequested, SMELoadGLTextureCallback loadTexture, SMEGetResourceCallback getResource);
SME_EXPORT SMELoadGLTextureCallback SMESystemGetLoadGLTextureCallback();
SME_EXPORT SMELoadSystemConfigCallback SMESystemGetLoadConfigCallback();
SME_EXPORT SMESaveSystemConfigCallback SMESystemGetSaveConfigCallback();
SME_EXPORT SMEIsCloseRequested SMESystemGetIsCloseRequestedCallback();
SME_EXPORT SMEInitilizeGLCallback SMESystemGetInitilizeGLCallback();
SME_EXPORT SMEGetResourceCallback SMESystemGetResourceCallback();
SME_EXPORT SMEDestroyGLCallback SMESystemGetDestroyGLCallback();
SME_EXPORT SMEGetInputMask SMESystemGetInputMaskCallback();

// This function is supposed to be run every frame
typedef void (*SMERunLoopCallback)(UInt64 currentTime);

SME_EXPORT SMERunLoopCallback SMESystemGetRunLoop();

#endif /* defined(__ENGINE__SMESYSTEMCALLBACKS__) */
