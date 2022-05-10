//
//  PlayView.m
//  WBShakeDemo
//
//  Created by fangtingting on 2021/2/26.
//

#import "PlayView.h"
#import "ZZRHapticFeedbackManager.h"
#import <CoreHaptics/CoreHaptics.h>
 
@interface PlayView()
{
    UIView   *_bgView;
    //播放器
    AVPlayer *_player;
    //用于显示(控制)视频的播放进度
    UISlider *_progressSlider;
    
}



-(void)uiConfigWith:(CGRect)bframe;
@end
 
@implementation PlayView
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfigWith:frame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    }
    return self;
}
 
-(void)uiConfigWith:(CGRect)bframe
{
    self.backgroundColor=[UIColor blackColor];
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, bframe.size.height-50, bframe.size.width, 50)];
    _bgView.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:_bgView];
    
    //播放暂停按钮
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setFrame:CGRectMake(0,0,100,50)];
    playBtn.backgroundColor=[UIColor greenColor];
    playBtn.selected=YES;
    [playBtn setTitle:@"继续" forState:UIControlStateNormal];
    [playBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:playBtn];
    
    _progressSlider= [[UISlider alloc] initWithFrame:CGRectMake(100,0,bframe.size.width-100,50)];
    _progressSlider.minimumValue = 0.0;
    _progressSlider.maximumValue = 1.0;
    [_progressSlider addTarget:self action:@selector(progressChange:) forControlEvents:UIControlEventValueChanged];
    [_bgView addSubview:_progressSlider];
}
 
//每个视图都对应一个层，改变视图的形状、动画效果\与播放器的关联等，都可以在层上操作
//播放器支持的播放格式:mp4、mov(iPhone手机录制视频的默认格式) avi
-(void)setPlayer:(AVPlayer *)myPlayer
{
    AVPlayerLayer *playerLayer=(AVPlayerLayer *)self.layer;
    [playerLayer setPlayer:myPlayer];
}
//在调用视图的layer时，会自动触发layerClass方法，重写它，保证返回的类型是AVPlayerLayer
+(Class)layerClass
{
    return [AVPlayerLayer class];
}
-(void)playWith:(NSURL *)url data:(NSMutableArray *)data  pinlv:(NSMutableArray *)pinlv qiangdu:(NSMutableArray *)qiangdu chixu:(NSMutableArray *)chixu
{
//    self.data = data;
    self.timeData = data;
    self.pinlvData = pinlv;
    self.qiangduData = qiangdu;
    self.chuxuData = chixu;
    [self timerShark];
    //加载视频资源的类
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    //AVURLAsset 通过tracks关键字会将资源异步加载在程序的一个临时内存缓冲区中
    [asset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:@"tracks"] completionHandler:^{
        //能够得到资源被加载的状态
        AVKeyValueStatus status = [asset statusOfValueForKey:@"tracks" error:nil];
        //如果资源加载完成,开始进行播放
        if (status == AVKeyValueStatusLoaded) {
            //将加载好的资源放入AVPlayerItem 中，item中包含视频资源数据,视频资源时长、当前播放的时间点等信息
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
            _player = [[AVPlayer alloc] initWithPlayerItem:item];
            //将播放器与播放视图关联
            [self setPlayer:_player];
            [_player play];
            //需要时时显示播放的进度
            //根据播放的帧数、速率，进行时间的异步(在子线程中完成)获取
            [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_global_queue(0, 0) usingBlock:^(CMTime time) {
                //获取时间
                //获取当前播放时间(根据帧数和播放速率，视频资源的总长度得到的CMTime)
                CMTime current = _player.currentItem.currentTime;
                //总时间
                CMTime dur =_player.currentItem.duration;
                //CMTimeGetSeconds 将描述视频时间的结构体转化为float（秒）
                CGFloat pro = (CMTimeGetSeconds(current)/CMTimeGetSeconds(dur));
                NSString *timeStr=[NSString stringWithFormat:@"%.0f", CMTimeGetSeconds(current)];
                
                NSString *str = [NSString stringWithFormat:@"%.3f", CMTimeGetSeconds(current)];
                self.time = str;
                NSLog(@"时间%@",timeStr);

//                [self shark:timeStr data:data];

                //回到主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    //要考虑到代码的健壮性
                    /*1、在向对象发送消息前，要判断对象是否为空
                     *2、一些值(数组、控制中的属性值)是否越界的判断
                     *3、是否对各种异常情况进行了处理(照片、定位 用户允许、不允许)
                     *4、数据存储，对nil的判断或处理
                     *5、对硬件功能支持情况的判断等
                     */
                    if (pro >=0 && pro <=1) {
                        _progressSlider.value = pro;
                    }
                });

            }];
        }
    }];
 
}
#pragma mark -------BtnClick---------
-(void)playBtnClick:(UIButton *)btn
{
    if (btn.selected==YES) { //暂停按钮被点击
        
        if (_player) {
            [_player pause];
            [self.timer invalidate];
            if ([self.playerDelegate respondsToSelector:@selector(stopTimer)]) {
                [self.playerDelegate stopTimer];
            }
        }
        btn.selected=NO;
        
        return;
    }
    
    //播放按钮被点击
    if (_player) {
        [_player play];
        [self timerShark];
        if ([self.playerDelegate respondsToSelector:@selector(startTimer)]) {
            [self.playerDelegate startTimer];
        }
    }
    btn.selected=YES;
    return;
}
-(void)progressChange:(UISlider *)sl
{
    //通过进度条控制播放进度
    if (!_player) {
        return;
    }
    CMTime dur = _player.currentItem.duration;
    float current = _progressSlider.value;
    //CMTimeMultiplyByFloat64 将总时长，当前进度，转化成为CMTime
    //seekToTime 跳转到指定的时间
    [_player seekToTime:CMTimeMultiplyByFloat64(dur, current)];
}
 
