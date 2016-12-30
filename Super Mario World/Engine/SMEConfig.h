#ifndef __ENGINE_SMECONFIG__
#define __ENGINE_SMECONFIG__ 1

#include <Engine/SMEBase.h>

typedef struct __SMEConfig *SMEConfigRef;

SME_EXPORT MemoryAddress SMEConfigGet(SMEConfigRef config, CString label);
SME_EXPORT Boolean SMEConfigSet(SMEConfigRef config, CString label, MemoryAddress value, Boolean override);
SME_EXPORT Boolean SMEConfigRemove(SMEConfigRef config, CString label);
SME_EXPORT SMEConfigRef SMEConfigCreate(CString *defaultLabels);
SME_EXPORT UInt32 SMEConfigGetLength(SMEConfigRef config);
SME_EXPORT CString *SMEConfigGetKeys(SMEConfigRef config);
SME_EXPORT void SMEConfigDestroy(SMEConfigRef config);
SME_EXPORT SMEConfigRef SMEConfigGetDefault();
SME_EXPORT void SMEReloadConfig();

#define SMEConfigValueAsType(v, t) (*((t *)v))

#endif /* defined(__ENGINE_SMECONFIG__) */
