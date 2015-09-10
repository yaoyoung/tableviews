//
//  MoneyPickerView.m
//  积分墙
//
//  Created by yangyao on 15/9/6.
//  Copyright (c) 2015年 lc. All rights reserved.
//

#import "MoneyPickerView.h"
@interface MoneyPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy) void (^backValue)(NSString *strValue);
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong)  NSMutableArray *objectArray;
@end
@implementation MoneyPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addDayPickerView];
        [self loadPickerDataSource];
        [self loadSelfView];
        [_pickerView selectRow:_currentValue inComponent:0 animated:NO];
    }
    return self;
}

#pragma mark 加载界面
//加载button
-(void)loadSelfView{
    UIButton *canselButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 40, 70)];
    canselButton.backgroundColor = [UIColor clearColor];
    [canselButton setTitle:@"取消" forState:UIControlStateNormal];
    [canselButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [canselButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canselButton];
    
    UIButton *surelButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds) - 20 - 35, 10, 40, 70)];
    surelButton.backgroundColor = [UIColor clearColor];
    [surelButton setTitle:@"确定" forState:UIControlStateNormal];
    [surelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [surelButton addTarget:self action:@selector(sureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:surelButton];
}

/**
 *  加载数据源
 */
- (void)loadPickerDataSource{
    _objectArray = [[NSMutableArray alloc]init];
    for (NSInteger idx = 0; idx<=60 ;idx++) {
        NSString *value = [NSString stringWithFormat:@"支付宝%ld元",(long)idx];
        [_objectArray addObject:value];
    }
}

/**
 *  初始化pickerview
 */
- (void)addDayPickerView{
    _pickerView = [[UIPickerView alloc]init];
    _currentValue = 0;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
}

- (void)sendMoneyWithBlock:(MyBlock)block{
    self.returnBlock = block;
//    self.returnBlock(@"d");
}

#pragma mark 自定义方法
/**
 *  确定按钮
 *
 *  @param sender button事件
 */
- (void)sureButtonPressed:(UIButton *)sender{
    if (self.returnBlock) {
    self.returnBlock(_objectArray[_currentValue]);
    }
    [self removeFromSuperview];
}



/**
 *  取消按钮
 *
 *  @param sender
 */
- (void)cancelButtonPressed:(UIButton *)sender{
    [self removeFromSuperview];
}

#pragma mark pickerView协议方法
//返回的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//选择的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _currentValue = row;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _objectArray.count;
}

//没列的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_objectArray objectAtIndex:row];
}


@end
