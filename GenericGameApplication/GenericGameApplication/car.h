#include "gga.h"

struct CARFileEntry
{
    CString name;
    Length namesize;
    Length size;
    Offset offset;
    UInt16 checksum;
};

typedef struct CFIterator *CFIteratorRef;

#define EXPORT extern

EXPORT CFIteratorRef CARFileCreateIterator(CString file);
EXPORT struct CARFileEntry *CARFileIteratorGetNext(CFIteratorRef iterator);
EXPORT void CARFileDestroyIterator(CFIteratorRef iterator);
EXPORT bool CARFileIsIteratorDone(CFIteratorRef iterator);
EXPORT Length CARFileGetIteratorFileCount(CFIteratorRef iterator);
