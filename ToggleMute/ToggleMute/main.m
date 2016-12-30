#import <AVFoundation/AVAudioSession.h>
#import <stdio.h>

extern NSString *AVAudioSessionCategoryAudioVideo;
extern NSString *AVAudioSessionCategoryLiveAudio;
extern NSString *AVAudioSessionCategoryUserInterfaceSoundEffects;

extern NSString *AVAudioSessionMediaPlayerOnlyCategoryPhoneCall;
extern NSString *AVAudioSessionMediaPlayerOnlyCategoryRingtone;
extern NSString *AVAudioSessionMediaPlayerOnlyCategoryRingtonePreview;
extern NSString *AVAudioSessionMediaPlayerOnlyCategoryTTYCall;

@interface AVSystemController : NSObject

+ (instancetype) sharedAVSystemController;

- (BOOL) allowUserToExceedEUVolumeLimit;

- (BOOL) changeActiveCategoryVolumeBy:(float)arg1;
- (BOOL) changeActiveCategoryVolumeBy:(float)arg1 fallbackCategory:(NSString *)arg2 resultVolume:(float *)arg3 affectedCategory:(id*)arg4;
- (BOOL) changeActiveCategoryVolumeBy:(float)arg1 forRoute:(id)arg2 andDeviceIdentifier:(id)arg3;

- (BOOL) changeVolumeBy:(float)arg1 forCategory:(NSString *)arg2;
- (BOOL) changeVolumeForAccessoryBy:(float)arg1 forCategory:(NSString *)arg2 accessoryRoute:(id)arg3 andAccessoryDeviceIdentifier:(id)arg4;
- (BOOL) currentRouteHasVolumeControl;

- (BOOL) getActiveCategoryMuted:(BOOL *)arg1;
- (BOOL) getActiveCategoryMuted:(BOOL *)arg1 forRoute:(id)arg2 andDeviceIdentifier:(id)arg3;
- (BOOL) getActiveCategoryVolume:(float *)arg1 andName:(id *)arg2;
- (BOOL) getActiveCategoryVolume:(float *)arg1 andName:(id *)arg2 fallbackCategory:(id)arg3;
- (BOOL) getActiveCategoryVolume:(float *)arg1 andName:(id *)arg2 forRoute:(id)arg3 andDeviceIdentifier:(id)arg4;

- (BOOL) getVolume:(float *)arg1 forCategory:(NSString *)arg2;
- (BOOL) getVolumeForAccessory:(float *)arg1 forCategory:(id)arg2 accessoryRoute:(id)arg3 andAccessoryDeviceIdentifier:(id)arg4;

- (NSArray *) pickableRoutesForCategory:(NSString *)arg1;
- (NSArray *) pickableRoutesForCategory:(NSString *)arg1 andMode:(id)arg2;

- (void) postEffectiveVolumeNotification:(void *)arg1;
- (void) postFullMuteDidChangeNotification:(void *)arg1;

- (NSString *) routeForCategory:(NSString *)arg1;

- (BOOL) setActiveCategoryVolumeTo:(float)arg1;
- (BOOL) setActiveCategoryVolumeTo:(float)arg1 fallbackCategory:(id)arg2 resultVolume:(float*)arg3 affectedCategory:(id*)arg4;
- (BOOL) setActiveCategoryVolumeTo:(float)arg1 forRoute:(id)arg2 andDeviceIdentifier:(id)arg3;

- (BOOL) setBTHFPRoute:(id)arg1 availableForVoicePrompts:(BOOL)arg2;
- (BOOL) setPickedRouteWithPassword:(id)arg1 withPassword:(id)arg2;
- (BOOL) setVibeIntensityTo:(float)arg1;
- (BOOL) setVolumeForAccessoryTo:(float)arg1 forCategory:(id)arg2 accessoryRoute:(id)arg3 andAccessoryDeviceIdentifier:(id)arg4;
- (BOOL) setVolumeTo:(float)arg1 forCategory:(id)arg2;
- (BOOL) toggleActiveCategoryMuted;
- (BOOL) toggleActiveCategoryMutedForRoute:(id)arg1 andDeviceIdentifier:(id)arg2;

- (NSString *) volumeCategoryForAudioCategory:(NSString *)arg1;

@end

void TMSetRingerLevel(float level)
{
    [[AVSystemController sharedAVSystemController] setVolumeTo:level forCategory:AVAudioSessionMediaPlayerOnlyCategoryRingtone];
}

static void docat(NSString *category)
{
    AVSystemController *avsc = [AVSystemController sharedAVSystemController];
    NSLog(@"%@", category);
    NSLog(@"%@", [avsc pickableRoutesForCategory:category]);
    
    float volume = -1;
    [avsc getVolume:&volume forCategory:category];
    NSLog(@"%f\n\n", volume);
}

int main(void)
{
#if 0
    docat(AVAudioSessionCategoryAudioVideo);
    docat(AVAudioSessionCategoryLiveAudio);
    docat(AVAudioSessionCategoryUserInterfaceSoundEffects);
    docat(AVAudioSessionMediaPlayerOnlyCategoryPhoneCall);
    docat(AVAudioSessionMediaPlayerOnlyCategoryRingtone);
    docat(AVAudioSessionMediaPlayerOnlyCategoryRingtonePreview);
    docat(AVAudioSessionMediaPlayerOnlyCategoryTTYCall);
#endif

    float volume = -1;
    [[AVSystemController sharedAVSystemController] getVolume:&volume forCategory:AVAudioSessionMediaPlayerOnlyCategoryRingtone];

    if (volume >= 0.5F) {
        TMSetRingerLevel(0.0F);
    } else {
        TMSetRingerLevel(1.0F);
    }

    return 0;
}
