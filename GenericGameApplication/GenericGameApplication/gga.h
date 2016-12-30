#ifndef _GGA_H_
#define _GGA_H_ 1

typedef unsigned char UInt8;
typedef unsigned short UInt16;
typedef unsigned int  UInt32;
typedef unsigned long Length;
typedef unsigned long Offset;
typedef       char   *String;
typedef const char   *CString;
typedef       void   *MemoryAddress;

#ifndef _GG_INTERNAL_
    #define NAME_FUNC         GGetGameName
    #define KEY_FUNC          GHandleKeyPress
    #define EXEC_RUNLOOP_FUNC GExecRunLoop
    #define INIT_FUNC         GInitGL
    #define CLOSE_FUNC        GCloseGame
    #define RESIZE_FUNC       GResizeWindow
#else /* _GG_INTERNAL_ */
    #define NAME_FUNC         "GGetGameName"
    #define KEY_FUNC          "GHandleKeyPress"
    #define EXEC_RUNLOOP_FUNC "GExecRunLoop"
    #define INIT_FUNC         "GInitGL"
    #define CLOSE_FUNC        "GCloseGame"
    #define RESIZE_FUNC       "GResizeWindow"
#endif /* _GG_INTERNAL_ */

typedef struct FileBuffer {
    MemoryAddress data;
    Length size;
} *FileBufferRef;

typedef MemoryAddress (*GGRequestFunction)(int code, MemoryAddress data);

typedef enum {
    kGGActionPause,
    kGGActionGetResource,
} GGRequestAction;

static const char SKAlphaShiftKey = -1;
static const char SKShiftKey = -2;
static const char SKControlKey = -3;
static const char SKAltKey = -4;
static const char SKCommandKey = -5;
static const char SKNumberPad = -6;
static const char SKHelpKey = -7;
static const char SKFunctionKey = -8;

#endif /* _GGA_H_ */
