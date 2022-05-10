//
//  ZZRHapticFeedbackManager.m
//  HapticFeedbackDemo
//
//  Created by LeoTai on 2021/1/9.
//

#import "ZZRHapticFeedbackManager.h"
#import <AudioToolbox/AudioToolbox.h>
static NSString *kTimes = @"kTimes";

@implementation ZZRHapticFeedbackManager

#pragma mark -
#pragma mark - UINotificationFeedbackGenerator

+ (void)executeSuccessFeedback
{
    if (@available(iOS 10.0, *)) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
    }
}

+ (void)executeWarningFeedback
{
    if (@available(iOS 10.0, *)) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator notificationOccurred:UINotificationFeedbackTypeWarning];
    }
}

+ (void)excuteErrorFeedback
{
    if (@available(iOS 10.0, *)) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator notificationOccurred:UINotificationFeedbackTypeError];
    }
}

#pragma mark -
#pragma mark - UIImpactFeedbackGenerator

+ (void)excuteLightFeedback
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleLight];
        [generator prepare];
        [generator impactOccurred];
    }
}

+ (void)excuteMediumFeedback
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    }
}

+ (void)excuteHeavyFeedback
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }
    
    
}

+ (void)excuteSoftFeedback
{
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleSoft];
        [generator prepare];
        [generator impactOccurred];
    }
    
    
}

+ (void)excuteRigidFeedback
{
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleRigid];
        [generator prepare];
        [generator impactOccurred];
    }
    
    
}

#pragma mark -
#pragma mark - UISelectionFeedbackGenerator


+ (void)excuteSelectionFeedback
{
    if (@available(iOS 10.0, *)) {
        UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
        [generator selectionChanged];
    }
}

#pragma mark -
#pragma mark - AudioServicesPlaySystemSound

+ (void)wbAudioServicesPlaySystemSoundVibrate
{
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil);
    //未来即将弃用
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //4095
}

+ (void)wbAudioServicesPlaySystemSound1519
{
    AudioServicesPlaySystemSoundWithCompletion(1519, nil);
    //AudioServicesPlaySystemSound(1519);  // 'Peek' feedback (weak boom)
}

+ (void)wbAudioServicesPlaySystemSound1520
{
    AudioServicesPlaySystemSoundWithCompletion(1520, nil);
    //AudioServicesPlaySystemSound(1520);  // 'Pop' feedback (strong boom)
}

+ (void)wbAudioServicesPlaySystemSound1521
{
    AudioServicesPlaySystemSoundWithCompletion(1521, nil);
    //AudioServicesPlaySystemSound(1521);  // 'Cancelled' feedback (three sequential weak booms)
}

+ (void)wbAudioServicesPlaySystemSound1102
{
    AudioServicesPlaySystemSoundWithCompletion(1102, nil);
    //AudioServicesPlaySystemSound(1102);  // 'Try Again' feedback (week boom then strong boom)
}

+ (void)wbAudioServicesPlaySystemSound1011
{
    AudioServicesPlaySystemSoundWithCompletion(1011, nil);
    //AudioServicesPlaySystemSound(1011);  // 'Failed' feedback (three sequential strong booms)
}

+ (NSNumber *)getNowTimeTimestamp3{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSNumber *timeSp = [NSNumber numberWithLong:(long)([datenow timeIntervalSince1970]*1000)];

    return timeSp;
}

+ (void)writeJson {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"result.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *key = arr[@"key"];
    NSArray *value = arr[@"value"];
    
//    NSNumber *nowTime = [self getNowTimeTimestamp3];
//
//    [[NSUserDefaults standardUserDefaults] setObject:nowTime forKey:kTimes];
//
//    NSNumber *lastTime = [[NSUserDefaults standardUserDefaults] objectForKey:kTimes];
    
    NSNumber *finalTime = key[key.count - 1];
    int temp = 0;
    
    for (int i=0; i<finalTime.intValue; i++) {
//        NSNumber *currentTime = [self getNowTimeTimestamp3];
//        NSInteger time = currentTime.doubleValue - lastTime.doubleValue;
        
        NSNumber *keyvalue = key[temp];
        if (i == keyvalue.intValue) {
            
            NSNumber *valueNum = value[temp];
            if (valueNum.intValue == 0) {
                
            }
            else if (valueNum.intValue == 1) {
                [self wbAudioServicesPlaySystemSound1520];
            }
            else if (valueNum.intValue == 2) {
                [self excuteSoftFeedback];
            }
            temp++;
        }
        
    }
}



@end
