//
//  ViewController.m
//  tableviews
//
//  Created by yangyao on 15/9/6.
//  Copyright (c) 2015年 yangyao. All rights reserved.
//

#import "ViewController.h"
#import "MoneyPickerView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,strong)NSString *cellString;
@property (nonatomic,strong)MoneyPickerView *pickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}


#pragma mark uitableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];//如果重用，把数据加载到重写的cell里，不然刷新会重复加载。
    if (indexPath.row == 0) {
        cell.textLabel.text = @"点击加载数据";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"数据如下";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = _cellString;
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        _pickerView = [[MoneyPickerView alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 300)];
        //BLOck回调 并刷新界面
        [_pickerView sendMoneyWithBlock:^(NSString *moneyString) {
            _cellString = moneyString;
            [_tableView reloadData];
        }];
        [self.view addSubview:_pickerView];//加载试图
    }
}


@end
