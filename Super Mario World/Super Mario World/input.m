#import <Foundation/Foundation.h>
#import "SMAppDelegate.h"
#import "SMWindow.h"

bool isClosed()
{
    return(false);
}

CString getResource(CString resource)
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    return [[NSString stringWithFormat:@"%@/%s", resourcePath, resource] UTF8String];
}
