#import <Foundation/Foundation.h>
#import <Engine/Engine.h>

#import "SMAppDelegate.h"
#import "SMWindow.h"

static UInt32 configHeight = SM_CONFIG_DEFAULT_HEIGHT;   static CString configHeightString   = SME_CONFIG_WINDOW_HEIGHT;
static UInt32 configWidth  = SM_CONFIG_DEFAULT_WIDTH;    static CString configWidthString    = SME_CONFIG_WINDOW_WIDTH;
static UInt16 keyUp        = SM_CONFIG_DEFAULT_UPKEY;    static CString configUpKeyString    = SME_CONFIG_UP_BUTTON;
static UInt16 keyDown      = SM_CONFIG_DEFAULT_DOWNKEY;  static CString configDownKeyString  = SME_CONFIG_DOWN_BUTTON;
static UInt16 keyLeft      = SM_CONFIG_DEFAULT_LEFTKEY;  static CString configLeftKeyString  = SME_CONFIG_LEFT_BUTTON;
static UInt16 keyRight     = SM_CONFIG_DEFAULT_RIGHTKEY; static CString configRightKeyString = SME_CONFIG_RIGHT_BUTTON;
static UInt16 pauseButton  = SM_CONFIG_DEFAULT_PAUSEKEY; static CString configPauseButtonStr = SME_CONFIG_PAUSE_BUTTON;
static UInt16 runButton    = SM_CONFIG_DEFAULT_RUNKEY;   static CString configRunButtonStr   = SME_CONFIG_RUN_BUTTON;
static UInt16 njumpButton  = SM_CONFIG_DEFAULT_NJUMP;    static CString configNJumpButtonStr = SME_CONFIG_NJUMP_BUTTON;
static UInt16 sjumpButton  = SM_CONFIG_DEFAULT_SJUMP;    static CString configSJumpButtonStr = SME_CONFIG_SJUMP_BUTTON;
static UInt16 itemButton   = SM_CONFIG_DEFAULT_ITEMKEY;  static CString configItemButtonStr  = SME_CONFIG_ITEM_BUTTON;

void SMConfigSetHeight(UInt32 new) { configHeight = new; }
void SMConfigSetWidth(UInt32 new)  { configWidth  = new; }
void SMConfigSetUp(UInt16 new)     { keyUp        = new; }
void SMConfigSetDown(UInt16 new)   { keyDown      = new; }
void SMConfigSetLeft(UInt16 new)   { keyLeft      = new; }
void SMConfigSetRight(UInt16 new)  { keyRight     = new; }
void SMConfigSetPause(UInt16 new)  { pauseButton  = new; }
void SMConfigSetRun(UInt16 new)    { runButton    = new; }
void SMConfigSetNJump(UInt16 new)  { njumpButton  = new; }
void SMConfigSetSJump(UInt16 new)  { sjumpButton  = new; }
void SMConfigSetItem(UInt16 new)   { itemButton   = new; }

void SMConfigGoDefault()
{
    configHeight = SM_CONFIG_DEFAULT_HEIGHT;
    configWidth  = SM_CONFIG_DEFAULT_WIDTH;
    keyUp        = SM_CONFIG_DEFAULT_UPKEY;
    keyDown      = SM_CONFIG_DEFAULT_DOWNKEY;
    keyLeft      = SM_CONFIG_DEFAULT_LEFTKEY;
    keyRight     = SM_CONFIG_DEFAULT_RIGHTKEY;
    pauseButton  = SM_CONFIG_DEFAULT_PAUSEKEY;
    runButton    = SM_CONFIG_DEFAULT_RUNKEY;
    njumpButton  = SM_CONFIG_DEFAULT_NJUMP;
    sjumpButton  = SM_CONFIG_DEFAULT_SJUMP;
    itemButton   = SM_CONFIG_DEFAULT_ITEMKEY;
}

SME_GLOBAL NSUserDefaults *defaults;
SME_GLOBAL SMEConfigRef config;

typedef enum {
    kSMConfigTypeString,
    kSMConfigTypeDouble,
    kSMConfigTypeFloat,
    kSMConfigTypeInt64,
    kSMConfigTypeInt32,
    kSMConfigTypeInt16,
    kSMConfigTypeChar,
    kSMConfigTypeBool
} ConfigType;

SMEConfigRef loadConfigCallback()
{
    return config;
}

