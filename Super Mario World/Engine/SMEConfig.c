#include "EngineInternal.h"
#include "SMEConfig.h"
#include <stdlib.h>
#include <string.h>

#define INDEX_INVALID (-1)

struct __SMEConfigEntry;

typedef struct __SMEConfigEntry {
    CString label;
    MemoryAddress value;
    struct __SMEConfigEntry *next;
} *SMEConfigEntryRef;

struct __SMEConfig {
    SMEConfigEntryRef first, last;
    UInt32 length;
};

typedef struct __SMEConfigEntry *SMEConfigEntryRef;

void SMEConfigInitilize()
{
    SMEEngineLoadCurrentState();
    if (!currentState->callbacksInitilized) return;
    currentState->config = currentState->loadConfig();

    currentState->height = SMEConfigValueAsType(SMEConfigGet(currentState->config, SME_CONFIG_WINDOW_HEIGHT), UInt32);
    currentState->width  = SMEConfigValueAsType(SMEConfigGet(currentState->config, SME_CONFIG_WINDOW_WIDTH),  UInt32);

    currentState->saveConfig();
}

UInt32 SMEConfigGetLength(SMEConfigRef config)
{
    return config->length;
}

MemoryAddress SMEConfigGet(SMEConfigRef config, CString label)
{
    SMEConfigEntryRef entry = config->first;

    while (entry)
    {
        if (!strncmp(entry->label, label, strlen(label))) return entry->value;
        entry = entry->next;
    }

    return(NULL);
}

Boolean SMEConfigSet(SMEConfigRef config, CString label, MemoryAddress value, Boolean override)
{
    if (!config->first)
    {
        SMEConfigEntryRef entry = malloc(sizeof(struct __SMEConfigEntry));
        entry->label = label;
        entry->value = value;
        entry->next = NULL;
        config->first = entry;
        config->last = entry;
        config->length++;
        return(true);
    }

    if (SMEConfigGet(config, label))
    {
        if (!override) return(false);

        SMEConfigEntryRef entry = config->first;

        while (entry)
        {
            if (!strncmp(entry->label, label, strlen(label)))
            {
                entry->value = value;
                config->length++;
                return(true);
            }

            entry = entry->next;
        }

        // This shouldn't happen...
        return(false);
    }

    SMEConfigEntryRef entry = malloc(sizeof(struct __SMEConfigEntry));
    entry->label = label;
    entry->value = value;
    entry->next = NULL;
    config->last->next = entry;
    config->last = entry;
    config->length++;

    return(true);
}

Boolean SMEConfigRemove(SMEConfigRef config, CString label)
{
    if (!config->first) return(true);

    if (__builtin_expect((config->length == 1), false)) {
        if (!strncmp(config->first->label, label, strlen(label))) {
            free(config->first);
            config->first = NULL;
            config->last = NULL;
            config->length--;
            return(true);
        } else {
            return(false);
        }
    } else {
        SMEConfigEntryRef entry = config->first;
        SMEConfigEntryRef last = NULL;
        
        while (entry)
        {
            if (!strncmp(entry->label, label, strlen(label)))
            {
                if (entry == config->first) {
                    config->first = entry->next;
                    free(entry);
                    return(true);
                } else if (entry == config->last) {
                    config->last = last;
                    last->next = NULL;
                    free(entry);
                    return(true);
                } else {
                    last->next = entry->next;
                    free(entry);
                    return(true);
                }
            }

            last = entry;
            entry = entry->next;
        }

        return(false);
    }
}

CString *SMEConfigGetKeys(SMEConfigRef config)
{
    CString *keys = malloc(sizeof(CString) * config->length), *tmpKeys = keys;
    SMEConfigEntryRef entry = config->first;

    while (entry)
    {
        (*tmpKeys++) = entry->label;
        entry = entry->next;
    }

    return(keys);
}

SMEConfigRef SMEConfigGetDefault()
{
    SMEEngineLoadCurrentState();
    return currentState->config;
}

SMEConfigRef SMEConfigCreate(CString *defaultLabels)
{
    SMEConfigRef config = malloc(sizeof(struct __SMEConfig));
    config->length = 0;

    if (!defaultLabels) {
        config->first = NULL;
        config->last = NULL;
    } else {
        SMEConfigEntryRef entry, last = NULL;

        while ((*defaultLabels))
        {
            entry = malloc(sizeof(struct __SMEConfigEntry));
            if (!config->first) config->first = entry;
            if (last) last->next = entry;
            entry->label = (*defaultLabels);
            entry->value = NULL;
            defaultLabels += 1;
            last = entry;
        }

        config->last = last;
    }

    return(config);
}

void SMEConfigDestroy(SMEConfigRef config)
{
    SMEConfigEntryRef entry = config->first, next = NULL;

    while (entry)
    {
        next = entry->next;
        free(entry);
        entry = next;
    }

    free(config);
}

void SMEReloadConfig()
{
    //
}
