#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Weverything"
#pragma clang diagnostic ignored "-Wextra"
#pragma clang diagnostic ignored "-Wall"

@class BKSAnimationFenceHandle;
@class FBSDisplayLayoutMonitor;
@class BKSProcessAssertion;
@class _UIGameControllerEvent;
@class _UIIdleModeController;
@class UIMoveEvent;
@class UNSNotificationScheduler;
@class UIPhysicalKeyboardEvent;
@class UIPressesEvent;
@class UNSRemoteNotificationRegistrar;
@class UIApplicationSceneSettingsDiffInspector;
@class SBSApplicationShortcutService;
@class UISystemNavigationAction;
@class _UIIdleModeController;
@class UIRepeatedAction;
@class UNSUserNotificationRegistrar;
@class UIWheelEvent;

@interface UIApplication ()
{
    id /* block */ ___queuedOrientationChange;
    int __expectedViewOrientation;
    NSMutableSet *_actionsPendingInitialization;
    BOOL _alwaysHitTestsForMainScreen;
    struct {
        unsigned int deactivatingReasonFlags : 13;
        unsigned int isSuspended : 1;
        unsigned int isSuspendedEventsOnly : 1;
        unsigned int isLaunchedSuspended : 1;
        unsigned int calledNonSuspendedLaunchDelegate : 1;
        unsigned int calledSuspendedLaunchDelegate : 1;
        unsigned int isHandlingURL : 1;
        unsigned int statusBarShowsProgress : 1;
        unsigned int statusBarHidden : 1;
        unsigned int statusBarHiddenDefault : 1;
        unsigned int statusBarHiddenVerticallyCompact : 1;
        unsigned int blockInteractionEvents : 4;
        unsigned int receivesMemoryWarnings : 1;
        unsigned int showingProgress : 1;
        unsigned int receivesPowerMessages : 1;
        unsigned int launchEventReceived : 1;
        unsigned int activateEventReceived : 1;
        unsigned int systemIsAnimatingApplicationLifecycleEvent : 1;
        unsigned int isActivating : 1;
        unsigned int isSuspendedUnderLock : 1;
        unsigned int shouldExitAfterSendSuspend : 1;
        unsigned int terminating : 1;
        unsigned int isHandlingShortCutURL : 1;
        unsigned int idleTimerDisabled : 1;
        unsigned int deviceOrientation : 3;
        unsigned int delegateShouldBeReleasedUponSet : 1;
        unsigned int delegateHandleOpenURL : 1;
        unsigned int delegateOpenURL : 1;
        unsigned int delegateOpenURLOptions : 1;
        unsigned int delegateDidReceiveMemoryWarning : 1;
        unsigned int delegateWillTerminate : 1;
        unsigned int delegateSignificantTimeChange : 1;
        unsigned int delegateWillChangeInterfaceOrientation : 1;
        unsigned int delegateDidChangeInterfaceOrientation : 1;
        unsigned int delegateWillChangeStatusBarFrame : 1;
        unsigned int delegateDidChangeStatusBarFrame : 1;
        unsigned int delegateDeviceAccelerated : 1;
        unsigned int delegateDeviceChangedOrientation : 1;
        unsigned int delegateDidBecomeActive : 1;
        unsigned int delegateWillResignActive : 1;
        unsigned int delegateDidEnterBackground : 1;
        unsigned int delegateDidEnterBackgroundWasSent : 1;
        unsigned int delegateWillEnterForeground : 1;
        unsigned int delegateWillSuspend : 1;
        unsigned int delegateDidResume : 1;
        unsigned int delegateSupportsStateRestoration : 1;
        unsigned int delegateSupportedInterfaceOrientations : 1;
        unsigned int delegateHandleSiriTask : 1;
        unsigned int delegateSupportsWatchKitRequests : 1;
        unsigned int idleModeVisualEffectsEnabled : 1;
        unsigned int userDefaultsSyncDisabled : 1;
        unsigned int headsetButtonClickCount : 4;
        unsigned int isHeadsetButtonDown : 1;
        unsigned int isFastForwardActive : 1;
        unsigned int isRewindActive : 1;
        unsigned int shakeToEdit : 1;
        unsigned int zoomInClassicMode : 1;
        unsigned int ignoreHeadsetClicks : 1;
        unsigned int touchRotationDisabled : 1;
        unsigned int taskSuspendingUnsupported : 1;
        unsigned int taskSuspendingOnLockUnsupported : 1;
        unsigned int isUnitTests : 1;
        unsigned int requiresHighResolution : 1;
        unsigned int singleUseLaunchOrientation : 3;
        unsigned int defaultInterfaceOrientation : 3;
        unsigned int supportedInterfaceOrientationsMask : 5;
        unsigned int delegateWantsNextResponder : 1;
        unsigned int isRunningInApplicationSwitcher : 1;
        unsigned int isSendingEventForProgrammaticTouchCancellation : 1;
        unsigned int delegateWantsStatusBarTouchesEnded : 1;
        unsigned int interfaceLayoutDirectionIsValid : 1;
        unsigned int interfaceLayoutDirection : 3;
        unsigned int restorationExtended : 1;
        unsigned int normalRestorationInProgress : 1;
        unsigned int normalRestorationCompleted : 1;
        unsigned int isDelayingTintViewChange : 1;
        unsigned int isUpdatingTintViewColor : 1;
        unsigned int isHandlingMemoryWarning : 1;
        unsigned int forceStatusBarTintColorChanges : 1;
        unsigned int disableLegacyAutorotation : 1;
        unsigned int couldNotRestoreStateWhenLocked : 1;
        unsigned int disableStyleOverrides : 1;
        unsigned int legibilityAccessibilitySettingEnabled : 1;
        unsigned int viewControllerBasedStatusBarAppearance : 1;
        unsigned int fakingRequiresHighResolution : 1;
        unsigned int isStatusBarFading : 1;
        unsigned int systemWindowsSecure : 1;
        unsigned int isFrontBoardForeground : 1;
        unsigned int isObservingPIP : 1;
        unsigned int shouldRestoreKeyboardInputState : 1;
        unsigned int subclassOverridesInterfaceOrientation : 1;
    } _applicationFlags;
    UIWindow *_backgroundHitTestWindow;
    BKSAnimationFenceHandle *_cachedSystemAnimationFence;
    struct __CFDictionary { } *_childEventMap;
    int _classicMode;
    NSProgress *_currentActivityContinuationProgress;
    BOOL _currentActivityContinuationProgressDisplayingUI;
    NSString *_currentActivityContinuationType;
    NSString *_currentActivityContinuationUUIDString;
    struct CGPoint _currentLocationWhereFirstTouchCameDown;
    double _currentTimestampWhenFirstTouchCameDown;
    UIColor *_defaultTopNavBarTintColor;
    void *_delegate;
    int _disableTouchCoalescingCount;
    FBSDisplayLayoutMonitor *_displayLayoutMonitor;
    /*UIAlertView **/id _editAlertView;
    NSMutableDictionary *_estimatedTouchRecordsByContextID;
    UIEvent *_event;
    NSMutableArray *_eventQueue;
    NSMutableSet *_exclusiveTouchWindows;
    unsigned int _externalDeactivationReasons;
    BKSProcessAssertion *_fenceTaskAssertion;
    _UIGameControllerEvent *_gameControllerEvent;
    NSTimer *_hideNetworkActivityIndicatorTimer;
    _UIIdleModeController *_idleModeController;
    NSMutableSet *_idleTimerDisabledReasons;
    int _ignoredStyleOverrides;
    UIRepeatedAction *_keyRepeatAction;
    struct CGPoint _lastLocationWhereAllTouchesLifted;
    struct CGPoint _lastLocationWhereFirstTouchCameDown;
    double _lastTimestampWhenAllTouchesLifted;
    double _lastTimestampWhenFirstTouchCameDown;
    NSString *_mainStoryboardName;
    UIEvent *_motionEvent;
    UIMoveEvent *_moveEvent;
    int _networkResourcesCurrentlyLoadingCount;
    UNSNotificationScheduler *_notificationScheduler;
    NSMutableArray *_observerBlocks;
    NSMutableDictionary *_physicalKeyCommandMap;
    UIPhysicalKeyboardEvent *_physicalKeyboardEvent;
    NSMutableOrderedSet *_physicalKeycodeMap;
    NSMutableArray *_postCommitActions;
    BOOL _postCommitActionsNeedToSynchronize;
    NSString *_preferredContentSizeCategory;
    NSString *_preferredContentSizeCategoryName;
    UIPressesEvent *_pressesEvent;
    NSMutableDictionary *_pressesMap;
    int _redoButtonIndex;
    UIEvent *_remoteControlEvent;
    int _remoteControlEventObservers;
    UNSRemoteNotificationRegistrar *_remoteNotificationRegistrar;
    BOOL _saveStateRestorationArchiveWithFileProtectionCompleteUntilFirstUserAuthentication;
    BOOL _sceneSettingsGeometryHostingBoundsMutated;
    BOOL _sceneSettingsGeometryInterfaceOrientationMutated;
    UIApplicationSceneSettingsDiffInspector *_sceneSettingsGeometryMutationDiffInspector;
    UIApplicationSceneSettingsDiffInspector *_sceneSettingsPostLifecycleEventDiffInspector;
    UIApplicationSceneSettingsDiffInspector *_sceneSettingsPreLifecycleEventDiffInspector;
    SBSApplicationShortcutService *_shortcutService;
    UIStatusBar *_statusBar;
    int _statusBarRequestedStyle;
    NSMutableArray *_statusBarTintColorLockingControllers;
    int _statusBarTintColorLockingCount;
    UIStatusBarWindow *_statusBarWindow;
    UISystemNavigationAction *_systemNavigationAction;
    NSMutableArray *_tintViewDurationStack;
    NSArray *_topLevelNibObjects;
    UIEvent *_touchesEvent;
    int _undoButtonIndex;
    UNSUserNotificationRegistrar *_userNotificationRegistrar;
    int _virtualHorizontalSizeClass;
    int _virtualVerticalSizeClass;
    struct CGSize _virtualWindowSizeInSceneReferenceSpace;
    UIWheelEvent *_wheelEvent;
    BOOL optOutOfRTL;
}