void saveConfigCallback()
{
    void (^save)(CString, ConfigType) = ^(CString label, ConfigType type) {
        NSString *labelNSString = [NSString stringWithUTF8String:label];
        MemoryAddress value = SMEConfigGet(config, label);

        if (value) {
            #define NUMBER_ENTRY(t, e) \
                case e: { \
                    [defaults setInteger:SMEConfigValueAsType(value, t) forKey:labelNSString]; \
                } break;

            switch (type)
            {
                NUMBER_ENTRY(char, kSMConfigTypeChar);
                NUMBER_ENTRY(UInt16, kSMConfigTypeInt16);
                NUMBER_ENTRY(UInt32, kSMConfigTypeInt32);
                NUMBER_ENTRY(UInt64, kSMConfigTypeInt64);
                case kSMConfigTypeBool: {
                    [defaults setBool:SMEConfigValueAsType(value, BOOL) forKey:labelNSString];
                } break;
                case kSMConfigTypeFloat: {
                    [defaults setFloat:SMEConfigValueAsType(value, float) forKey:labelNSString];
                } break;
                case kSMConfigTypeDouble: {
                    [defaults setDouble:SMEConfigValueAsType(value, double) forKey:labelNSString];
                } break;
                case kSMConfigTypeString: {
                    NSString *string = [NSString stringWithUTF8String:(CString)value];
                    [defaults setObject:string forKey:[NSString stringWithUTF8String:label]];
                } break;
            }

            #undef NUMBER_ENTRY
        } else {
            [defaults removeObjectForKey:[NSString stringWithUTF8String:label]];
        }
    };

    save(configHeightString,   kSMConfigTypeInt32);
    save(configWidthString,    kSMConfigTypeInt32);
    save(configUpKeyString,    kSMConfigTypeInt16);
    save(configDownKeyString,  kSMConfigTypeInt16);
    save(configLeftKeyString,  kSMConfigTypeInt16);
    save(configRightKeyString, kSMConfigTypeInt16);
    save(configPauseButtonStr, kSMConfigTypeInt16);
    save(configRunButtonStr,    kSMConfigTypeInt16);
    save(configNJumpButtonStr,  kSMConfigTypeInt16);
    save(configSJumpButtonStr,  kSMConfigTypeInt16);
    save(configItemButtonStr,   kSMConfigTypeInt16);

    // sync config
    [defaults synchronize];

    // reload config
    [[[SMAppDelegate delegate] window] reloadConfig];
    SMEReloadConfig();
}

void initConfig()
{
    config = SMEConfigCreate(NULL);

    void (^add)(MemoryAddress, ConfigType, CString) = ^(MemoryAddress value, ConfigType type, CString label) {
        NSString *labelNSString = [NSString stringWithUTF8String:label];
        id configValue = [defaults objectForKey:labelNSString];

        if (configValue) {
            #define NUMBER_ENTRY(t, e) \
                case e: { \
                    t *typeValue = (t *)value; \
                    (*typeValue) = (t)[defaults integerForKey:labelNSString]; \
                } break;

            switch (type)
            {
                NUMBER_ENTRY(char,   kSMConfigTypeChar);
                NUMBER_ENTRY(UInt16, kSMConfigTypeInt16);
                NUMBER_ENTRY(UInt32, kSMConfigTypeInt32);
                NUMBER_ENTRY(UInt64, kSMConfigTypeInt64);
                case kSMConfigTypeBool: {
                    BOOL *boolValue = (BOOL *)value;
                    (*boolValue) = [defaults boolForKey:labelNSString];
                } break;
                case kSMConfigTypeFloat: {
                    float *floatValue = (float *)value;
                    (*floatValue) = [defaults floatForKey:labelNSString];
                } break;
                case kSMConfigTypeDouble: {
                    double *doubleValue = (double *)value;
                    (*doubleValue) = [defaults doubleForKey:labelNSString];
                } break;
                case kSMConfigTypeString: {
                    CString stringVal = (String)value;
                    stringVal = [[defaults stringForKey:labelNSString] UTF8String];
                } break;
            }

            #undef NUMBER_ENTRY
        }

        if (!SMEConfigSet(config, label, value, YES))
        {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setAlertStyle:NSCriticalAlertStyle];
            [alert setMessageText:@"An Error occurred loading config!"];
            [alert runModal];
        }
    };

    add(&configHeight, kSMConfigTypeInt32, configHeightString  );
    add(&configWidth,  kSMConfigTypeInt32, configWidthString   );
    add(&keyUp,        kSMConfigTypeInt16, configUpKeyString   );
    add(&keyDown,      kSMConfigTypeInt16, configDownKeyString );
    add(&keyLeft,      kSMConfigTypeInt16, configLeftKeyString );
    add(&keyRight,     kSMConfigTypeInt16, configRightKeyString);
    add(&pauseButton,  kSMConfigTypeInt16, configPauseButtonStr);
    add(&runButton,    kSMConfigTypeInt16, configRunButtonStr  );
    add(&njumpButton,  kSMConfigTypeInt16, configNJumpButtonStr);
    add(&sjumpButton,  kSMConfigTypeInt16, configSJumpButtonStr);
    add(&itemButton,   kSMConfigTypeInt16, configItemButtonStr );
}
