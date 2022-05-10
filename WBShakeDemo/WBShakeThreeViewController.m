//
//  WBShakeThreeViewController.m
//  WBShakeDemo
//
//  Created by LeoTai on 2021/1/9.
//

#import "WBShakeThreeViewController.h"
#import "ZZRHapticFeedbackManager.h"
#import "PlayView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>
#import <CoreHaptics/CoreHaptics.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

API_AVAILABLE(ios(13.0))
API_AVAILABLE(ios(13.0))
@interface WBShakeThreeViewController ()<PlayViewDelegate>

@property (nonatomic ,strong) UILabel               *UINotificationFeedbackGeneratorLabel;
@property (nonatomic ,strong) UILabel               *UIImpactFeedbackGeneratorLabel;
@property (nonatomic ,strong) UILabel               *UISelectionFeedbackGeneratorLabel;

@property (nonatomic ,strong) UIButton              *successBtn;
@property (nonatomic ,strong) UIButton              *warningBtn;
@property (nonatomic ,strong) UIButton              *errorBtn;


@property (nonatomic ,strong) UIButton              *longsuccessBtn;

@property (nonatomic ,strong) UIButton              *longwarningBtn;
@property (nonatomic ,strong) UIButton              *strongwarningBtn;

@property (nonatomic ,strong) UIButton              *lightBtn;
@property (nonatomic ,strong) UIButton              *mediumBtn;
@property (nonatomic ,strong) UIButton              *heavyBtn;

@property (nonatomic ,strong) UIButton              *selectionBtn;

@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) PlayView *playView;
@property (nonatomic, strong) CHHapticEngine *engine;
@property (nonatomic, strong) CHHapticEngine *engineTest;


@property (nonatomic, strong) UITextField *timeLable;
@property (nonatomic, strong) UITextField *shakeLable;
@property (nonatomic, strong) UITextField *boduLable;

@property (nonatomic, strong) UILabel *engineTime;
@property (nonatomic, strong) UILabel *engineShake;
@property (nonatomic, strong) UILabel *engineBodu;

@property (nonatomic, assign) NSString *timeText;
@property (nonatomic, assign) NSString *shakeText;
@property (nonatomic, assign) NSString *pinlvText;


@property (nonatomic, strong) UITextField *timeShortLable;
@property (nonatomic, strong) UITextField *shakeShortLable;
@property (nonatomic, strong) UITextField *boduShortLable;

@property (nonatomic, strong) UILabel *engineShortTime;
@property (nonatomic, strong) UILabel *engineShortShake;
@property (nonatomic, strong) UILabel *engineShortBodu;

@property (nonatomic, assign) NSString *timeShortText;
@property (nonatomic, assign) NSString *shakeShortText;
@property (nonatomic, assign) NSString *pinlvShortText;
@end