- (void) setDoubleHeightMode:(int)arg1;
- (void) setDoubleHeightMode:(int)arg1 glowAnimationEnabled:(BOOL)arg2;
- (void) setDoubleHeightPrefixText:(id)arg1;
- (void) setDoubleHeightStatusText:(id)arg1;
- (void) setDoubleHeightStatusText:(id)arg1 forStyle:(int)arg2;
- (int) doubleHeightMode;
- (void)addStatusBarStyleOverrides:(int)arg1;
- (CGFloat) statusBarHeight;

@end

@interface _UIScrollsToTopInitiatorView : UIView

- (BOOL) _shouldSeekHigherPriorityTouchTarget;
- (id) hitTest:(CGPoint)arg1 withEvent:(id)arg2;
- (id) initWithCoder:(id)arg1;
- (id) initWithFrame:(CGRect)arg1;
- (void) touchesEnded:(id)arg1 withEvent:(id)arg2;

@end

@protocol UIStatusBarStateObserver;
@class UIStatusBarBackgroundView;
@class UIStatusBarForegroundView;
@class UIStatusBarStateProvider;
@protocol UIStatusBarStateProvider;
@class UIStatusBarStyleAnimationParameters;
@class UIStatusBarStyleAttributes;
@protocol UIStatusBarStyleDelegate;
@protocol UIStatusBarStyleDelegate;
@class UIStatusBarStyleDelegate;
@class UIStatusBarStyleRequest;
@class UIStatusBarServer;

