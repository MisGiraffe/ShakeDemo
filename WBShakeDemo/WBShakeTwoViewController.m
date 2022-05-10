//
//  WBShakeTwoViewController.m
//  WBShakeDemo
//
//  Created by LeoTai on 2021/1/8.
//

#import "WBShakeTwoViewController.h"
#import "ZZRHapticFeedbackManager.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

@interface WBShakeTwoViewController ()

@property (nonatomic ,strong) UILabel               *UINotificationFeedbackGeneratorLabel;
@property (nonatomic ,strong) UILabel               *UIImpactFeedbackGeneratorLabel;
@property (nonatomic ,strong) UILabel               *UISelectionFeedbackGeneratorLabel;

@property (nonatomic ,strong) UIButton              *successBtn;
@property (nonatomic ,strong) UIButton              *warningBtn;
@property (nonatomic ,strong) UIButton              *errorBtn;

@property (nonatomic ,strong) UIButton *longsuccessBtn;
@property (nonatomic ,strong) UIButton *longwarningBtn;
@property (nonatomic ,strong) UIButton *longerrorBtn;


@property (nonatomic ,strong) UIButton              *lightBtn;
@property (nonatomic ,strong) UIButton              *mediumBtn;
@property (nonatomic ,strong) UIButton              *heavyBtn;

@property (nonatomic, strong) UIButton *longlightBtn;
@property (nonatomic, strong) UIButton *longmediumBtn;
@property (nonatomic, strong) UIButton *longheavyBtn;

@property (nonatomic ,strong) UIButton              *selectionBtn;

@end