@implementation WBShakeThreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.UINotificationFeedbackGeneratorLabel = [[UILabel alloc] init];
    self.UINotificationFeedbackGeneratorLabel.frame = CGRectMake(0, 20 + 64, WIDTH, 30);
    self.UINotificationFeedbackGeneratorLabel.text = @"UIImpactFeedbackGenerator";
    self.UINotificationFeedbackGeneratorLabel.textAlignment = NSTextAlignmentCenter;
    self.UINotificationFeedbackGeneratorLabel.textColor = COLOR(50, 50, 50, 1);
    self.UINotificationFeedbackGeneratorLabel.font = [UIFont systemFontOfSize:17];
    
    self.successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.successBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.successBtn.frame = CGRectMake(WIDTH/2-150, 80 + 64, 80, 80);
    self.successBtn.layer.borderWidth = 1;
    self.successBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.successBtn.layer.cornerRadius = 40;
    [self.successBtn setTitle:@"Soft" forState:UIControlStateNormal];
    [self.successBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.successBtn addTarget:self action:@selector(successBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.longsuccessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longsuccessBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.longsuccessBtn.frame = CGRectMake(WIDTH/2-150, 80 + 64 + 90 , 80, 80);
    self.longsuccessBtn.layer.borderWidth = 1;
    self.longsuccessBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longsuccessBtn.layer.cornerRadius = 40;
    [self.longsuccessBtn setTitle:@"engine" forState:UIControlStateNormal];
    [self.longsuccessBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longsuccessBtn addTarget:self action:@selector(longsuccessBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.testBtn.frame = CGRectMake(WIDTH/2-150, 500 , 80, 80);
    self.testBtn.layer.borderWidth = 1;
    self.testBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.testBtn.layer.cornerRadius = 40;
    [self.testBtn setTitle:@"Test" forState:UIControlStateNormal];
    [self.testBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.warningBtn.backgroundColor = COLOR(251, 157, 33, 1);
    self.warningBtn.frame = CGRectMake(WIDTH/2-40, 80 + 64, 80, 80);
    self.warningBtn.layer.borderWidth = 1;
    self.warningBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.warningBtn.layer.cornerRadius = 40;
    [self.warningBtn setTitle:@"Rigid" forState:UIControlStateNormal];
    [self.warningBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.warningBtn addTarget:self action:@selector(warningBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.longwarningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longwarningBtn.backgroundColor = COLOR(251, 157, 33, 1);
    self.longwarningBtn.frame = CGRectMake(WIDTH/2-40, 80 + 64 + 90, 80, 80);
    self.longwarningBtn.layer.borderWidth = 1;
    self.longwarningBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longwarningBtn.layer.cornerRadius = 40;
    [self.longwarningBtn setTitle:@"sengine" forState:UIControlStateNormal];
    [self.longwarningBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longwarningBtn addTarget:self action:@selector(longwarningBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.strongwarningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.strongwarningBtn.backgroundColor = COLOR(251, 157, 33, 1);
    self.strongwarningBtn.frame = CGRectMake(WIDTH/2-40, 80 + 64 + 90 + 90, 80, 80);
    self.strongwarningBtn.layer.borderWidth = 1;
    self.strongwarningBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.strongwarningBtn.layer.cornerRadius = 40;
    [self.strongwarningBtn setTitle:@"test" forState:UIControlStateNormal];
    [self.strongwarningBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.strongwarningBtn addTarget:self action:@selector(strongwarningBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    self.errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.errorBtn.backgroundColor = COLOR(255, 87, 79, 1);
    self.errorBtn.frame = CGRectMake(WIDTH/2+70, 80 + 64, 80, 80);
    self.errorBtn.layer.borderWidth = 1;
    self.errorBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.errorBtn.layer.cornerRadius = 40;
    [self.errorBtn setTitle:@"error" forState:UIControlStateNormal];
    [self.errorBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.errorBtn addTarget:self action:@selector(errorBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    self.UIImpactFeedbackGeneratorLabel = [[UILabel alloc] init];
    self.UIImpactFeedbackGeneratorLabel.frame = CGRectMake(0, HEIGHT/3 + 20, WIDTH, 30);
    self.UIImpactFeedbackGeneratorLabel.text = @"UIImpactFeedbackGeneratorLabel";
    self.UIImpactFeedbackGeneratorLabel.textAlignment = NSTextAlignmentCenter;
    self.UIImpactFeedbackGeneratorLabel.textColor = COLOR(50, 50, 50, 1);
    self.UIImpactFeedbackGeneratorLabel.font = [UIFont systemFontOfSize:17];
    
    self.lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lightBtn.backgroundColor = COLOR(200, 200, 200, 1);
    self.lightBtn.frame = CGRectMake(WIDTH/2-150, HEIGHT/3 + 80 + 64, 80, 80);
    self.lightBtn.layer.borderWidth = 1;
    self.lightBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.lightBtn.layer.cornerRadius = 40;
    [self.lightBtn setTitle:@"light" forState:UIControlStateNormal];
    [self.lightBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.lightBtn addTarget:self action:@selector(lightBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    self.mediumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mediumBtn.backgroundColor = COLOR(150, 150, 150, 1);
    self.mediumBtn.frame = CGRectMake(WIDTH/2-40, HEIGHT/3 + 80 + 64, 80, 80);
    self.mediumBtn.layer.borderWidth = 1;
    self.mediumBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.mediumBtn.layer.cornerRadius = 40;
    [self.mediumBtn setTitle:@"medium" forState:UIControlStateNormal];
    [self.mediumBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.mediumBtn addTarget:self action:@selector(mediumBtnClicked) forControlEvents:UIControlEventTouchUpInside];


    self.heavyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heavyBtn.backgroundColor = COLOR(100, 100, 100, 1);
    self.heavyBtn.frame = CGRectMake(WIDTH/2 + 70, HEIGHT/3 + 80 + 64, 80, 80);
    self.heavyBtn.layer.borderWidth = 1;
    self.heavyBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.heavyBtn.layer.cornerRadius = 40;
    [self.heavyBtn setTitle:@"heavy" forState:UIControlStateNormal];
    [self.heavyBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.heavyBtn addTarget:self action:@selector(heavyBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    self.UISelectionFeedbackGeneratorLabel = [[UILabel alloc] init];
    self.UISelectionFeedbackGeneratorLabel.frame = CGRectMake(0, HEIGHT*2/3 + 20 + 64, WIDTH, 30);
    self.UISelectionFeedbackGeneratorLabel.text = @"UISelectionFeedbackGenerator";
    self.UISelectionFeedbackGeneratorLabel.textAlignment = NSTextAlignmentCenter;
    self.UISelectionFeedbackGeneratorLabel.textColor = COLOR(50, 50, 50, 1);
    self.UISelectionFeedbackGeneratorLabel.font = [UIFont systemFontOfSize:17];

    self.selectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectionBtn.backgroundColor = COLOR(150, 150, 150, 1);
    self.selectionBtn.frame = CGRectMake(WIDTH/2-40, HEIGHT*2/3 + 80 + 64, 80, 80);
    self.selectionBtn.layer.borderWidth = 1;
    self.selectionBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.selectionBtn.layer.cornerRadius = 40;
    [self.selectionBtn setTitle:@"selection" forState:UIControlStateNormal];
    [self.selectionBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.selectionBtn addTarget:self action:@selector(selectionBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self.view addSubview:self.UINotificationFeedbackGeneratorLabel];
    [self.view addSubview:self.successBtn];
    [self.view addSubview:self.warningBtn];
    [self.view addSubview:self.longwarningBtn];
    [self.view addSubview:self.strongwarningBtn];
    [self.view addSubview:self.longsuccessBtn];
//    [self.view addSubview:self.testBtn];
    
    [self.view addSubview:self.timeLable];
    [self.view addSubview:self.shakeLable];
    [self.view addSubview:self.boduLable];
    
    [self.view addSubview:self.engineTime];
    [self.view addSubview:self.engineShake];
    [self.view addSubview:self.engineBodu];
    
    [self.view addSubview:self.timeShortLable];
    [self.view addSubview:self.shakeShortLable];
    [self.view addSubview:self.boduShortLable];
    
    [self.view addSubview:self.engineShortTime];
    [self.view addSubview:self.engineShortShake];
    [self.view addSubview:self.engineShortBodu];
    
    
}


- (UITextField *)timeShortLable {
    if (!_timeShortLable) {
        _timeShortLable = [[UITextField alloc] initWithFrame:CGRectMake(10, 550, 100, 50)];
        _timeShortLable.font = [UIFont systemFontOfSize:12];
        _timeShortLable.borderStyle = UITextBorderStyleRoundedRect;
        _timeShortLable.text = @"1";
        self.timeShortText = _timeShortLable.text;
        _timeShortLable.delegate = self;
    }
    return _timeShortLable;
}

- (UILabel *)engineShortTime {
    if (!_engineShortTime) {
        _engineShortTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 150, 50)];
        _engineShortTime.text = @"单点延迟时长";
    }
    return _engineShortTime;
}


- (UITextField *)shakeShortLable {
    if (!_shakeShortLable) {
        _shakeShortLable = [[UITextField alloc] initWithFrame:CGRectMake(self.timeShortLable.frame.size.width+10+20, 550, 50, 50)];
        _shakeShortLable.font = [UIFont systemFontOfSize:12];
        _shakeShortLable.borderStyle = UITextBorderStyleRoundedRect;
        _shakeShortLable.text = @"1";
        self.shakeShortText = _shakeShortLable.text;
        _shakeShortLable.delegate = self;
    }
    return _shakeShortLable;
}

- (UILabel *)engineShortShake {
    if (!_engineShortShake) {
        _engineShortShake = [[UILabel alloc] initWithFrame:CGRectMake(self.timeShortLable.frame.size.width+10+20, 500, 100, 50)];
        _engineShortShake.text = @"单点强度";
    }
    return _engineShortShake;
}


- (UITextField *)boduShortLable {
    if (!_boduShortLable) {
        _boduShortLable = [[UITextField alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x+40, 550, 50, 50)];
        _boduShortLable.font = [UIFont systemFontOfSize:12];
        _boduShortLable.borderStyle = UITextBorderStyleRoundedRect;
        _boduShortLable.text = @"1";
        self.pinlvShortText = _boduShortLable.text;
        _boduShortLable.delegate = self;
    }
    return _boduShortLable;
}

- (UILabel *)engineShortBodu {
    if (!_engineShortBodu) {
        _engineShortBodu = [[UILabel alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x+20, 500, 100, 50)];
        _engineShortBodu.text = @"单点频率";
    }
    return _engineShortBodu;
}


- (UITextField *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UITextField alloc] initWithFrame:CGRectMake(10, 450, 100, 50)];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.borderStyle = UITextBorderStyleRoundedRect;
        _timeLable.text = @"1";
        self.timeText = _timeLable.text;
        _timeLable.delegate = self;
    }
    return _timeLable;
}

- (UILabel *)engineTime {
    if (!_engineTime) {
        _engineTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 100, 50)];
        _engineTime.text = @"长震时长";
    }
    return _engineTime;
}

- (UITextField *)shakeLable {
    if (!_shakeLable) {
        _shakeLable = [[UITextField alloc] initWithFrame:CGRectMake(self.timeLable.frame.size.width+10+20, 450, 50, 50)];
        _shakeLable.font = [UIFont systemFontOfSize:12];
        _shakeLable.borderStyle = UITextBorderStyleRoundedRect;
        _shakeLable.text = @"1";
        self.shakeText = _shakeLable.text;
        _shakeLable.delegate = self;
    }
    return _shakeLable;
}

- (UILabel *)engineShake {
    if (!_engineShake) {
        _engineShake = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLable.frame.size.width+10+20, 400, 50, 50)];
        _engineShake.text = @"强度";
    }
    return _engineShake;
}
- (UITextField *)boduLable {
    if (!_boduLable) {
        _boduLable = [[UITextField alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x, 450, 50, 50)];
        _boduLable.font = [UIFont systemFontOfSize:12];
        _boduLable.borderStyle = UITextBorderStyleRoundedRect;
        _boduLable.text = @"1";
        self.pinlvText = _boduLable.text;
        _boduLable.delegate = self;
    }
    return _boduLable;
}

- (UILabel *)engineBodu {
    if (!_engineBodu) {
        _engineBodu = [[UILabel alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x, 400, 50, 50)];
        _engineBodu.text = @"频率";
    }
    return _engineBodu;
}
# pragma mark UITextViewDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.timeText = _timeLable.text;
    self.shakeText = _shakeLable.text;
    self.pinlvText = _boduLable.text;
    
    
    self.timeShortText = _timeShortLable.text;
    self.shakeShortText = _shakeShortLable.text;
    self.pinlvShortText = _boduShortLable.text;
    
    NSLog(@"_timeLable text %@ _shakeLable text %@ _boduLable text %@ _timeShortLablec text %@ _shakeShortLable text %@ _boduShortLable text %@",self.timeText, self.shakeText, self.pinlvText, self.timeShortText , self.shakeShortText, self.pinlvShortText);
    [self.view endEditing:YES];
}

#pragma mark - events

- (void)successBtnClicked
{
    [ZZRHapticFeedbackManager excuteSoftFeedback];
}

- (void)longsuccessBtnClicked {
    [self addFeedback:@"1"];
}

- (void)warningBtnClicked
{
    [ZZRHapticFeedbackManager excuteRigidFeedback];
}

- (void)longwarningBtnClicked {
    [self addFeedback:@"2"];
}

- (void)readFileShake {
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engineTest = [[CHHapticEngine alloc] initAndReturnError:&error];
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"newInflate" ofType:@"ahap"];
        NSURL *url = [[NSURL alloc]initFileURLWithPath:musicFilePath];
       
        if ([self.engineTest playPatternFromURL:url error:&error]) {
            [self.engineTest startAndReturnError:&error];
        }
    } else {
        // Fallback on earlier versions
    }
   
}

/// 添加振动
- (void)addFeedback:(NSString *)type {
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
//        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"006" ofType:@"mp3"];
//        NSURL *url = [[NSURL alloc]initFileURLWithPath:musicFilePath];
        
        //    DataModel *model = [DataModel shareInstance];

            CHHapticEvent *event;
            if ([type isEqualToString:@"1"]) {
                /// 强度
                CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:[self.shakeText floatValue]];
                /// 频率
                CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:[self.pinlvText floatValue]];
                
//                CHHapticAudioResourceID resourceId = [self.engine registerAudioResource:url options:nil error:nil];
                
//                event = [[CHHapticEvent alloc] initWithAudioResourceID:resourceId parameters:@[parameter1, parameter2] relativeTime:0.5];
                
                
//                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient parameters:@[parameter1, parameter2] relativeTime:0];
                
                
                
                 // 任意长度
                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[parameter1, parameter2] relativeTime:0 duration:[self.timeText floatValue]];
            }else {
                /// 强度
                CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:[self.shakeShortText floatValue]];
                /// 频率
                CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:[self.pinlvShortText floatValue]];
                // 短暂
                event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient parameters:@[parameter1, parameter2] relativeTime:0];
                
                [self  performSelector:@selector(longShake) withObject:nil afterDelay:[self.timeShortText floatValue]];
            
            }