typedef NS_ENUM(NSUInteger, UIStatusBarItem) {
    UIStatusBarItemClock = 0,
    UIStatusBarItemDoNotDisturb = 1,
    UIStatusBarItemAirplaneMode = 2,
    UIStatusBarItemCellConnectivity = 3,
    UIStatusBarItemCarrierName = 4,
    UIStatusBarItemNetworkType = 5,
    UIStatusBarItemRightClock = 6,
    UIStatusBarItemBattery = 7,
    UIStatusBarItemBatteryPercentage = 8,
    UIStatusBarItemBatteryPercentageBluetooth = 9,
    UIStatusBarItemBatteryBluetooth = 10,
    UIStatusBarItemBluetoothEnabled = 11,
    UIStatusBarItemPhoneTTY = 12,
    UIStatusBarItemAlarmSet = 13,
    UIStatusBarItemPlus = 14,
    UIStatusBarItemLocationServices = 16,
    UIStatusBarItemRotationLocked = 17,
    UIStatusBarItemAirPlayStreaming = 18,
    UIStatusBarItemDictationEnabled = 19,
    UIStatusBarItemPlayCircledPlayButton = 21,
    UIStatusBarItemVPNConnected = 22,
    UIStatusBarItemCallForwarding = 23,
    UIStatusBarItemNetworkActivity = 24,
    UIStatusBarItemBlackSquare = 25,
};

