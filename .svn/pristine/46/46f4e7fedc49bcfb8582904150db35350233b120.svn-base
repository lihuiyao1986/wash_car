//
//  AboutMyViewController.m
//  WashCar
//
//  Created by mac on 15/1/4.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "AboutMyViewController.h"
#import "PersonalDataController.h"
#import "TapImageViewWidget.h"
#import "ImageCache.h"
#import "MyCarController.h"

@interface AboutMyViewController ()
<TapImageViewWidgetDelegate,
 NavBarViewWidgetDelegate>
{
    TapImageViewWidget* photoImgView;      // 照片
    UILabel* lbName;                // 姓名
}
@end

#define photoImgViewX           ScreenWidth / 2 - photoImgViewW / 2
#define photoImgViewY           75
#define photoImgViewW           80
#define photoImgViewH           80
#define lbNameX                 ScreenWidth / 2 - lbNameW / 2
#define lbNameY                 CGRectGetMaxY(photoImgView.frame) + 10
#define lbNameW                 80
#define lbNameH                 40

@implementation AboutMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 搭建ui控件
    [self drawUIView];
}

#pragma mark - 搭建UI控件
- (void)drawUIView
{
    photoImgView = [[TapImageViewWidget alloc] init];
    photoImgView.frame = CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH);
    photoImgView.delegate = self;
    photoImgView.layer.cornerRadius = 40;
    photoImgView.layer.borderWidth = 1;
    photoImgView.layer.borderColor = [UIColor blackColor].CGColor;
    [ImageCache loadImageWithUrl:@"http://b.hiphotos.baidu.com/image/pic/item/e4dde71190ef76c666af095f9e16fdfaaf516741.jpg" imageView:photoImgView placeholderImage:@"" cacheImage:YES];
    [self.view addSubview:photoImgView];
    
    lbName = [[UILabel alloc] init];
    lbName.frame = CGRectMake(lbNameX, lbNameY, lbNameW, lbNameH);
    lbName.textAlignment = NSTextAlignmentCenter;
    lbName.text = @"jack";
    lbName.textColor = [UIColor blackColor];
    lbName.numberOfLines = 1;
    [self.view addSubview:lbName];
    
    // 我的爱车
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lbName.frame) + 20, ScreenWidth, 45) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - tableViewDelegate
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    cell.textLabel.text = @"我的爱车";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            MyCarController* vc = [[MyCarController alloc] init];
            [self pushViewControllerFromBottom:vc];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - TapImageViewWidgetDelegate
- (void)imageTap:(id)sender imageView:(UIImageView *)imageView
{
    PersonalDataController* vc = [[PersonalDataController alloc] init];
    [self pushViewControllerFromBottom:vc];
}


#pragma mark - 导航栏
- (BaseNaviBarWidget *)navBar
{
    NavBarViewWidget *navBar = [[NavBarViewWidget alloc]init];
    navBar.leftIcon = [UIImage imageNamed:@"back"];
    navBar.delegate = self;
    return navBar;
}

-(void)leftNavBarBtnClicked:(UIButton *)leftNavBarBtn
{
    [self popViewControllerFromTop];
}
@end