//销毁player
-(void)releasePlayer
{
    if (_player) {
        [_player pause];
        _player=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for(int i=0;i<[_bgView.subviews count];i++)
    {
        UIView *view=[_bgView.subviews objectAtIndex:i];
        [view removeFromSuperview];
        view=nil;
        i--;
    }
    [_bgView removeFromSuperview];
    _bgView=nil;
}
 
#pragma mark ------Notification-------
-(void)moviePlayDidEnd:(NSNotification*)notification
{
    NSLog(@"视频播放完毕！");
}

- (void)shark:(NSString *)time data:(NSDictionary *)data{
    NSNumber *num =  [data objectForKey:time];
    NSLog(@"num:%@",num);
    
    
    if ([num.stringValue isEqualToString:@"1"]) {
        for (int i=0;i<50;i++) {
            [ZZRHapticFeedbackManager excuteSoftFeedback];
        }
        
        [self.timer invalidate];
    }
    else if ([num.stringValue isEqualToString:@"2"]) {
        for (int i=0;i<50;i++) {
            [ZZRHapticFeedbackManager excuteHeavyFeedback];
        }
        [self.timer invalidate];
    }
    else if ([num.stringValue isEqualToString:@"3"]) {
        for (int i=0;i<50;i++) {
            [ZZRHapticFeedbackManager excuteRigidFeedback];
        }

        
        
    }
}

- (void)timerShark {
    // 创建定时器
    self.sharkTime = 0;
    self.temp = 0;
    self.timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(test) userInfo:nil repeats:YES];
     // 将定时器添加到runloop中，否则定时器不会启动
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)test {
    if (self.timeData.count == 0) {
        return;
    }
    NSNumber *timeNum = self.timeData[self.temp];
    float timeFloat = timeNum.floatValue;
    CGFloat num = self.sharkTime - timeFloat;
    
    NSNumber *qiangduNum = self.qiangduData[self.temp];
    float qiangduFloat = qiangduNum.floatValue/50;
    if (qiangduFloat >=1) {
        qiangduFloat = 1;
    }
    NSLog(@"-----ftt == qiangduFloat：%lf  ",qiangduFloat);
    NSString *pinlvNum = self.pinlvData[self.temp];
//    float pinlvFloat = pinlvNum.floatValue/100;
    
    NSNumber *chixuNum = self.chuxuData[self.temp];
    float chixuFloat = chixuNum.floatValue/1000;

    if (num >= 0 && num <= 20 && self.temp < self.timeData.count) {
//        [ZZRHapticFeedbackManager excuteRigidFeedback];
//        [self addFeedback:@"1" pinlv:pinlvFloat qiangdu:qiangduFloat chixu:chixuFloat];
        [self readFileShake:pinlvNum];
        self.temp++;
        NSLog(@"-----打点num：%lf  sharkTime：%f  timeFloat：%f temp:%ld pinlv:%f",num, self.sharkTime, timeFloat, self.temp, qiangduFloat);
    }
    else {
        NSLog(@"没打点num：%lf  sharkTime：%f  timeFloat：%f temp:%ld",num, self.sharkTime, timeFloat, self.temp);
    }
    
    if (self.temp >= self.timeData.count) {
        [self.timer invalidate];
    }
    self.sharkTime = self.sharkTime + 10;
}