typedef struct {
    BOOL enabledItems[27];
    BOOL x2[64];
    int x3;
    int x4;
    BOOL x5[100];
    BOOL x6[100];
    BOOL x7[2][100];
    BOOL x8[1024];
    unsigned int x9;
    int wifiConnection;
    int x11;
    unsigned int x12;
    int batteryPercentage;
    unsigned int chargingFlag;
    BOOL x15[150];
    int x16;
    int x17;
    unsigned int x18 : 1;
    unsigned int x19 : 1;
    unsigned int x20 : 1;
    BOOL x21[256];
    unsigned int x22 : 1;
    unsigned int x23 : 1;
    unsigned int x24 : 1;
    unsigned int x25 : 1;
    unsigned int x26 : 1;
    unsigned int x27;
    unsigned int x28 : 1;
    UInt8 pad0[256];
    UInt8 pad1[256];
} UIStatusBarData;

typedef struct {
    BOOL overriddenItems[27];
    unsigned int x2 : 1;
    unsigned int x3 : 1;
    unsigned int x4 : 1;
    unsigned int x5 : 1;
    unsigned int x6 : 2;
    unsigned int x7 : 1;
    unsigned int x8 : 1;
    unsigned int x9 : 1;
    unsigned int x10 : 1;
    unsigned int x11 : 1;
    unsigned int x12 : 1;
    unsigned int overrideBatteryStatus : 1;
    unsigned int x14 : 1;
    unsigned int x15 : 1;
    unsigned int x16 : 1;
    unsigned int x17 : 1;
    unsigned int x18 : 1;
    unsigned int x19 : 1;
    unsigned int x20 : 1;
    unsigned int x21 : 1;
    unsigned int x22 : 1;
    unsigned int x23 : 1;
    UIStatusBarData data;
} UIStatusBarOverrideData;

@protocol UIStatusBarServerClient

- (void) statusBarServer:(UIStatusBarServer *)arg1 didReceiveDoubleHeightStatusString:(NSString *)arg2 forStyle:(long long)arg3;
- (void) statusBarServer:(UIStatusBarServer *)arg1 didReceiveGlowAnimationState:(BOOL)arg2 forStyle:(long long)arg3;
- (void) statusBarServer:(UIStatusBarServer *)arg1 didReceiveStyleOverrides:(int)arg2;
- (void) statusBarServer:(UIStatusBarServer *)arg1 didReceiveStatusBarData:(const UIStatusBarData *)arg2 withActions:(int)arg3;

@end

@protocol UIStatusBarStateObserver <NSObject>
- (void) statusBarStateProvider:(id)provider didPostStatusBarData:(const UIStatusBarData *)data withActions:(int)actions;
@end

