#ifndef __ENGINE_SMEBASE__
#define __ENGINE_SMEBASE__ 1

#if !defined(__has_include)
    #define __has_include(x) 0
#endif /* !defined(__has_include) */

#if __has_include(<TargetConditionals.h>)
    #include <TargetConditionals.h>
#endif /* __has_include(<TargetConditionals.h>) */

#if (defined(__CYGWIN32__) || defined(_WIN32)) && !defined(__WIN32__)
    #define __WIN32__  1
    #define __MS_WIN__ 1
#endif /* __WIN32__ */

#if defined(_WIN64) && !defined(__WIN64__)
    #define __WIN64__  1
    #define __MS_WIN__ 1
#endif /* __WIN64 */

#if defined(__WIN64__) && !defined(__LLP64__)
    #define __LLP64__ 1
#endif /* __LLP64__ */

#if (defined(__i386__) || defined(__x86_64__)) && !defined(__LITTLE_ENDIAN__)
    #define __LITTLE_ENDIAN__ 1
#endif /* __LITTLE_ENDIAN__ */

#if defined(__ppc__) && !defined(__BIG_ENDIAN__)
    #define __BIG_ENDIAN__ 1
#endif /* __BIG_ENDIAN__ */

#if !defined(__BIG_ENDIAN__) && !defined(__LITTLE_ENDIAN__)
    #error Could not determine Endian!
#endif /* NO_ENDIAN */

#if (__BIG_ENDIAN__ && __LITTLE_ENDIAN__) || (!__BIG_ENDIAN__ && !__LITTLE_ENDIAN__)
    #error Endian Conflict!
#endif /* ENDIAN_CONFLICT */

#if defined(__MS_WIN__) && __MS_WIN__
    #if !defined(SME_EXPORT)
        #if defined(__GE_INTERN__) && defined(__cplusplus)
            #define SME_EXPORT extern "C" __declspec(dllexport)
        #elif defined(__GE_INTERN__) && !defined(__cplusplus)
            #define SME_EXPORT extern __declspec(dllexport)
        #elif defined(__cplusplus)
            #define SME_EXPORT extern "C" __declspec(dllimport)
        #else /* !C++ && !GE_INTERN */
            #define SME_EXPORT extern __declspec(dllimport)
        #endif /* SME_EXPORT */
    #endif /* !defined(SME_EXPORT) */
#else /* !__WIN32__ */
    #define SME_EXPORT extern
#endif /* !defined(GE_EXPORT) */

#ifndef SME_GLOBAL
    #define SME_GLOBAL
#endif /* !defined(GE_GLOBAL) */

#ifndef NO_RETURN
    #define NO_RETURN __attribute__((noreturn))
#endif /* !defined(NO_RETURN) */

#include <stdint.h>

#if !defined(bool)
    #if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
        typedef _Bool bool;
    #else /* < C99 */
        #define bool int
    #endif /* !defined(bool) */
#endif /* !defined(bool) */

#if !defined(true)
    #define true  1
#endif /* !defined(true) */

#if !defined(false)
    #define false 0
#endif /* !defined(false) */

#if !defined(NULL)
    #define NULL ((void *)0)
#endif /* !defined(NULL) */

typedef uint8_t     UInt8;
typedef uint16_t    UInt16;
typedef uint32_t    UInt32;
typedef uint64_t    UInt64;

typedef int8_t      SInt8;
typedef int16_t     SInt16;
typedef int32_t     SInt32;
typedef int64_t     SInt64;

typedef bool        Boolean;
typedef UInt64      Offset;
typedef UInt64      Size;

typedef UInt8       SingleByte;
typedef UInt16      DoubleByte;
typedef UInt32      QuadByte;
typedef UInt64      OctaByte;

typedef SingleByte  SingleByteSet[1];
typedef SingleByte  DoubleByteSet[2];
typedef SingleByte  QuadByteSet  [4];
typedef SingleByte  OctaByteSet  [8];

typedef char       *String;
typedef const char *CString;
typedef void       *MemoryAddress;

SME_EXPORT double EngineVersionNumber;
SME_EXPORT const unsigned char EngineVersionString[];

// Defines

#define SME_CONFIG_WINDOW_HEIGHT "Window Height"
#define SME_CONFIG_WINDOW_WIDTH  "Window Width"
#define SME_CONFIG_UP_BUTTON     "Up Key"
#define SME_CONFIG_DOWN_BUTTON   "Down Key"
#define SME_CONFIG_LEFT_BUTTON   "Left Key"
#define SME_CONFIG_RIGHT_BUTTON  "Right Key"
#define SME_CONFIG_PAUSE_BUTTON  "Pause Button"
#define SME_CONFIG_RUN_BUTTON    "Run Button"
#define SME_CONFIG_NJUMP_BUTTON  "Normal Jump"
#define SME_CONFIG_SJUMP_BUTTON  "Spin Jump"
#define SME_CONFIG_ITEM_BUTTON   "Item Button"

#endif /* !defined(__ENGINE_SMEBASE__) */
