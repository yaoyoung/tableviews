//
//  MoneyPickerView.h
//  积分墙
//
//  Created by yangyao on 15/9/6.
//  Copyright (c) 2015年 lc. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^MyBlock)(NSString *moneyString);//block
@interface MoneyPickerView : UIView
@property (nonatomic,readwrite)  NSInteger currentValue;
@property (nonatomic,copy) MyBlock  returnBlock;
- (void)sendMoneyWithBlock:(MyBlock)block;
@end