@interface UIStatusBar : _UIScrollsToTopInitiatorView <UIStatusBarServerClient, UIStatusBarStateObserver> {
    UIStatusBarBackgroundView *_backgroundView;
    NSString *_currentDoubleHeightText;
    struct {
        BOOL itemIsEnabled[27];
        BOOL timeString[64];
        int gsmSignalStrengthRaw;
        int gsmSignalStrengthBars;
        BOOL serviceString[100];
        BOOL serviceCrossfadeString[100];
        BOOL serviceImages[2][100];
        BOOL operatorDirectory[1024];
        unsigned int serviceContentType;
        int wifiSignalStrengthRaw;
        int wifiSignalStrengthBars;
        unsigned int dataNetworkType;
        int batteryCapacity;
        unsigned int batteryState;
        BOOL batteryDetailString[150];
        int bluetoothBatteryCapacity;
        int thermalColor;
        unsigned int thermalSunlightMode : 1;
        unsigned int slowActivity : 1;
        unsigned int syncActivity : 1;
        BOOL activityDisplayId[256];
        unsigned int bluetoothConnected : 1;
        unsigned int displayRawGSMSignal : 1;
        unsigned int displayRawWifiSignal : 1;
        unsigned int locationIconType : 1;
        unsigned int quietModeInactive : 1;
        unsigned int tetheringConnectionCount;
        unsigned int batterySaverModeActive : 1;
        BOOL breadcrumbTitle[256];
        BOOL breadcrumbSecondaryTitle[256];
    } _currentRawData;
    NSMutableSet *_disableRasterizationReasons;
    UILabel *_doubleHeightLabel;
    UIView *_doubleHeightLabelContainer;
    BOOL _foreground;
    UIColor *_foregroundColor;
    UIStatusBarForegroundView *_foregroundView;
    BOOL _foregroundViewShouldIgnoreStatusBarDataDuringAnimation;
    BOOL _hidden;
    BOOL _homeItemsDisabled;
    id<UIStatusBarStateProvider> _inProcessProvider;
    NSMutableArray *_interruptedAnimationCompositeViews;
    UIColor *_lastUsedBackgroundColor;
    int _legibilityStyle;
    UIStatusBarOverrideData *_localDataOverrides;
    UIStatusBarBackgroundView *_newStyleBackgroundView;
    UIStatusBarForegroundView *_newStyleForegroundView;
    UIStatusBarStyleAnimationParameters *_nextTintTransition;
    int _orientation;
    NSNumber *_overrideHeight;
    BOOL _persistentAnimationsEnabled;
    BOOL _registered;
    int _requestedStyle;
    BOOL _reservesEmptyTimeRegion;
    BOOL _serverUpdatesDisabled;
    BOOL _showOnlyCenterItems;
    BOOL _showsForeground;
    BOOL _simulatesLegacyAppearance;
    UIStatusBar *_slidingStatusBar;
    UIStatusBarServer *_statusBarServer;
    UIStatusBarWindow *_statusBarWindow;
    UIStatusBarStyleAttributes *_styleAttributes;
    id<UIStatusBarStyleDelegate> _styleDelegate;
    int _styleOverrides;
    BOOL _suppressGlow;
    BOOL _suppressesHiddenSideEffects;
    UIColor *_tintColor;
    float _translucentBackgroundAlpha;
    BOOL _waitingOnCallbackAfterChangingStyleOverridesLocally;
}

@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSString *description;
@property (nonatomic, retain) UIColor *foregroundColor;
@property (readonly) NSUInteger hash;
@property (nonatomic) BOOL homeItemsDisabled;
@property (nonatomic) int legibilityStyle;
@property (nonatomic) BOOL persistentAnimationsEnabled;
@property (nonatomic) BOOL serverUpdatesDisabled;
@property (nonatomic) BOOL simulatesLegacyAppearance;
@property (nonatomic) UIStatusBarWindow *statusBarWindow;
@property (nonatomic) id<UIStatusBarStyleDelegate> styleDelegate;
@property (nonatomic, readonly) int styleOverrides;
@property (nonatomic, copy) UIStatusBarStyleRequest *styleRequest;
@property (readonly) Class superclass;

