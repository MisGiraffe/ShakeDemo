//
//  WBShakeFiveViewController.m
//  WBShakeDemo
//
//  Created by fangtingting on 2021/3/3.
//

#import "WBShakeFiveViewController.h"

#import "WBShakeFiveViewController.h"

#import "ZZRHapticFeedbackManager.h"
#import "PlayView.h"
#import "DYShakeCollectionViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


static NSString *const cell = @"DYShakeCollectionViewCell";

@interface WBShakeFiveViewController ()<PlayViewDelegate, DYShakeViewDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PlayView *playView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *allData;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) NSTimer *shakeTimer;
@property (nonatomic, assign) double jumpTime;
@property (nonatomic, strong) NSTimer *collectionTimer;
@property (nonatomic, assign) int listNum;
@property (nonatomic, assign) double listTime;

@property (nonatomic, strong) NSMutableArray *shakeLevel;
@property (nonatomic, strong) NSMutableArray *personAdd;

@property (nonatomic, strong) NSMutableArray *pinlv;
@property (nonatomic, strong) NSMutableArray *chixuTime;

@property (nonatomic, strong) UIPickerView *pickerVIew;
@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,strong)NSArray *provinceArray;
@property(nonatomic,copy)NSString *selectedProvince;

@property (nonatomic, strong) UILabel *engineTime;
@property (nonatomic, strong) UILabel *engineShake;
@property (nonatomic, strong) UILabel *engineBodu;
@property (nonatomic, strong) UILabel *enginechixuTime;



@end

@implementation WBShakeFiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc] init];
    self.shakeLevel = [[NSMutableArray alloc] init];
    self.personAdd = [[NSMutableArray alloc] init];
    self.pinlv = [[NSMutableArray alloc] init];
    self.chixuTime = [[NSMutableArray alloc] init];
    
//    [self showData];
    self.view.backgroundColor = UIColor.whiteColor;

    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.startBtn.frame = CGRectMake(WIDTH/2-150, 160 , 100, 50);
    self.startBtn.layer.borderWidth = 1;
    self.startBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.backgroundColor = COLOR(255, 87, 79, 1);
    self.saveBtn.frame = CGRectMake(WIDTH/2-150+150, 160 , 100, 50);
    self.saveBtn.layer.borderWidth = 1;
    self.saveBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.backgroundColor = COLOR(251, 157, 33, 1);
    self.addBtn.frame = CGRectMake(WIDTH/2-150 + 100, 230 , 100, 50);
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minusBtn.backgroundColor = COLOR(118, 218, 84, 1);
    self.minusBtn.frame = CGRectMake(WIDTH/2-150 + 250, 230 , 100, 50);
    [self.minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.minusBtn setTitleColor:COLOR(50, 50, 50, 1) forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 230 , 100, 50)];
    self.timeLable.backgroundColor = COLOR(100, 218, 84, 1);

    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.addBtn];
//    [self.view addSubview:self.minusBtn];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.timeLable];
    
    self.playView=[[PlayView alloc] initWithFrame:CGRectMake(10, 100, 320, 50)];
    self.playView.playerDelegate = self;
    [self.view addSubview:self.playView];
    [self initCollection];
    
    self.provinceArray = @[@"001",@"002",@"003",@"004",@"005",@"006"];
    self.selectedProvince = self.provinceArray[0];
    [self.view addSubview:self.pickerVIew];
    
    [self showData:[self strData]];
    
    [self.view addSubview:self.engineTime];
    [self.view addSubview:self.engineShake];
    [self.view addSubview:self.engineBodu];
//    [self.view addSubview:self.enginechixuTime];
    
    
}


- (UILabel *)engineTime {
    if (!_engineTime) {
        _engineTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 100, 50)];
        _engineTime.text = @"时长";
    }
    return _engineTime;
}

- (UILabel *)engineShake {
    if (!_engineShake) {
        _engineShake = [[UILabel alloc] initWithFrame:CGRectMake(140, 300, 50, 50)];
        _engineShake.text = @"强度";
    }
    return _engineShake;
}

- (UILabel *)engineBodu {
    if (!_engineBodu) {
        _engineBodu = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 100, 50)];
        _engineBodu.text = @"震动效果";
    }
    return _engineBodu;
}

