//
//  AfterViewController.m
//  WashCar
//
//  Created by Cheletong on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "AfterViewController.h"
#import "CustBgViewWidget.h"
#import "LineViewWidget.h"
#import "AfterModel.h"
#import "ColorButton.h"
#import "ImageBrowserWidget.h"
#import "PicCollectionViewCell.h"



#define singlePicH 57.f
#define singlePicW 65.f
#define singlePicXOffset 42.5f
#define singlePicYOffset 10.f
#define VIEW_Y TOP_BLANNER_HEIGHT+SCREEN_HEIGHT_START+58
#define tiplabel @"洗车效果照片仅供参考,建议您到停车点查看洗车效果后再确认洗车"
#define carlabel @"洗车效果照片"
#define centertitle @"洗车效果"

@interface AfterViewController ()
{
    AfterModel * aModel;
    NSMutableArray * _data;
    UICollectionView * _myCollectionView;
    NSString * _urlStr;
}
@end

@implementation AfterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navBarInfo];
    [self initData];
    
    
     self.view.backgroundColor=RGB_TextColor_C5;
    UILabel*_tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,VIEW_Y-50 , SCREEN_WIDTH-20,40)];
    _tipLabel.textColor=RGB_TextColor_C8;
    _tipLabel.text=tiplabel;
    _tipLabel.backgroundColor=[UIColor clearColor];
    _tipLabel.font=[UIFont systemFontOfSize:13];
    _tipLabel.numberOfLines = 0;
    [self.view addSubview:_tipLabel];
    //背景视图
    CGFloat bgViewX = 10.f;
    CGFloat bgViewY = VIEW_Y;
    CGFloat bgViewW = self.view.frame.size.width - 2*bgViewX;
    CGFloat bgViewH = self.view.frame.size.height-(TOP_BLANNER_HEIGHT+SCREEN_HEIGHT_START+80);
    CGRect  bgViewFrame = Rect(bgViewX, bgViewY, bgViewW, bgViewH);
    
    CustBgViewWidget *bgView = [[CustBgViewWidget alloc]initWithFrame:bgViewFrame];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
#pragma mark 标题
    CGFloat carlbX = 10.f;
    CGFloat carlbY = 0.f;
    CGFloat carlbW =bgView.frame.size.width - 2 * carlbX;
    CGFloat carlbH = 44.f;
    CGRect  carlbFrame = Rect(carlbX, carlbY, carlbW, carlbH);
    UILabel*CarLabel=[[UILabel alloc]initWithFrame:carlbFrame];
    CarLabel.text = carlabel;
    CarLabel.textColor=hexColor(0x66aad9,1);
    CarLabel.backgroundColor = [UIColor clearColor];
    CarLabel.font=FONT_TextSize_S3;
    [bgView addSubview:CarLabel];
    //分割线
    LineViewWidget *lineView = [[LineViewWidget alloc]initWithXoffset:CGRectGetMinX(CarLabel.frame)
                                                              yOffset:CGRectGetMaxY(CarLabel.frame)
                                                           lineHeight:0.5f
                                                            lineWidth:CGRectGetWidth(CarLabel.frame)
                                                            lineColor:0xe3e2e2
                                                            lineAlpha:1];
    [bgView addSubview:lineView];
 
    CGFloat picViewX = CGRectGetMinX(lineView.frame);
    CGFloat picViewY = CGRectGetMaxY(lineView.frame);
    CGFloat picViewW = bgView.frame.size.width - picViewX*2;
    CGRect  picViewFrame = Rect(picViewX, picViewY+5, picViewW,(bgViewFrame.size.height-picViewY-10));

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
   
            _myCollectionView = [[UICollectionView alloc] initWithFrame:picViewFrame
                                              collectionViewLayout:flowLayout];
    _myCollectionView.backgroundColor = [UIColor clearColor];
    [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    //隐藏垂直方向滚动条
    _myCollectionView.showsVerticalScrollIndicator=NO;
    [bgView addSubview:_myCollectionView];
}
#pragma mark 获取洗车照片
-(void)getPicther
{
    //发送网络请求
    NSDictionary*params=[NSDictionary dictionaryWithObjectsAndKeys:@"12313123131521",@"orderId",@"2",@"photoType", nil];
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
    _data=[[NSMutableArray alloc]init];
    [_data addObject:_urlStr];
    [super handleRespResult:result tag:reqTag];
    
}
#pragma mark 请求失败回调的数据
- (void)reqErrorHandle:(int)errorCode errormsg:(NSString *)message tag:(int)reqTag
{
    APP_DebugLog(@"请求失败 - %@",message);
    [super reqErrorHandle:errorCode errormsg:message tag:reqTag];
}

//数据源
-(void)initData
{
    _data = [NSMutableArray array];
    [_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];
    [_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];[_data addObject:@"1.jpg"];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    return _data.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark   每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

   static NSString * CellIdentifier = @"myCell";
   UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell)
    {
        cell=[[UICollectionViewCell alloc]initWithFrame:Rect(0.f, 0.f, singlePicW, singlePicH)];
    }
    CGRect picCellItemFrame=Rect(0.f, 0.f, singlePicW, singlePicH);
    PicCollectionViewCell*cellItem=[[PicCollectionViewCell alloc]initWithFrame:picCellItemFrame image:[_data objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:cellItem];

    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(singlePicW, singlePicH);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     ImageBrowserWidget *imageBrowser = [[ImageBrowserWidget alloc]initWithFrame:self.view.bounds];
     imageBrowser.type =  ImageBrowserPicType_Net;
     imageBrowser.images = [NSArray arrayWithObjects:@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/3c6d55fbb2fb4316de9bcd7d22a4462309f7d335.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0dd7912397dda14446c026afb0b7d0a20df486e6.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0df431adcbef7609acc727912cdda3cc7dd99ef4.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/9825bc315c6034a894e25d89c9134954092376b2.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea76ebc4ead739b6003af3b39b.jpg", nil];
      imageBrowser.selectedIndex = indexPath.row;
      [self.view addSubview:imageBrowser];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NavBarInfoModel*)navBarInfo
{
    NavBarInfoModel *navBarInfo = [[NavBarInfoModel alloc]init];
    navBarInfo.navCenterTitle = centertitle;
    return navBarInfo;
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