+ (int)_defaultStyleForRequestedStyle:(int)arg1 styleOverrides:(int)arg2 simulateLegacyAppearance:(BOOL)arg3;
+ (CGRect)_frameInSceneReferenceSpaceForStyle:(int)arg1 orientation:(int)arg2 inSceneWithReferenceSize:(CGSize)arg3;
+ (CGRect)_frameInSceneReferenceSpaceForStyleAttributes:(id)arg1 orientation:(int)arg2;
+ (CGRect)_frameInSceneReferenceSpaceForStyleAttributes:(id)arg1 orientation:(int)arg2 inSceneWithReferenceSize:(CGSize)arg3;
+ (BOOL)_isLightContentStyle:(int)arg1;
+ (id)_newStyleAttributesForRequest:(id)arg1;
+ (id)_styleAttributesForRequest:(id)arg1;
+ (id)_styleAttributesForStatusBarStyle:(int)arg1 legacy:(BOOL)arg2;
+ (int)cornerStyleForRequestedStyle:(int)arg1 effectiveStyle:(int)arg2 alignment:(int)arg3;
+ (id)defaultBlueTintColor;
+ (int)defaultStatusBarStyleWithTint:(BOOL)arg1;
+ (int)defaultStyleForRequestedStyle:(int)arg1 styleOverrides:(int)arg2;
+ (int)deviceUserInterfaceLayoutDirection;
+ (void)enumerateStatusBarStyleOverridesWithBlock:(id /* block */)arg1;
+ (void) getData:(UIStatusBarData *)data forRequestedData:(const UIStatusBarData *)requestedData withOverrides:(const UIStatusBarOverrideData *)overrideData;
+ (float)heightForStyle:(int)arg1 orientation:(int)arg2;
+ (int)lowBatteryLevel;
+ (id)navBarTintColorFromStatusBarTintColor:(id)arg1;
+ (void)setSuppressUpdateAnimations:(BOOL)arg1;
+ (void)setTintOverrideEnabled:(BOOL)arg1 withColor:(id)arg2;
+ (id)statusBarTintColorForNavBarTintColor:(id)arg1;

