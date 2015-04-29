//
//  BeforeViewController.m
//  WashCar
//
//  Created by Cheletong on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BeforeViewController.h"
#import "LineViewWidget.h"
#import "BeforeCell.h"
#import "UIView+WashCarUtility.h"
#import "CarPicModel.h"
#import "ImageBrowserWidget.h"
#define VIEW_Y TOP_BLANNER_HEIGHT+SCREEN_HEIGHT_START+39
#define tiplabel @"检车洗车前照片,有问题可联系客服"
#define modeltitle1 @"左前车头划痕"
#define modeltitle2 @"左门划痕"
#define modeltitle3 @"右前车头划痕"
#define modeltitle4 @"右门划痕"
#define modeltitle5 @"顶部划痕"
#define centertitle @"洗车前照片"

@interface BeforeViewController ()
<BeforeCellDelegate>
{
    UITableView*_carTableView;
    NSMutableArray *_data;
    NSString*_urlStr;
    ImageBrowserWidget *_imageBrowser;
}
@end

@implementation BeforeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navBarInfo];
    //[self getPicther];
    
    
    self.view.backgroundColor=RGB_TextColor_C5;
    _carTableView=[[UITableView alloc]initWithFrame:CGRectMake(0.f, VIEW_Y, SCREEN_WIDTH,ScreenHeight-VIEW_Y-125) style:UITableViewStylePlain];
  
    _carTableView.delegate=self;
    _carTableView.dataSource=self;
    _carTableView.backgroundColor = [UIColor clearColor];
    _carTableView.showsVerticalScrollIndicator = NO;
    _carTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_carTableView];
    
    [self initData];
    
    UILabel*tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,VIEW_Y-30 , SCREEN_WIDTH-20, 30)];
   tipLabel.textColor=RGB_TextColor_C8;
    tipLabel.text=tiplabel;
    tipLabel.backgroundColor=[UIColor clearColor];
   tipLabel.font=FONT_TextSize_S5;
   [self.view addSubview:tipLabel];
     
}

#pragma mark 获取洗车照片
-(void)getPicther
{
    
    //发送网络请求
    NSDictionary*params=[NSDictionary dictionaryWithObjectsAndKeys:@"12313",@"orderId",@"1",@"photoType", nil];
    
    
         [self doPost:orderPhotoGetUrl params:params];
    
   
    APP_DebugLog(@"getPicther");
}
#pragma mark 请求成功以后回调数据
- (void)handleRespResult:(NSDictionary *)result tag:(int)reqTag
{
    APP_DebugLog(@"result - %@",result);
    if (result != nil)
    {
        NSArray * PicArray =[result objectForKey:@"washPhotos"];
        NSDictionary * dic=[PicArray objectAtIndex:0];
        _urlStr=[dic objectForKey:@"photoUrl"];
    }
    [super handleRespResult:result tag:reqTag];
    
}
#pragma mark 请求失败回调的数据
- (void)reqErrorHandle:(int)errorCode errormsg:(NSString *)message tag:(int)reqTag
{
    
    APP_DebugLog(@"请求失败 - %@",message);
    [super reqErrorHandle:errorCode errormsg:message tag:reqTag];
    
}
-(void)initData
{
    //图片数据源
    _data = [NSMutableArray array];
    CarPicModel *model1 = [[CarPicModel alloc]init];
    model1.title = modeltitle1;
    model1.pics = [NSArray arrayWithObjects:@"Ring.png", nil];
    
    CarPicModel *model2 = [[CarPicModel alloc]init];
    model2.title = modeltitle2;
    model2.pics = [NSArray arrayWithObjects:@"1.png",@"1.png",@"1.png",@"1.png",@"1.png",@"1.png", nil];
    
    CarPicModel *model3 = [[CarPicModel alloc]init];
    model3.title = modeltitle3;
    model3.pics = [NSArray arrayWithObjects:@"1.png",@"1.png",@"1.png",@"1.png",@"1.png",@"1.png", nil];
    CarPicModel *model4 = [[CarPicModel alloc]init];
    model4.title = modeltitle4;
    model4.pics = [NSArray arrayWithObjects:@"1.png",@"1.png",@"1.png", nil];

    CarPicModel *model5 = [[CarPicModel alloc]init];
    model5.title = modeltitle5;
    model5.pics = [NSArray arrayWithObjects:@"1.png",@"1.png",@"1.png",@"1.png",@"1.png", nil];
    
    _data = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,model5, nil];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* identifier = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    //重置 UITableViewCell
    [cell.contentView removeAllSubviews];
    
    BeforeCell*beforeCell = [[BeforeCell alloc]initWithFrame:Rect(0.f, 0.f, SCREEN_WIDTH,0.f) data:[_data objectAtIndex:indexPath.row]];
    beforeCell.delegate = self;
    cell.frame = Rect(0.f, 0.f, SCREEN_WIDTH, beforeCell.frame.size.height);
    [cell.contentView addSubview:beforeCell];
    //不让选中tableview
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return Cell.frame.size.height;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark 导航栏处理
-(NavBarInfoModel*)navBarInfo{
    NavBarInfoModel *navBarInfo = [[NavBarInfoModel alloc]init];
    navBarInfo.navCenterTitle = centertitle;
    return navBarInfo;
}

#pragma mark 实现代理
-(void)picClickedAtIndex:(int)selectedIndex pics:(NSArray*)pics
{
    //图片处理
        _imageBrowser = [[ImageBrowserWidget alloc]initWithFrame:self.view.bounds];
        _imageBrowser.type =  ImageBrowserPicType_Net;
        _imageBrowser.images = [NSArray arrayWithObjects:@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg", nil];
        _imageBrowser.selectedIndex=selectedIndex;
        [self.view addSubview:_imageBrowser];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end