//
//  WBShakeFourViewController.m
//  WBShakeDemo
//
//  Created by fangtingting on 2021/3/1.
//

#import "WBShakeFourViewController.h"

#import "ZZRHapticFeedbackManager.h"
#import "PlayView.h"
#import "DYShakeCollectionViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


static NSString *const cell = @"DYShakeCollectionViewCell";

@interface WBShakeFourViewController ()<PlayViewDelegate, DYShakeViewDelegate>

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PlayView *playView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSMutableArray *data;

@end

@implementation WBShakeFourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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





    

    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.minusBtn];
    [self.view addSubview:self.saveBtn];
    
    self.playView=[[PlayView alloc] initWithFrame:CGRectMake(10, 100, 320, 50)];
    [self.view addSubview:self.playView];
    
    [self initCollection];
}

- (void)initCollection {
    UICollectionViewFlowLayout *hotProductlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [hotProductlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置间距
    hotProductlayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300) collectionViewLayout:hotProductlayout];
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
    NSNumber *timeNum = self.data[indexPath.row];
    [shakeCell timeTitle:timeNum.stringValue];
    [shakeCell shakeTitle:@"3"];
    return shakeCell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        return CGSizeMake(self.collectionView.frame.size.width, 50);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
//    [self.data removeObjectAtIndex:indexPath.row];
//    [self.collectionView reloadData];
}

#pragma mark - events
- (void)testBtnClicked {

    [self network];
}

- (void)addBtnClicked {
    NSLog(@"time:%@",self.playView.time);
    [self.collectionView reloadData];
}

- (void)minusBtnClicked {
    
}

- (void)saveBtnClicked {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)network {
//    NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //1.创建音乐路径
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"1234" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:musicFilePath];
//http://10.1.61.164:8081/artifactory/douyu-ios-files/music_202002261611.json
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://10.1.61.164:8081/artifactory/douyu-ios-files/music_202002261611.json"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //回到主线程刷新界面
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",responseDictionary);
                NSMutableArray* array = [responseDictionary objectForKey:@"ms"];
                self.data = array;
//                [self.playView playWith:url data:array];
                [self.collectionView reloadData];
            });
            
        }] resume] ;
}




@end