- (void)_adjustDoubleHeightTextVisibility;
- (CGRect)_backgroundFrameForAttributes:(id)arg1;
- (id)_backgroundView;
- (void)_beginDisablingRasterizationForReason:(id)arg1;
- (void)_clearOverrideHeight;
- (void)_crossfadeToNewBackgroundView;
- (void)_crossfadeToNewForegroundViewWithAlpha:(float)arg1;
- (id)_currentComposedData;
- (id)_currentComposedDataForStyle:(id)arg1;
- (id)_currentStyleAttributes;
- (void)_didChangeFromIdiom:(int)arg1 onScreen:(id)arg2 traverseHierarchy:(BOOL)arg3;
- (void)_didEnterBackground:(id)arg1;
- (id)_doubleHeightStatusStringForStyle:(int)arg1;
- (void)_endDisablingRasterizationForReason:(id)arg1;
- (void)_evaluateServerRegistration;
- (void)_finishedSettingStyleWithOldHeight:(float)arg1 newHeight:(float)arg2 animation:(int)arg3;
- (float)_hiddenAlphaForHideAnimationParameters:(id)arg1;
- (CGAffineTransform)_hiddenTransformForHideAnimationParameters:(id)arg1;
- (BOOL)_isTransparent;
- (void)_itemViewPerformButtonAction:(id)arg1;
- (void)_itemViewShouldBeginDisablingRasterization:(id)arg1;
- (void)_itemViewShouldEndDisablingRasterization:(id)arg1;
- (void)_performBlockWhileIgnoringForegroundViewChanges:(id /* block */)arg1;
- (id)_prepareInterruptedAnimationCompositeViewIncludingForeground:(BOOL)arg1;
- (id)_prepareToSetStyle:(id)arg1 animation:(int)arg2 forced:(BOOL)arg3;
- (void)_requestStyleAttributes:(id)arg1 animationParameters:(id)arg2;
- (void)_requestStyleAttributes:(id)arg1 animationParameters:(id)arg2 forced:(BOOL)arg3;
- (int)_requestedStyle;
- (void)_setDoubleHeightStatusString:(id)arg1;
- (void)_setFrameForStyle:(id)arg1;
- (void)_setOverrideHeight:(float)arg1;
- (void)_setStyle:(id)arg1;
- (void)_setStyle:(id)arg1 animation:(int)arg2;
- (void)_setVisualAltitude:(float)arg1;
- (void)_setVisualAltitudeBias:(CGSize)arg1;
- (BOOL)_shouldReverseLayoutDirection;
- (BOOL)_shouldSeekHigherPriorityTouchTarget;
- (BOOL)_shouldUseInProcessProviderDoubleHeightStatusString;
- (CGAffineTransform)_slideTransform;
- (float)_standardHeight;
- (void)_statusBarDidAnimateRotation;
- (void)_statusBarWillAnimateRotation;
- (id)_styleAttributesForRequest:(id)arg1;
- (void)_styleOverridesDidChange:(id)arg1;
- (void)_swapToNewBackgroundView;
- (void)_swapToNewForegroundView;
- (BOOL)_touchShouldProduceReturnEvent;
- (void)_updateBackgroundFrame;
- (void)_updatePersistentAnimationsEnabledForForegroundView:(id)arg1;
- (void)_updateShouldRasterize;
- (void)_willEnterForeground:(id)arg1;
- (id)activeTintColor;
- (void)crossfadeTime:(BOOL)arg1 duration:(double)arg2;
- (id)currentDoubleHeightLabelText;
- (CGRect)currentFrame;
- (float)currentHeight;
- (int)currentStyle;
- (id)currentStyleRequestForStyle:(int)arg1;
- (void)dealloc;
- (float)defaultDoubleHeight;
- (float)defaultHeight;
- (void)didMoveToSuperview;
- (void)forceUpdateData:(BOOL)arg1;
- (void)forceUpdateDoubleHeightStatus;
- (void)forceUpdateGlowAnimation;
- (void)forceUpdateStyleOverrides:(BOOL)arg1;
- (void) forceUpdateToData:(const UIStatusBarData *)arg1 animated:(BOOL)arg2;
- (id)foregroundColor;
- (void)forgetEitherSideHistory;
- (CGRect)frameForOrientation:(int)arg1;
- (float)heightForOrientation:(int)arg1;
- (BOOL)homeItemsDisabled;
- (id)initWithFrame:(CGRect)arg1;
- (id)initWithFrame:(CGRect)arg1 showForegroundView:(BOOL)arg2;
- (id)initWithFrame:(CGRect)arg1 showForegroundView:(BOOL)arg2 inProcessStateProvider:(id)arg3;
- (BOOL)isDoubleHeight;
- (BOOL)isHidden;
- (BOOL)isTranslucent;
- (void)layoutSubviews;
- (int)legibilityStyle;
- (void)noteStyleOverridesChangedLocally;
- (BOOL)persistentAnimationsEnabled;
- (BOOL)pointInside:(CGPoint)arg1 withEvent:(id)arg2;
- (void)requestStyle:(int)arg1;
- (void)requestStyle:(int)arg1 animated:(BOOL)arg2;
- (void)requestStyle:(int)arg1 animated:(BOOL)arg2 forced:(BOOL)arg3;
- (void)requestStyle:(int)arg1 animation:(int)arg2 startTime:(double)arg3 duration:(double)arg4 curve:(int)arg5;
- (void)requestStyle:(int)arg1 animationParameters:(id)arg2;
- (void)requestStyle:(int)arg1 animationParameters:(id)arg2 forced:(BOOL)arg3;
- (BOOL)serverUpdatesDisabled;
- (void)setBackgroundAlpha:(float)arg1;
- (void)setForegroundColor:(id)arg1 animationParameters:(id)arg2;
- (void)setHidden:(BOOL)arg1;
- (void)setHidden:(BOOL)arg1 animated:(BOOL)arg2;
- (void)setHidden:(BOOL)arg1 animationParameters:(id)arg2;
- (void)setHomeItemsDisabled:(BOOL)arg1;
- (void)setLegibilityStyle:(int)arg1;
- (void)setLegibilityStyle:(int)arg1 animationParameters:(id)arg2;
- (void)setLocalDataOverrides:(UIStatusBarOverrideData *)arg1;
- (void)setOrientation:(int)arg1;
- (void)setPersistentAnimationsEnabled:(BOOL)arg1;
- (void)setServerUpdatesDisabled:(BOOL)arg1;
- (void)setShowsOnlyCenterItems:(BOOL)arg1;
- (void)setSimulatesLegacyAppearance:(BOOL)arg1;
- (void)setStyleRequest:(id)arg1 animationParameters:(id)arg2;
- (void)setSuppressesGlow:(BOOL)arg1;
- (void)setSuppressesHiddenSideEffects:(BOOL)arg1;
- (void)setTintColor:(id)arg1;
- (void)setTintColor:(id)arg1 withDuration:(double)arg2;
- (BOOL)showsContentsOnScreen;
- (BOOL)simulatesLegacyAppearance;
- (void)statusBarServer:(id)arg1 didReceiveDoubleHeightStatusString:(id)arg2 forStyle:(int)arg3;
- (void)statusBarServer:(id)arg1 didReceiveGlowAnimationState:(BOOL)arg2 forStyle:(int)arg3;
- (void)statusBarServer:(id)arg1 didReceiveStatusBarData:(const UIStatusBarData *)arg2 withActions:(int)arg3;
- (void)statusBarServer:(id)arg1 didReceiveStyleOverrides:(int)arg2;
- (void)statusBarStateProvider:(id)arg1 didChangeDoubleHeightStatusStringForStyle:(int)arg2;
- (void)statusBarStateProvider:(id)arg1 didPostStatusBarData:(const UIStatusBarData *)arg2 withActions:(int)arg3;
- (int)styleForRequestedStyle:(int)arg1;
- (int)styleOverrides;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;