- (UILabel *)enginechixuTime {
    if (!_enginechixuTime) {
        _enginechixuTime = [[UILabel alloc] initWithFrame:CGRectMake(260, 300, 100, 50)];
        _enginechixuTime.text = @"持续时长";
    }
    return _enginechixuTime;
}
//懒加载
- (UIPickerView *)pickerVIew{
    if (_pickerVIew == nil) {
        _pickerVIew = [[UIPickerView alloc]initWithFrame:CGRectMake(WIDTH/2-150 + 250, 230 , 100, 50)];
        _pickerVIew.layer.masksToBounds = YES;
        _pickerVIew.layer.borderWidth = 1;
        
        _pickerVIew.delegate = self;
        _pickerVIew.dataSource = self;
    }
    
    return _pickerVIew;
}



#pragma mark ------- dateSource&&Delegate --------

//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.provinceArray.count;

}

//设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.provinceArray[row];
}

//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedProvince = self.provinceArray[row];
    [self showData:[self strData]];
   
}


- (void)initCollection {
    UICollectionViewFlowLayout *hotProductlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [hotProductlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置间距
    hotProductlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, self.view.frame.size.height-300) collectionViewLayout:hotProductlayout];
    //self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor colorWithRed:242/255.0 green:246/255.0 blue:247/255.0 alpha:1/1.0];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[DYShakeCollectionViewCell class] forCellWithReuseIdentifier:cell];
    [self.view addSubview:self.collectionView];

    
    
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//告诉系统第section组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

//告诉系统indexPath的第Section组的item行显示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYShakeCollectionViewCell* shakeCell = [collectionView dequeueReusableCellWithReuseIdentifier:cell forIndexPath:indexPath];
    shakeCell.shakeDelegate = self;
    shakeCell.clickBlock = ^{
        [self.data removeObjectAtIndex:indexPath.row];
        [self.shakeLevel removeObjectAtIndex:indexPath.row];
        [self.personAdd removeObjectAtIndex:indexPath.row];
        
        [self.pinlv removeObjectAtIndex:indexPath.row];
        [self.chixuTime removeObjectAtIndex:indexPath.row];
        NSLog(@"delete data %lu", (unsigned long)self.allData.count);
        [self.collectionView reloadData];
    };
    shakeCell.updateTimeAndShake = ^(NSString * _Nonnull timeTest, NSString * _Nonnull shakeTest, NSString * _Nonnull pinlv, NSString * _Nonnull chixuTime)  {
        int intNum = [timeTest intValue];
        NSNumber *temp = [NSNumber numberWithInt:intNum];
        
        NSNumber *dataNum = self.data[indexPath.row];
        NSNumber *oldlevelNum = self.shakeLevel[indexPath.row];
        NSString *oldpinlvNum = self.pinlv[indexPath.row];
        NSNumber *oldchixuNum = self.chixuTime[indexPath.row];
        
        intNum = [shakeTest intValue];
        NSNumber *levelNum = [NSNumber numberWithInt:intNum];
        
//        intNum = [pinlv intValue];
//        NSNumber *pinlvNum = [NSNumber numberWithInt:intNum];
        
        intNum = [chixuTime intValue];
        NSNumber *chixuNum = [NSNumber numberWithInt:intNum];
        
        [self.shakeLevel removeObjectAtIndex:indexPath.row];
        [self.personAdd removeObjectAtIndex:indexPath.row];
        
        if (pinlv.length > 0) {
            [self.pinlv removeObjectAtIndex:indexPath.row];
        }
        if (![chixuNum isEqualToNumber:@(0)]) {
            [self.chixuTime removeObjectAtIndex:indexPath.row];
        }
        
        if (![temp isEqualToNumber:dataNum] || ![levelNum isEqualToNumber:oldlevelNum] || ![pinlv isEqualToString:oldpinlvNum] || ![chixuNum isEqualToNumber:oldchixuNum]) {
            [self.data replaceObjectAtIndex:indexPath.row withObject:temp];
            NSLog(@"text row%ld timeTest %@",(long)indexPath.row, temp);
            
            NSArray *array2 = [self.data sortedArrayUsingSelector:@selector(compare:)];
            self.data = [NSMutableArray arrayWithArray:array2];
            NSInteger index=[self.data indexOfObject:temp];
            
            [self.shakeLevel insertObject:levelNum atIndex:index];
            [self.personAdd insertObject:@(1) atIndex:index];
            if (pinlv.length > 0) {
                [self.pinlv insertObject:pinlv atIndex:index];
            }
            if (![chixuNum isEqualToNumber:@(0)]) {
                [self.chixuTime insertObject:chixuNum atIndex:index];
            }
            
            
            
            [self.collectionView reloadData];
            
            NSIndexPath *scrollIndecPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.collectionView scrollToItemAtIndexPath:scrollIndecPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        }
        
    };
    NSNumber *timeNum = self.data[indexPath.row];
    [shakeCell timeTitle:timeNum.stringValue];
    
    
    NSNumber *level = self.shakeLevel[indexPath.row];
    [shakeCell shakeTitle:level.stringValue];
    
    NSString *pinlv = self.pinlv[indexPath.row];
    [shakeCell boduLable:pinlv];
    
    NSNumber *chixu = self.chixuTime[indexPath.row];
    [shakeCell chixuTimeLable:chixu.stringValue];

    if ([self.personAdd[indexPath.row] isEqualToNumber:@(1)]) {
        [shakeCell changeBackgroundColor:[UIColor orangeColor]];
    }
    else {
        [shakeCell changeBackgroundColor:[UIColor whiteColor]];
    }
    
    return shakeCell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        return CGSizeMake(self.collectionView.frame.size.width, 50);
    
}


