//
//  DYShakeCollectionViewCell.h
//  WBShakeDemo
//
//  Created by fangtingting on 2021/3/3.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@protocol DYShakeViewDelegate <NSObject>

- (void)deleteItem;
- (void)keyboardhidden;

@end

@interface DYShakeCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<DYShakeViewDelegate> shakeDelegate;

@property (nonatomic, copy) void(^clickBlock) (void);
@property (nonatomic, copy) void(^updateTimeAndShake) (NSString *timeTest, NSString *shakeTest, NSString *pinlv, NSString *chixuTime);
@property (nonatomic, assign) NSString *timeText;
@property (nonatomic, assign) NSString *shakeText;
@property (nonatomic, assign) NSString *pinlvText;
@property (nonatomic, assign) NSString *chixuTimeText;


- (void)shakeTitle:(NSString *)title;
- (void)timeTitle:(NSString *)title;
- (void)boduLable:(NSString *)title;
- (void)chixuTimeLable:(NSString *)title;

- (void)changeBackgroundColor:(UIColor *)backgroundColor;

@end

NS_ASSUME_NONNULL_END