@end

@interface UIStatusBarServer : NSObject {
    struct __CFRunLoopSource { } *_source;
    id<UIStatusBarServerClient> _statusBar;
}

@property (nonatomic, retain) id<UIStatusBarServerClient> statusBar;

+ (unsigned int) _publisherPort;
+ (unsigned int) _serverPort;
+ (void)addStatusBarItem:(int)arg1;
+ (void)addStyleOverrides:(int)arg1;
+ (id)getDoubleHeightStatusStringForStyle:(int)arg1;
+ (double)getGlowAnimationEndTimeForStyle:(int)arg1;
+ (BOOL)getGlowAnimationStateForStyle:(int)arg1;
+ (const UIStatusBarData *)getStatusBarData;
+ (UIStatusBarOverrideData *)getStatusBarOverrideData;
+ (int)getStyleOverrides;
+ (void)permanentizeStatusBarOverrideData;
+ (void)postDoubleHeightStatusString:(id)arg1 forStyle:(int)arg2;
+ (void)postGlowAnimationState:(BOOL)arg1 forStyle:(int)arg2;
+ (void)postStatusBarData:(const UIStatusBarData *)arg1 withActions:(int)arg2;
+ (void)postStatusBarOverrideData:(UIStatusBarOverrideData *)arg1;
+ (void)removeStatusBarItem:(int)arg1;
+ (void)removeStyleOverrides:(int)arg1;
+ (void)runServer;

- (void) _receivedDoubleHeightStatus:(const char *)arg1 forStyle:(int)arg2;
- (void) _receivedGlowAnimationState:(BOOL)arg1 forStyle:(int)arg2;
- (void) _receivedStatusBarData:(UIStatusBarData *)arg1 actions:(int)arg2;
- (void) _receivedStyleOverrides:(int)arg1;

- (instancetype) initWithStatusBar:(id<UIStatusBarServerClient>)statusBar;
- (void) setStatusBar:(id<UIStatusBarServerClient>)statusBar;
- (id<UIStatusBarServerClient>) statusBar;

@end

@interface UIApplication (StatusBar)

- (void) setStatusBar:(UIStatusBar *) newStatusBar;
- (UIStatusBar *) statusBar;

@end

#pragma clang diagnostic pop
