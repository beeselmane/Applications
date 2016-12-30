#import "SMPrefWindow.h"

@implementation SMPrefWindow

@end

@implementation SMControlFieldFormatter

- (NSString *)stringForObjectValue:(id)object {
    return (NSString *)object;
}

- (BOOL)getObjectValue:(id *)object forString:(NSString *)string errorDescription:(NSString **)error {
    *object = string;
    return YES;
}

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error
{
    if ([partialString length] != 1) return NO;

    if (![partialString isEqualToString:[partialString uppercaseString]])
    {
        (*newString) = [partialString uppercaseString];
        return NO;
    }

    return YES;
}

- (NSAttributedString *)attributedStringForObjectValue:(id)anObject withDefaultAttributes:(NSDictionary *)attributes
{
    return nil;
}

@end
