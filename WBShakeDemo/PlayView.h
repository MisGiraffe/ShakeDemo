//
//  PlayView.h
//  WBShakeDemo
//
//  Created by fangtingting on 2021/2/26.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreHaptics/CoreHaptics.h>
NS_ASSUME_NONNULL_BEGIN


/// 广告视频播放控制Delegate
@protocol PlayViewDelegate <NSObject>

- (void)stopTimer;
- (void)startTimer;

@end
 
@interface PlayView : UIView

@property (nonatomic, strong) CHHapticEngine *engine;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) double sharkTime;
@property (nonatomic, assign) NSInteger temp;
@property (nonatomic, strong) NSMutableArray* timeData;
@property (nonatomic, strong) NSMutableArray* pinlvData;
@property (nonatomic, strong) NSMutableArray* qiangduData;
@property (nonatomic, strong) NSMutableArray* chuxuData;

@property (nonatomic, assign) float pinlv;
@property (nonatomic, assign) float qiangdu;
@property (nonatomic, assign) float chixu;

@property (nonatomic, strong) CHHapticEngine *engineTest;

/// 代理
@property (weak, nonatomic) id<PlayViewDelegate> playerDelegate;

-(void)setPlayer:(AVPlayer *)myPlayer;
-(void)playWith:(NSURL *)url data:(NSMutableArray *)data  pinlv:(NSMutableArray *)pinlv qiangdu:(NSMutableArray *)qiangdu chixu:(NSMutableArray *)chixu;
-(void)releasePlayer;

@end

NS_ASSUME_NONNULL_END