//        CHHapticParameterCurveControlPoint *point1 = [[CHHapticParameterCurveControlPoint alloc] initWithRelativeTime:0 value:1];
//        CHHapticParameterCurveControlPoint *point2 = [[CHHapticParameterCurveControlPoint alloc] initWithRelativeTime:0.5 value:0.5];
//        CHHapticParameterCurveControlPoint *point3 = [[CHHapticParameterCurveControlPoint alloc] initWithRelativeTime:1.5 value:1];
//        CHHapticParameterCurveControlPoint *point4 = [[CHHapticParameterCurveControlPoint alloc] initWithRelativeTime:2 value:0.5];
//        NSArray *array = @[point1,point2,point3,point4];
//        CHHapticParameterCurve *curve = [[CHHapticParameterCurve alloc] initWithParameterID:CHHapticDynamicParameterIDHapticIntensityControl controlPoints:array relativeTime:0];
//
        CHHapticPattern *patten = [[CHHapticPattern alloc] initWithEvents:@[event] parameterCurves:@[] error:&error];
        
        id player = [self.engine createPlayerWithPattern:patten error:&error];
        
        
        [self.engine startAndReturnError:&error];
        
        [player startAtTime:0 error:&error];
    } else {
        // Fallback on earlier versions
    }

}



/// 添加振动
- (void)longShake {
    NSError *error = nil;
    if (@available(iOS 13.0, *)) {
        self.engine = [[CHHapticEngine alloc] initAndReturnError:&error];
        //    DataModel *model = [DataModel shareInstance];
        
        CHHapticEvent *event;
        
        /// 强度
        CHHapticEventParameter *parameter1 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:[self.shakeText floatValue]];
        /// 频率
        CHHapticEventParameter *parameter2 = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness value:[self.pinlvText floatValue]];
        
        // 任意长度
        event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[parameter1, parameter2] relativeTime:0 duration:[self.timeText floatValue]];
        
        CHHapticPattern *patten = [[CHHapticPattern alloc] initWithEvents:@[event] parameterCurves:@[] error:&error];
        
        id player = [self.engine createPlayerWithPattern:patten error:&error];
        
        [self.engine startAndReturnError:&error];
        
        [player startAtTime:0 error:&error];
    } else {
        // Fallback on earlier versions
    }

}
- (void)strongwarningBtnClicked {
    [self readFileShake];
    
}


