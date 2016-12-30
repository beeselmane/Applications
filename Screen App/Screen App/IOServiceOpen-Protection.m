#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#include <dlfcn.h>

typedef kern_return_t (*IOServiceOpenFunction)(io_service_t, task_port_t, uint32_t, io_connect_t *);
typedef uint64_t mach_substitution;

void *mach_hook_init(char const *library_filename, void const *library_address);
mach_substitution mach_hook(void const *handle, char const *function_name, mach_substitution substitution);
void mach_hook_free(void *handle);
extern void *IOMobileFramebufferGetTypeID();

static IOServiceOpenFunction IOServiceOpen_original = NULL;
static IOServiceOpenFunction IOServiceOpen_custom = NULL;

kern_return_t IOServiceOpen_new(io_service_t service, task_port_t owningTask, uint32_t type, io_connect_t *connect)
{
    if (__builtin_expect((type == 3), NO)) return IOServiceOpen_original(service, owningTask, type, connect);
    else return IOServiceOpen_original(service, owningTask, 0, connect);
}

BOOL IOServiceOpen_RemoveProtection(void)
{
    IOServiceOpen_custom = IOServiceOpen_new;

    mach_substitution original;
    void *handle = 0;
    Dl_info info;

    if (!dladdr(IOMobileFramebufferGetTypeID, &info))
    {
        NSLog(@"Error: Failed to get info for the IOMobileFramebuffer framework!!");
        return NO;
    }

    printf("%s\n", info.dli_fname);

    return NO;
}
