//
//  DYShakeCollectionViewCell.m
//  WBShakeDemo
//
//  Created by fangtingting on 2021/3/3.
//

#import "DYShakeCollectionViewCell.h"

@interface DYShakeCollectionViewCell () <UITextViewDelegate ,  UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UITextField *timeLable;
@property (nonatomic, strong) UITextField *shakeLable;
@property (nonatomic, strong) UITextField *boduLable;
@property (nonatomic, strong) UITextField *chixuTime;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIPickerView *pinlvPickerView;
@property(nonatomic,strong)NSArray *pinlvArray;
@property(nonatomic,copy)NSString *selectedPinLv;


@property (nonatomic, strong) UIPickerView *timePickerView;
@property(nonatomic,strong)NSArray *timeArray;
@property(nonatomic,copy)NSString *selectedTime;

@end

@implementation DYShakeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    
    self.timeArray = @[@"100",@"200",@"300",@"400",@"500",@"600",@"700",@"800",@"900",@"1000",@"1100",@"1200",@"1300",@"1400",@"1500",@"1600",@"1700",@"1800",@"1900",@"2000"];

    
    
    
    
//    self.pinlvArray = @[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100"];
    
    self.pinlvArray = @[@"Drums",@"Gravel",@"Heartbeats",@"Inflate",@"Oscillate",@"Rumble",@"Sparkle",@"Boing",@"newDrums",@"newGravel",@"newHeartbeats",@"newInflate",@"newOscillate",@"newRumble",@"newSparkle",];
    
    [self addSubview:self.timeLable];
    [self addSubview:self.shakeLable];
//    [self addSubview:self.boduLable];
//    [self addSubview:self.chixuTime];
    [self addSubview:self.deleteBtn];
    
    [self addSubview:self.pinlvPickerView];
//    [self addSubview:self.timePickerView];
//    [self.pickerVIew selectRow:2 inComponent:0 animated:NO];
    
}


//懒加载
- (UIPickerView *)timePickerView{
    if (_timePickerView== nil) {
        _timePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x+60, 0, 70, self.frame.size.height)];
        _timePickerView.layer.masksToBounds = YES;
        _timePickerView.layer.borderWidth = 1;
        _timePickerView.delegate = self;
        _timePickerView.dataSource = self;
    }
    
    return _timePickerView;
}


//懒加载
- (UIPickerView *)pinlvPickerView{
    if (_pinlvPickerView == nil) {
        _pinlvPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x, 0, 100, self.frame.size.height)];
        _pinlvPickerView.layer.masksToBounds = YES;
        _pinlvPickerView.layer.borderWidth = 1;
        _pinlvPickerView.delegate = self;
        _pinlvPickerView.dataSource = self;
    }
    
    return _pinlvPickerView;
}



#pragma mark ------- dateSource&&Delegate --------

//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView == self.pinlvPickerView) {
        return self.pinlvArray.count;
    }
    else if (pickerView == self.timePickerView) {
        return self.timeArray.count;
    }
    
    return 1;
}

//设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.pinlvPickerView) {
        return self.pinlvArray[row];
    }
    else if (pickerView == self.timePickerView) {
        return self.timeArray[row];
    }
    
    return @"加载失败";
}

//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.pinlvPickerView) {
        self.selectedPinLv = self.pinlvArray[row];
        self.updateTimeAndShake(_timeLable.text, _shakeLable.text, self.selectedPinLv, @"0");
    }
    else if (pickerView == self.timePickerView) {
        self.selectedTime = self.timeArray[row];
        self.updateTimeAndShake(_timeLable.text, _shakeLable.text, @"0", self.selectedTime);
    }
    
   
    
   
}

- (UITextField *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 100, self.frame.size.height)];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.borderStyle = UITextBorderStyleRoundedRect;
        _timeLable.delegate = self;
    }
    return _timeLable;
}

- (UITextField *)shakeLable {
    if (!_shakeLable) {
        _shakeLable = [[UITextField alloc] initWithFrame:CGRectMake(self.timeLable.frame.size.width+10+20, 0, 50, self.frame.size.height)];
        _shakeLable.font = [UIFont systemFontOfSize:12];
        _shakeLable.borderStyle = UITextBorderStyleRoundedRect;
        _shakeLable.delegate = self;
    }
    return _shakeLable;
}

- (UITextField *)boduLable {
    if (!_boduLable) {
        _boduLable = [[UITextField alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x, 0, 50, self.frame.size.height)];
        _boduLable.font = [UIFont systemFontOfSize:12];
        _boduLable.borderStyle = UITextBorderStyleRoundedRect;
        _boduLable.delegate = self;
    }
    return _boduLable;
}

- (UITextField *)chixuTime {
    if (!_chixuTime) {
        _chixuTime = [[UITextField alloc] initWithFrame:CGRectMake(self.shakeLable.frame.size.width+10+self.shakeLable.frame.origin.x+60, 0, 50, self.frame.size.height)];
        _chixuTime.font = [UIFont systemFontOfSize:12];
        _chixuTime.borderStyle = UITextBorderStyleRoundedRect;
        _chixuTime.delegate = self;
    }
    return _chixuTime;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        _deleteBtn.frame = CGRectMake(self.frame.size.width-100, 0, 100, self.frame.size.height);
        _deleteBtn.layer.cornerRadius = 10;
        _deleteBtn.layer.masksToBounds = YES;
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)deleteBtnClicked {
    self.clickBlock();
}

- (void)shakeTitle:(NSString *)title {
    self.shakeLable.text = title;
}

- (void)timeTitle:(NSString *)title {
    self.timeLable.text = title;
}

- (void)boduLable:(NSString *)title {
//    self.boduLable.text = title;
//    NSInteger selectRow = [title intValue]/10 - 1;
    
    NSInteger index = [self.pinlvArray indexOfObject:title];
    
    [self.pinlvPickerView selectRow:index inComponent:0 animated:NO];
    
}

- (void)chixuTimeLable:(NSString *)title {
//    self.chixuTime.text = title;
    
    NSInteger selectRow = [title intValue]/100 - 1;
    
    [self.timePickerView selectRow:selectRow inComponent:0 animated:NO];
}

- (void)changeBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundColor = backgroundColor;
}

# pragma mark UITextViewDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    self.timeText = _timeLable.text;
//    self.shakeText = _shakeLable.text;
//    self.pinlvText = _boduLable.text;
//    self.chixuTime = _chixuTime.text;
    NSLog(@"_timeLable text %@",_timeLable.text);
    NSLog(@"_shakeLable text %@",_shakeLable.text);
    self.updateTimeAndShake(_timeLable.text, _shakeLable.text, self.selectedPinLv, _chixuTime.text);
    if ([self.shakeDelegate respondsToSelector:@selector(keyboardhidden)]) {
        [self.shakeDelegate keyboardhidden];
    }
}

- (void)textTimeChanged:(UITextField*)textField {
    
    NSLog(@"textfield text %@",textField.text);
}

@end