- (void)excutestrongRigidFeedback {
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleRigid];
        [generator prepare];
        [generator impactOccurredWithIntensity:0.5];
    }
}

- (void)excutestrongSoftFeedback {
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleSoft];
        [generator prepare];
        [generator impactOccurredWithIntensity:0.1];
    }
}

- (void)errorBtnClicked
{
    [ZZRHapticFeedbackManager excuteErrorFeedback];
}

- (void)lightBtnClicked
{
    [ZZRHapticFeedbackManager excuteLightFeedback];
}

- (void)mediumBtnClicked
{
    [ZZRHapticFeedbackManager excuteMediumFeedback];
}

- (void)heavyBtnClicked
{
    [ZZRHapticFeedbackManager excuteHeavyFeedback];
}

- (void)selectionBtnClicked
{
    [ZZRHapticFeedbackManager excuteSelectionFeedback];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)testBtnClicked {
    for (int i=0;i<20;i++) {
        if (i<1) {
            [ZZRHapticFeedbackManager excuteHeavyFeedback];
        }
        [ZZRHapticFeedbackManager excuteSoftFeedback];
    }
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//
//    // 可以自己设定震动间隔与时常（毫秒）
//    // 是否生效, 时长, 是否生效, 时长……
//    NSArray *pattern = @[@YES, @30, @NO, @1];
//
//    dictionary[@"VibePattern"] = pattern; // 模式
//    dictionary[@"Intensity"] = @.9; // 强度（测试范围是0.3～1.0）
//
////    AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dictionary);
    
    
}


@end
