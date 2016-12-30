#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CIStatusBarStyle) {
    kCIStatusBarStyleLockScreen,
    kCIStatusBarStyleRegular
};

typedef struct {
    BOOL bluetoothEnabled;
} CIStatusBarIconState;

@interface CINetworkStatus : NSObject

@property (readonly, strong) NSString *carrierName;
@property (readonly, strong) NSString *networkName;

@property (readonly) NSUInteger carrierLevel;
@property (readonly) NSUInteger wifiLevel;

@property (readonly) BOOL hasCarrierService;
@property (readonly) BOOL hasWiFiNetwork;
@property (readonly) BOOL airplaneMode;

@end

@interface CIStatusBar : UIView

@property (strong, nonatomic) NSDate *displayTime;
@property CINetworkStatus *networkStatus;
@property CGFloat batteryLevel;
@property CIStatusBarIconState iconState;
@property BOOL bluetoothActive;

@property (strong, nonatomic) UIColor *foregroundColor;
@property (setter=setOrigin_Y:) CGFloat origin_y;
@property CGFloat height;

@end
