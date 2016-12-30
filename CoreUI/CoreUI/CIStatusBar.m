#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "CIStatusBar.h"
#import "OSArtwork.h"

extern int CTGetSignalStrength();

@implementation CINetworkStatus

- (NSString *) carrierName
{
    return [[[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider] carrierName];
}

- (NSString *) networkName
{
    return @"???";
}

- (NSUInteger) carrierLevel
{
    static NSUInteger clevel = 0;
    static BOOL down = NO;
    NSUInteger rv = -1;

    if (down) rv = clevel--;
    else rv = clevel++;

    if (down && clevel == -1) {
        clevel = 0;
        down = NO;
    } else if (clevel == 6) {
        clevel = 5;
        down = YES;
    }

    return rv;
}

- (NSUInteger) wifiLevel
{
    return -1;
}

- (BOOL) hasCarrierService
{
    return ([self carrierLevel] > 0);
}

- (BOOL) hasWiFiNetwork
{
    return ([self wifiLevel] > 0);
}

@end

@implementation CIStatusBar
{
    CTTelephonyNetworkInfo *netInfo;
    NSTimer *dateTimer;

    UIImage *cellStatusImages[6];
    UIImageView *cellStatusView;
}

@dynamic origin_y;
@dynamic height;

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0.0F, frame.origin.y, [[UIScreen mainScreen] bounds].size.width, frame.size.height)];

    if (self)
    {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        _batteryLevel = [[UIDevice currentDevice] batteryLevel] * 100.0F;

        netInfo = [[CTTelephonyNetworkInfo alloc] init];
        [netInfo setSubscriberCellularProviderDidUpdateNotifier:^(CTCarrier *newCarrier) {
            // Update Status
        }];

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:[NSDate date]];
        NSInteger currentSecond = [components second];

        NSDate *fireDate = [[NSDate date] dateByAddingTimeInterval:(60 - currentSecond) + 1];
        dateTimer = [[NSTimer alloc] initWithFireDate:fireDate interval:60 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:dateTimer forMode:NSDefaultRunLoopMode];
        _displayTime = [fireDate dateByAddingTimeInterval:-61];
        _networkStatus = [[CINetworkStatus alloc] init];

        for (NSInteger i = 0; i < 6; i++)
        {
            cellStatusImages[i] = [OSArtwork imageNamed:[NSString stringWithFormat:@"Black_%lu_Bars", (unsigned long)i]];
            cellStatusImages[i] = [cellStatusImages[i] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }

        cellStatusView = [[UIImageView alloc] initWithImage:cellStatusImages[[_networkStatus carrierLevel]]];
        [cellStatusView setFrame:CGRectMake(6.0F, 0.0F, 34.5F, 20.0F)];
        [self addSubview:cellStatusView];

        [NSTimer scheduledTimerWithTimeInterval:0.025F target:self selector:@selector(boop) userInfo:nil repeats:YES];
    }

    return self;
}

- (void) boop
{
    [cellStatusView setImage:cellStatusImages[[_networkStatus carrierLevel]]];
}

- (void) setForegroundColor:(UIColor *)foregroundColor
{
    [cellStatusView setTintColor:foregroundColor];

    _foregroundColor = foregroundColor;
}

- (void) updateTime
{
    _displayTime = [_displayTime dateByAddingTimeInterval:60];
}

- (void) setDisplayTime:(NSDate *)displayTime
{
    _displayTime = displayTime;
    [dateTimer invalidate];
}

- (void) setHeight:(CGFloat)height
{
    CGRect f = [self frame];
    [self setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, height)];
}

- (CGFloat) height
{
    return [self frame].size.height;
}

- (void) setOrigin_Y:(CGFloat)origin_y
{
    CGRect f = [self frame];
    [self setFrame:CGRectMake(f.origin.x, origin_y, f.size.width, f.size.height)];
}

- (CGFloat) origin_y
{
    return [self frame].origin.y;
}

@end
