//
//  MyCar.m
//  WashCar
//
//  Created by mac on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "MyCarController.h"
#import "MyCarCell.h"
#import "MyCarModel.h"
#import "ImageCache.h"

@interface MyCarController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel* _lbHeadDescribe;    // 顶部描述文字
    UITableView* _tableView; // 车
    UIButton* _btnAddCar;   // 继续添加车辆
    NSMutableArray* _arrayData; // 数据
}
@end

#define lbHeadDescribeX     20
#define lbHeadDescribeY     75
#define lbHeadDescribeW     280
#define lbHeadDescribeH     60
#define btnAddCarX          20
#define btnAddCarY          CGRectGetMaxY(_tableView.frame) + 20
#define btnAddCarW          ScreenWidth - btnAddCarX * 2
#define btnAddCarH          40

@implementation MyCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayData = [NSMutableArray array];
    NSDictionary* dic = [NSDictionary dictionaryWithObjects:@[@"银灰色",@"浙A 478A23",@"保时捷911",@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1208/01/c4/12645660_12645660_1343800170831_800x600.jpg"] forKeys:@[@"carColor",@"carLicensePlate",@"carType",@"carURL"]];
    MyCarModel* model = [[MyCarModel alloc] initWithDic:dic];
    [_arrayData addObject:model];
    
    // 搭建ui控件
    [self drawUIView];
}

#pragma mark - 搭建UI控件
- (void) drawUIView
{
    _lbHeadDescribe = [[UILabel alloc] init];
    _lbHeadDescribe.frame = CGRectMake(lbHeadDescribeX, lbHeadDescribeY, lbHeadDescribeW, lbHeadDescribeH);
    _lbHeadDescribe.numberOfLines = 2;
    _lbHeadDescribe.text = @"跑男通过车牌号、车型找到你的车辆，添加车照片找车速度可以翻倍噢!!";
    _lbHeadDescribe.font = FONT_TextSize_S0;
    _lbHeadDescribe.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_lbHeadDescribe];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_lbHeadDescribe.frame) + 20, ScreenWidth, 70 * [_arrayData count]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _btnAddCar = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAddCar.frame = CGRectMake(btnAddCarX, btnAddCarY, btnAddCarW, btnAddCarH);
    _btnAddCar.tag = 1;
    [_btnAddCar addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAddCar setTitle:@"继续添加车辆" forState:UIControlStateNormal];
    _btnAddCar.titleLabel.font = FONT_TextSize_S0;
    _btnAddCar.tintColor = [UIColor whiteColor];
    _btnAddCar.backgroundColor = [UIColor redColor];
    _btnAddCar.layer.cornerRadius = 5;
    [self.view addSubview:_btnAddCar];
    
}

#pragma mark - tableViewDelegate
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayData count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"id";
    MyCarCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = [_arrayData objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            [self showAlert:@"" message:@"车详情" type:1];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 点击事件
- (void) btnClicked:(UIButton*) sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1:
        {
            [self showAlert:@"" message:@"继续添加车辆" type:1];
            break;
        }
            
        default:
            break;
    }
}

@end