#pragma mark - events
- (void)testBtnClicked {

    self.jumpTime = 0;
    [self network:self.selectedProvince];
    [self startTimer];
    
    //list滚动
    self.listNum = 0;
    self.listTime = 0;
    
}

- (void)collectionRollTime{
    NSNumber *timeNum = self.data[self.listNum];
    float timeFloat = timeNum.floatValue;
    CGFloat num = self.listTime - timeFloat;
    if (num >= 0 && num <= 20 && self.listNum < self.data.count) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:self.listNum inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        self.listNum++;
    }
    else {
        
    }
    
    if (self.listNum >= self.data.count) {
        [self.collectionTimer invalidate];
    }
    self.listTime = self.listTime + 10;
    
   
}

- (void)startRollTimer {
    
    //list定时器
    self.collectionTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(collectionRollTime) userInfo:nil repeats:YES];
    // 将定时器添加到runloop中，否则定时器不会启动
   [[NSRunLoop mainRunLoop] addTimer:self.collectionTimer forMode:NSRunLoopCommonModes];
    
    //时间定时器
    self.shakeTimer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(rollTime) userInfo:nil repeats:YES];
    // 将定时器添加到runloop中，否则定时器不会启动
   [[NSRunLoop mainRunLoop] addTimer:self.shakeTimer forMode:NSRunLoopCommonModes];
}

- (void)rollTime {
    self.timeLable.text = [NSString stringWithFormat:@"%.3f", self.jumpTime];
    self.jumpTime = self.jumpTime + 0.02;
    NSLog(@"rollTime:%@",self.playView.time);
}

- (void)addBtnClicked {
//    int time = [self.playView.time intValue];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:self.data forKey:@"ms"];
    int temp = (self.jumpTime-0.02) * 1000;
    NSNumber *number = [NSNumber numberWithInt:temp];
    [self.data addObject:number];
    NSArray *array2 = [self.data sortedArrayUsingSelector:@selector(compare:)];
    self.data = [NSMutableArray arrayWithArray:array2];
    
    NSInteger index=[self.data indexOfObject:number];
    
    [self.shakeLevel insertObject:@(1) atIndex:index];
    [self.personAdd insertObject:@(1) atIndex:index];
    [self.pinlv insertObject:@"Boing" atIndex:index];
    [self.chixuTime insertObject:@(500) atIndex:index];
    
    NSLog(@"add data %lu", (unsigned long)self.allData.count);
    
    [self.collectionView reloadData];
    
    NSIndexPath *scrollIndecPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:scrollIndecPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}

- (void)minusBtnClicked {
    
}

- (void)saveBtnClicked {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 这个文件后缀可以是任意的，只要不与常用文件的后缀重复即可，我喜欢用data
    NSString *filePath = [path stringByAppendingPathComponent:self.selectedProvince];
    
    [self saveTwoArray];
    NSLog(@"save data %lu", (unsigned long)self.allData.count);
    // 归档
    [NSKeyedArchiver archiveRootObject:self.allData toFile:filePath];
    
    
}