- (void)readFileShake:(NSString *)songType {
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engineTest = [[CHHapticEngine alloc] initAndReturnError:&error];
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:songType ofType:@"ahap"];
        NSURL *url = [[NSURL alloc]initFileURLWithPath:musicFilePath];
        NSLog(@"---ftt url%@",url);
        if ([self.engineTest playPatternFromURL:url error:&error]) {
            NSLog(@"---ftt success url%@ ",url);
            [self.engineTest startAndReturnError:&error];
        }
       
   
        
       
    } else {
        // Fallback on earlier versions
    }
   
}

/// 添加振动
- (void)addFeedback:(NSString *)type pinlv:(float)pinlv qiangdu:(float)qiangdu chixu:(float)chixu{
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        //    DataModel *model = [DataModel shareInstance];

            CHHapticEvent *event;
            if ([type isEqualToString:@"1"]) {
                /// 强度
                CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:qiangdu];
                /// 频率
                CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:pinlv];
                
                // 短暂
                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient parameters:@[parameter1, parameter2] relativeTime:0];
                
                self.pinlv = pinlv;
                self.qiangdu = qiangdu;
                self.chixu = chixu;
                
                [self  performSelector:@selector(longShake) withObject:nil afterDelay:0.1];
                 // 任意长度
                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[parameter1, parameter2] relativeTime:0 duration:chixu];
            }else {
                /// 强度
                CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:qiangdu];
                /// 频率
                CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:pinlv];
                // 短暂
                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient parameters:@[parameter1, parameter2] relativeTime:0];
            }
            CHHapticPattern *patten = [[CHHapticPattern alloc] initWithEvents:@[event] parameterCurves:@[] error:&error];

            id player = [self.engine createPlayerWithPattern:patten error:&error];

            [self.engine startAndReturnError:&error];

            [player startAtTime:0 error:&error];
    } else {
        // Fallback on earlier versions
    }

}

- (void)longShake {
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        //    DataModel *model = [DataModel shareInstance];
        
        CHHapticEvent *event;
        
        /// 强度
        CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:self.qiangdu];
        /// 频率
        CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:self.pinlv];
        
        // 任意长度
        event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[parameter1, parameter2] relativeTime:0 duration:self.chixu];
        
        CHHapticPattern *patten = [[CHHapticPattern alloc] initWithEvents:@[event] parameterCurves:@[] error:&error];
        
        id player = [self.engine createPlayerWithPattern:patten error:&error];
        
        [self.engine startAndReturnError:&error];
        
        [player startAtTime:0 error:&error];
    } else {
        // Fallback on earlier versions
    }

}
@end