@implementation WBShakeTwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.UINotificationFeedbackGeneratorLabel = [[UILabel alloc] init];
    self.UINotificationFeedbackGeneratorLabel.frame = CGRectMake(0, 20 + 64, WIDTH, 30);
    self.UINotificationFeedbackGeneratorLabel.text = @"UINotificationFeedbackGenerator";
    self.UINotificationFeedbackGeneratorLabel.textAlignment = NSTextAlignmentCenter;
    self.UINotificationFeedbackGeneratorLabel.textColor = COLOR(50, 50, 50, 1);
    self.UINotificationFeedbackGeneratorLabel.font = [UIFont systemFontOfSize:17];
    
    self.successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.successBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.successBtn.frame = CGRectMake(WIDTH/2-150, 80 + 64, 80, 80);
    self.successBtn.layer.borderWidth = 1;
    self.successBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.successBtn.layer.cornerRadius = 40;
    [self.successBtn setTitle:@"success" forState:UIControlStateNormal];
    [self.successBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.successBtn addTarget:self action:@selector(successBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.longsuccessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longsuccessBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.longsuccessBtn.frame = CGRectMake(WIDTH/2-150, 80 + 64 + 90, 80, 80);
    self.longsuccessBtn.layer.borderWidth = 1;
    self.longsuccessBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longsuccessBtn.layer.cornerRadius = 40;
    [self.longsuccessBtn setTitle:@"success" forState:UIControlStateNormal];
    [self.longsuccessBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longsuccessBtn addTarget:self action:@selector(longsuccessBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.warningBtn.backgroundColor = COLOR(251, 157, 33, 1);
    self.warningBtn.frame = CGRectMake(WIDTH/2-40, 80 + 64, 80, 80);
    self.warningBtn.layer.borderWidth = 1;
    self.warningBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.warningBtn.layer.cornerRadius = 40;
    [self.warningBtn setTitle:@"warning" forState:UIControlStateNormal];
    [self.warningBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.warningBtn addTarget:self action:@selector(warningBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.longwarningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longwarningBtn.backgroundColor = COLOR(251, 157 + 90, 33, 1);
    self.longwarningBtn.frame = CGRectMake(WIDTH/2-40, 80 + 64 + 90, 80, 80);
    self.longwarningBtn.layer.borderWidth = 1;
    self.longwarningBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longwarningBtn.layer.cornerRadius = 40;
    [self.longwarningBtn setTitle:@"warning" forState:UIControlStateNormal];
    [self.longwarningBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longwarningBtn addTarget:self action:@selector(longwarningBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    self.errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.errorBtn.backgroundColor = COLOR(255, 87, 79, 1);
    self.errorBtn.frame = CGRectMake(WIDTH/2+70, 80 + 64, 80, 80);
    self.errorBtn.layer.borderWidth = 1;
    self.errorBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.errorBtn.layer.cornerRadius = 40;
    [self.errorBtn setTitle:@"error" forState:UIControlStateNormal];
    [self.errorBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.errorBtn addTarget:self action:@selector(errorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.longerrorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longerrorBtn.backgroundColor = COLOR(255, 87, 79, 1);
    self.longerrorBtn.frame = CGRectMake(WIDTH/2+70, 80 + 64 + 90, 80, 80);
    self.longerrorBtn.layer.borderWidth = 1;
    self.longerrorBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longerrorBtn.layer.cornerRadius = 40;
    [self.longerrorBtn setTitle:@"error" forState:UIControlStateNormal];
    [self.longerrorBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longerrorBtn addTarget:self action:@selector(longerrorBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
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
    
    self.longlightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longlightBtn.backgroundColor = COLOR(200, 200, 200, 1);
    self.longlightBtn.frame = CGRectMake(WIDTH/2-150, HEIGHT/3 + 80 + 64 + 90, 80, 80);
    self.longlightBtn.layer.borderWidth = 1;
    self.longlightBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longlightBtn.layer.cornerRadius = 40;
    [self.longlightBtn setTitle:@"llight" forState:UIControlStateNormal];
    [self.longlightBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longlightBtn addTarget:self action:@selector(longlightBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    self.mediumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mediumBtn.backgroundColor = COLOR(150, 150, 150, 1);
    self.mediumBtn.frame = CGRectMake(WIDTH/2-40, HEIGHT/3 + 80 + 64, 80, 80);
    self.mediumBtn.layer.borderWidth = 1;
    self.mediumBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.mediumBtn.layer.cornerRadius = 40;
    [self.mediumBtn setTitle:@"medium" forState:UIControlStateNormal];
    [self.mediumBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.mediumBtn addTarget:self action:@selector(mediumBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    self.longmediumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longmediumBtn.backgroundColor = COLOR(150, 150, 150, 1);
    self.longmediumBtn.frame = CGRectMake(WIDTH/2-40, HEIGHT/3 + 80 + 64 +90, 80, 80);
    self.longmediumBtn.layer.borderWidth = 1;
    self.longmediumBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longmediumBtn.layer.cornerRadius = 40;
    [self.longmediumBtn setTitle:@"lmedium" forState:UIControlStateNormal];
    [self.longmediumBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longmediumBtn addTarget:self action:@selector(longmediumBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    self.heavyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heavyBtn.backgroundColor = COLOR(100, 100, 100, 1);
    self.heavyBtn.frame = CGRectMake(WIDTH/2 + 70, HEIGHT/3 + 80 + 64, 80, 80);
    self.heavyBtn.layer.borderWidth = 1;
    self.heavyBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.heavyBtn.layer.cornerRadius = 40;
    [self.heavyBtn setTitle:@"heavy" forState:UIControlStateNormal];
    [self.heavyBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.heavyBtn addTarget:self action:@selector(heavyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.longheavyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.longheavyBtn.backgroundColor = COLOR(100, 100, 100, 1);
    self.longheavyBtn.frame = CGRectMake(WIDTH/2 + 70, HEIGHT/3 + 80 + 64 + 90, 80, 80);
    self.longheavyBtn.layer.borderWidth = 1;
    self.longheavyBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.longheavyBtn.layer.cornerRadius = 40;
    [self.longheavyBtn setTitle:@"lheavy" forState:UIControlStateNormal];
    [self.longheavyBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.longheavyBtn addTarget:self action:@selector(longheavyBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
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
    [self.view addSubview:self.errorBtn];
    [self.view addSubview:self.UIImpactFeedbackGeneratorLabel];
    [self.view addSubview:self.lightBtn];
    [self.view addSubview:self.mediumBtn];
    [self.view addSubview:self.heavyBtn];
    [self.view addSubview:self.UISelectionFeedbackGeneratorLabel];
    [self.view addSubview:self.selectionBtn];
    [self.view addSubview:self.longlightBtn];
    [self.view addSubview:self.longmediumBtn];
    [self.view addSubview:self.longheavyBtn];
    [self.view addSubview:self.longsuccessBtn];
    [self.view addSubview:self.longwarningBtn];
    [self.view addSubview:self.longerrorBtn];
    
    
}

#pragma mark - events

- (void)successBtnClicked
{
    [ZZRHapticFeedbackManager executeSuccessFeedback];
}

- (void)longsuccessBtnClicked {
    for (int i=0;i<100;i++) {
        [ZZRHapticFeedbackManager executeSuccessFeedback];
    }
}

- (void)warningBtnClicked
{
    [ZZRHapticFeedbackManager executeWarningFeedback];
}

- (void)longwarningBtnClicked {
    for (int i=0;i<100;i++) {
        [ZZRHapticFeedbackManager executeWarningFeedback];
    }
}

- (void)errorBtnClicked
{
    [ZZRHapticFeedbackManager excuteErrorFeedback];
}

- (void)longerrorBtnClicked {
    for (int i=0;i<100;i++) {
        [ZZRHapticFeedbackManager excuteErrorFeedback];
    }
}

- (void)lightBtnClicked
{
    [ZZRHapticFeedbackManager excuteLightFeedback];
}

- (void)longlightBtnClicked {
    for (int i=0;i<10;i++) {
        [ZZRHapticFeedbackManager excuteLightFeedback];
    }
}

- (void)mediumBtnClicked
{
    [ZZRHapticFeedbackManager excuteMediumFeedback];
}

- (void)longmediumBtnClicked {
    for (int i=0;i<100;i++) {
        [ZZRHapticFeedbackManager excuteMediumFeedback];
    }
}

- (void)heavyBtnClicked
{
    [ZZRHapticFeedbackManager excuteHeavyFeedback];
}

- (void)longheavyBtnClicked {
    for (int i=0;i<100;i++) {
        [ZZRHapticFeedbackManager excuteHeavyFeedback];
    }
}

- (void)selectionBtnClicked
{
    [ZZRHapticFeedbackManager excuteSelectionFeedback];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