- (void)saveTwoArray {
    [self.allData removeAllObjects];
    for (int i=0;i<self.data.count;i++) {
//        if (i < self.allData.count) {
//            self.allData[i][0] = self.data[i];
//            self.allData[i][1] = self.shakeLevel[i];
//            self.allData[i][2] = self.personAdd[i];
//            NSLog(@"data %@ shakeLevel %@ personAdd %@",self.allData[i][0],self.allData[i][1],self.allData[i][2]);
//        }
//        else {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
            [tempArray addObject:self.data[i]];
            [tempArray addObject:self.shakeLevel[i]];
            [tempArray addObject:self.personAdd[i]];
            [tempArray addObject:self.pinlv[i]];
            [tempArray addObject:self.chixuTime[i]];
            
            [self.allData addObject:tempArray];
//            NSLog(@"data %@ shakeLevel %@ personAdd %@",self.allData[i][0],self.allData[i][1],self.allData[i][2]);
//        }
    }
}

- (void)stopTimer {
    [self.shakeTimer invalidate];
    [self.collectionTimer invalidate];
}

- (void)startTimer {
    [self startRollTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)strData {
    if ([self.selectedProvince isEqualToString:@"001"]) {
        return @"result_001.json";
    }
    else if ([self.selectedProvince isEqualToString:@"002"]) {
        return @"result_002.json";
    }
    else if ([self.selectedProvince isEqualToString:@"003"]) {
        return @"result_003.json";
    }
    else if ([self.selectedProvince isEqualToString:@"004"]) {
        return @"result_004.json";
    }
    else if ([self.selectedProvince isEqualToString:@"005"]) {
        return @"result_005.json";
    }
    else if ([self.selectedProvince isEqualToString:@"006"]) {
        return @"result_006.json";
    }
    return nil;
}

- (void)showData:(NSString *)strdata {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:self.selectedProvince];
    // 解档
    NSMutableArray *saveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (saveData.count > 0) {
        [self makeUpData:saveData];
        self.allData = saveData;
        NSLog(@"jie data %lu", (unsigned long)saveData.count);
    }
    else {
//        NSString *pathJson = [[NSBundle mainBundle] pathForResource:@"allresult.json" ofType:nil];
    NSString *pathJson = [[NSBundle mainBundle] pathForResource:strdata ofType:nil];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:pathJson];
        NSError *error;
        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        self.allData = [jsonObj objectForKey:@"ms"];
        [self makeUpData:self.allData];
    
        [self saveBtnClicked];
    }
    
    [self.collectionView reloadData];
}

- (void)makeUpData:(NSMutableArray *)array {
    [self.data removeAllObjects];
    [self.shakeLevel removeAllObjects];
    [self.personAdd removeAllObjects];
    [self.chixuTime removeAllObjects];
    [self.pinlv removeAllObjects];
    for (int i=0;i<array.count;i++) {
        NSNumber *number0 = array[i][0];
        NSNumber *number1 = array[i][1];
        NSNumber *number2 = array[i][2];
        NSMutableArray *tempArray = array[i];
        if (tempArray.count == 5) {
            NSNumber *number3 = array[i][3];
            NSNumber *number4 = array[i][4];
            [self.chixuTime addObject:number4];
            [self.pinlv addObject:number3];
        }
        else {
            [self.chixuTime addObject:@(500)];
            [self.pinlv addObject:@"Boing"];
        }
        [self.data addObject:number0];
        [self.shakeLevel addObject:number1];
        [self.personAdd addObject:number2];
        
//        NSLog(@"number0 %@ number1 %@ number2 %@",number0,number1,number2);
//        NSLog(@"data %@ shakeLevel %@ personAdd %@",self.data[i],self.shakeLevel[i],self.personAdd[i]);
    }
}

- (void)network:(NSString *)name{
//    NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //1.创建音乐路径
//    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"12345" ofType:@"wav"];
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:musicFilePath];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:self.selectedProvince];
    // 解档
    NSMutableArray *playArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [self makeUpData:playArray];
    [self.playView playWith:url data:self.data pinlv:self.pinlv qiangdu:self.shakeLevel chixu:self.chixuTime];
}

- (void)keyboardhidden {
    [self.view endEditing:YES];
}



@end

