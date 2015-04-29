//
//  MainController.m
//  WashCar
//
//  Created by yanshengli on 14-12-19.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "MainController.h"
#import "LoginController.h"
#import "AboutMyViewController.h"
#import "PayIndexController.h"
#import "CustTextImageBtnWidget.h"
#import "LineViewWidget.h"
#import "CustBgViewWidget.h"
#import "PayDetailController.h"
#import "OrderDao.h"
#import "OrderDaoModel.h"
#import "AfterViewController.h"

//联系客户按钮对应的宽度
#define contactBtnAreaW 82.f
//定位图标的宽度
#define mapIconW 16.f
//定位图标的高度
#define mapIconH 19.f
//显示定位信息label的长度
#define addressW 160.f
//定位图标x偏移量
#define mapIconXPadding 15.f
//分割线的长度
#define seperatorLineW 2.f
//正在定位的提示
#define locatingTitle @"正在获取您的位置..."
//定位失败的提示
#define locateFailTitle @"对不起，获取您的位置失败"

//呼叫跑男按钮的高度
#define callBtnHeight 60.f
//呼叫跑男洗车按钮距离x边缘的距离
#define callBtnXPadding 80.f
//呼叫按钮标题
#define callBtnTitle  @"呼叫跑男洗车"
//提示视图的标题
#define orderTipInfoTitle @"有洗车订单正在进行..."
//提示拨打客服电话
#define tipmessage @"拨打客服电话"
//提示定位服务
#define tiplocation @"定位服务被关闭"
//提示视图x偏移
#define orderTipViewX 20.f
//提示视图的高度
#define orderTipViewH 44.f
//按钮宽度
#define callh SCREEN_WIDTH-2*callX

#define orderStatusQueryReqTag 100 // 查看订单状态tag

/***
 *
 *@description:主页面对应的控制器--实现
 *@author:liys
 *@since:2014-1-6
 *@corp:cheletong
 */
@interface MainController ()
<BMKLocationServiceDelegate,
 BMKGeoCodeSearchDelegate,
 TapImageViewWidgetDelegate>
{
    UIButton* _callBtn;
    NSString* _addressStr; // 地址信息
    UIImageView* _ringImageView; // 游泳圈
    dispatch_queue_t _queue; // 任务队列
}
@end

@implementation MainController

#pragma mark 存放地址和流程演示按钮的头部视图
@synthesize headView;

#pragma mark 中间视图
@synthesize centerView;

#pragma mark 有订单的提示视图
@synthesize orderTipView;

#pragma mark 生命周期方法--viewDidLoad
- (void)viewDidLoad {
    
    //1.调用父类的viewDidLoad方法
    [super viewDidLoad];
    
    //2.初始化UI主件
    [self drawUIView];
    
    //3.初始化定位服务
    [self initBDMapLocService];
    
    //4.注册通知
    [self registerNofications];
}

#pragma mark 生命周期方法--viewWillAppear
-(void)viewWillAppear:(BOOL)animated
{
    //1.调用父类的方法
    [super viewWillAppear:animated];
    
    //2.设置代理
    _locService.delegate = self;
    _geoCodeSearch.delegate = self;
    
    //3.检查订单状态
    [self checkoutOrder];
}

#pragma mark 生命周期方法--viewWillDisappear
-(void)viewWillDisappear:(BOOL)animated
{
    //1.调用父类的方法
    [super viewWillDisappear:animated];
    
    //2.释放内存
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;

}

#pragma mark  检查当前用户是否有订单
- (void) checkoutOrder
{
    // 发送网络请求
    NSDictionary *loginUser = [CommonUtils loginUser];
    if (loginUser)
    {
        NSString *mobileno = [loginUser objectForKey:@"userAccount"];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:mobileno,@"userPhone", nil];
        [self doPost:orderStatusGetUrl params:params tag:orderStatusQueryReqTag showProgress:NO];
    }
    else
    {
        // 定位
        [self beginLocate];
    }
    APP_DebugLog(@"checkoutOrder");
}

#pragma mark 请求成功后回调该函数
-(void) handleRespResult:(NSDictionary*)result tag:(int)reqTag
{
    APP_DebugLog(@"result - %@",result);
    [super handleRespResult:result tag:reqTag];
    switch (reqTag) {
        case orderStatusQueryReqTag:
        {
            if (result && result.count > 0)
            {
                NSDictionary* orderInfoDic = [result objectForKey:@"orderInfo"] ;
                APP_DebugLog(@"orderInfoDic - %@",orderInfoDic);
                
                if (!orderInfoDic)
                {
                    // 没有订单
                    [self beginLocate];
                    [self removeOrderTipView];
                }
                else
                {
                    // 有订单
                    [self showOrderTipView];
                    _addresslb.text = [orderInfoDic objectForKey:@"address"];
                }
            }
            else
            {
                [self removeOrderTipView];
            }
            break;
        }
        default:
            break;
    }
}

- (BOOL)handleErrorCode:(int)code info:(NSString *)info tag:(int)reqTag
{
    switch (reqTag) {
        case orderStatusQueryReqTag:
        {
            return NO;
            break;
        }
        default:
            return NO;
            break;
    }
    return [super handleErrorCode:code info:info tag:reqTag];
}

#pragma mark 请求失败回调
- (void)reqErrorHandle:(int)errorCode errormsg:(NSString *)message tag:(int)reqTag
{
    [super reqErrorHandle:errorCode errormsg:message tag:reqTag];
    
    // 定位
    [self beginLocate];
    // 删除订单view
    [self removeOrderTipView];
}

#pragma mark 初始化百度地图定位的service
-(void)initBDMapLocService
{
    _locService = [[BMKLocationService alloc]init];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
}

#pragma mark 设置控制器的背景颜色
-(void)setControllerBgColor
{

    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"indexBgImg"];
    bgImageView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgImageView];
}


#pragma mark 初始化UI主件
- (void) drawUIView
{
    //1.顶部view
    [self.view addSubview:self.headView];
    
    //2.跑男图标
    [self.view addSubview:self.centerView];
}

//--------------有订单的提示视图区域----------------//
#pragma mark 更新提示视图的状态
-(void)updateOrderTipViewStatus:(NSNotification*)notification
{
    // 检查订单状态
    [self checkoutOrder];
}

#pragma mark - 展示订单状态view
- (void) showOrderTipView
{
    [self.orderTipView.layer removeAllAnimations];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.fromValue = @(0.0);
    scaleAnimation.toValue = @(1.0);
    scaleAnimation.duration = 0.35f;
    scaleAnimation.removedOnCompletion = YES;
    [self.orderTipView.layer addAnimation:scaleAnimation forKey:@"scale_animation_show"];
    [self.view addSubview:self.orderTipView];
}

#pragma mark - 删除订单状态view
- (void) removeOrderTipView
{
    [self.orderTipView removeFromSuperview];
    _orderTipView = nil;
}

#pragma mark 有订单的提示视图
-(UIView*)orderTipView
{
    if (!_orderTipView)
    {
        CGFloat orderTipX = (SCREEN_WIDTH-271)/2;
        CGFloat orderTipY = 95;
        CGFloat orderTipW = 271;
        CGFloat orderTipH = 49;
        CGRect  orderTipFrame = Rect(orderTipX, orderTipY, orderTipW, orderTipH);
        _orderTipView = [[CustBgViewWidget alloc]initWithFrame:orderTipFrame
                                                 shadowOpacity:0.2
                                                   shadowColor:0x0d0408
                                                   //shadowColor:0x777777
                                                  shadowRadius:1.f
                                                       bgColor:0xffffff
                                                  bgColorAlpha:1
                                                  cornerRadius:0.4f
                                                 shadowYOffset:1.f
                                                 shadowXOffset:0.f];
        _orderTiplb = [[UILabel alloc]initWithFrame:_orderTipView.bounds];
        _orderTiplb.font = FONT_TextSize_S3;
        _orderTiplb.textColor = hexColor(0xffffff, 1);
        _orderTiplb.backgroundColor = hexColor(0xe7a235, 1);
        _orderTiplb.numberOfLines = 1;
        _orderTiplb.lineBreakMode = NSLineBreakByWordWrapping;
        _orderTiplb.textAlignment = NSTextAlignmentCenter;
        _orderTiplb.text = orderTipInfoTitle;
        UITapGestureRecognizer *orderViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
        
                                                                                             action:@selector(orderTipViewTap:)];
        [_orderTipView addGestureRecognizer:orderViewTapGesture];
        [_orderTipView addSubview:_orderTiplb];
    }
    return _orderTipView;
}

#pragma mark 手势
-(void)orderTipViewTap:(UITapGestureRecognizer*)tapGesture
{
//    [WashcarDefaultCenter postNotificationName:WashcarTipViewUpdateNotification object:nil];
    PayDetailController* vc = [[PayDetailController alloc] init];
    [self pushViewControllerFromRight:vc];
}

#pragma mark 注册监听
-(void)registerNofications
{
    [WashcarDefaultCenter addObserver:self
                             selector:@selector(updateOrderTipViewStatus:)
                                 name:WashcarTipViewUpdateNotification
                               object:nil];
}

#pragma mark 移除通知
-(void)removeNofications
{
    [WashcarDefaultCenter removeObserver:self name:WashcarTipViewUpdateNotification object:nil];
}


//--------------------中间区域------------------------//
#pragma mark 中间视图--包括logo,跑男按钮,红包按钮
-(UIView*)centerView
{
    if (!_centerView)
    {
        //中间视图
        CGFloat centerX = 0.f;
        CGFloat centerY = CGRectGetMaxY(_headView.frame);
        CGFloat centerW = SCREEN_WIDTH;
        CGFloat centerH = SCREEN_HEIGHT - centerY;
        CGRect  centerFrame = (CGRect){centerX,centerY,centerW,centerH};
        _centerView = [[UIView alloc]initWithFrame:centerFrame];
        [self.view addSubview:_centerView];
         //呼叫跑男按钮
        CGFloat imageX = 0.375 * ScreenWidth;
        CGFloat imageY = 0.354 * ScreenHeight;
        CGFloat imageH = 80;
        CGFloat imageW = 80;
        UIImage *image = [UIImage imageNamed:@"Ring.png"];
        _ringImageView = [[UIImageView alloc] initWithImage:image];
        _ringImageView.frame = CGRectMake(imageX,imageY, imageW, imageH);
        [_centerView addSubview:_ringImageView];
        
        UIImageView* shadowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ringShadow.png"]];
        shadowImgView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        [_centerView addSubview:shadowImgView];
        
        CGFloat callX = 0.3125 * ScreenWidth;
        CGFloat callY = CGRectGetMaxY(_ringImageView.frame) + 30 * ScreenHeight / 480;
        CGFloat callH = 120;
        CGFloat callW = 120;
        _callBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _callBtn.frame = CGRectMake(callX, callY, callW, callH);
        _callBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_callBtn setTitleColor:RGB_TextColor_C12 forState:UIControlStateNormal];
        _callBtn.backgroundColor=[UIColor clearColor];
        [_callBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
        [_callBtn addTarget:self action:@selector(callBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_callBtn addTarget:self action:@selector(callBtnPresson:) forControlEvents:UIControlEventTouchDown];
        [_callBtn addTarget:self action:@selector(callBtnCancle:) forControlEvents:UIControlEventTouchUpOutside];
        [_centerView addSubview:_callBtn];
    }
    return _centerView;
}

#pragma mark - 暂停动画效果
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

#pragma mark - 开始动画效果
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

#pragma mark - 松开按钮
- (void) callBtnCancle:(UIButton*) sender
{
    APP_DebugLog(@"press cancle");
    [self pauseLayer:_ringImageView.layer];
}

- (void) callBtnPresson:(UIButton*) sender
{
    APP_DebugLog(@"press on");
    if (![_ringImageView.layer animationForKey:@"rotation"])
    {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = @(0.0);
        rotationAnimation.toValue = @(M_PI);
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1e100;
        [_ringImageView.layer addAnimation:rotationAnimation forKey:@"rotation"];
    }
    [self resumeLayer:_ringImageView.layer];
}

#pragma mark 呼叫跑男按钮被点击
-(void)callBtnClicked:(UIButton*)sender
{
//    OrderDao *orderDao = [[OrderDao alloc] init];
//    [orderDao deleteAllOrder];
//    OrderDaoModel *order = [[OrderDaoModel alloc]init];
//    order.orderNo = @"12345678";
//    order.orderTime = [DateUtils nowForString];
//    order.receivedTime = [DateUtils nowForString];
//    order.arrivalTime = [DateUtils nowForString];
//    order.washingTime = [DateUtils nowForString];
//    order.finishedTime = [DateUtils nowForString];
//    order.mobile = @"13606603642";
//    order.carNumber = @"浙a123456";
//    order.carPosition = @"浙江省杭州市";
//    order.payway = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:WashCarOrderPayway_Reward]];
//    AfterViewController*after=[[AfterViewController alloc]init];
//    [self pushViewControllerFromBottom:after];
//    [self pushViewControllerFromBottom:payView];
//    PayDetailController *payView = [[PayDetailController alloc]init];
    [self callBtnCancle:nil];
    [_ringImageView.layer removeAllAnimations];
    if (_orderTipView)
    {
        [self showOrderTipView];
        return;
    }
    PayIndexController *payIndexController = [[PayIndexController alloc]init];
    [self pushViewControllerFromRight:payIndexController];
}

//----------------头部视图区域-------------------//
#pragma mark 头部按钮
-(UIView *)headView
{
    if (!_headView)
    {
        //1.头部背景视图
        CGRect headViewFrame = Rect(0.f, 0.f, SCREEN_WIDTH, TOP_BLANNER_HEIGHT + SCREEN_HEIGHT_START);
        _headView = [[UIView alloc]initWithFrame:headViewFrame];
        _headView.backgroundColor = [UIColor clearColor];
        
        //3.定位图标
        CGFloat mapIconX = mapIconXPadding;
        CGFloat mapIconY = SCREEN_HEIGHT_START + (TOP_BLANNER_HEIGHT- mapIconH)/2;
        CGRect  mapIconFrame = (CGRect){mapIconX,mapIconY,mapIconW,mapIconH};
        UIImageView *mapIcon = [[UIImageView alloc]initWithFrame:mapIconFrame];
        mapIcon.image = [UIImage imageNamed:@"MainLocation.png"];
        mapIcon.contentMode = UIViewContentModeScaleAspectFit;
        [_headView addSubview:mapIcon];
        
        //4.定位label
        CGFloat addressX = CGRectGetMaxX(mapIcon.frame) + 15.f;
        CGFloat addressY = SCREEN_HEIGHT_START;
        CGFloat addressH = TOP_BLANNER_HEIGHT;
        CGRect  addressFrame = (CGRect){addressX,addressY,addressW,addressH};
        _addresslb = [[UILabel alloc] initWithFrame:addressFrame];
        _addresslb.backgroundColor = [UIColor clearColor];
        _addresslb.text = locatingTitle;
        _addresslb.lineBreakMode = NSLineBreakByTruncatingTail;
        _addresslb.numberOfLines = 2;
        _addresslb.textColor = RGB_TextColor_C0;
        _addresslb.font = FONT_TextSize_S0;
//        _addresslb.userInteractionEnabled = YES;
//        UITapGestureRecognizer *locateRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
//                                                                                          action:@selector(locateRecognizerTaped:)];
//        [_addresslb addGestureRecognizer:locateRecognizer];
        [_headView addSubview:_addresslb];
        
        //5.分割线
        CGFloat lineX = CGRectGetWidth(_headView.frame) - 82.f;
        CGFloat lineY = SCREEN_HEIGHT_START;
        CGFloat lineW = seperatorLineW;
        CGFloat lineH = TOP_BLANNER_HEIGHT;
        CGRect  lineFrame = Rect(lineX, lineY, lineW, lineH);
        UIImageView *separatorLine = [[UIImageView alloc]initWithFrame:lineFrame];
        separatorLine.image = [UIImage imageNamed:@"seperatorLine"];
        separatorLine.contentMode = UIViewContentModeScaleAspectFit;
        separatorLine.backgroundColor = [UIColor clearColor];
        //[_headView addSubview:separatorLine];
        
        //6.客服按钮区域
        CGFloat callBtnViewW = 82.f;
        CGFloat callBtnViewH = TOP_BLANNER_HEIGHT;
        CGFloat callBtnViewX = CGRectGetMaxX(separatorLine.frame);
        CGFloat callBtnViewY = SCREEN_HEIGHT_START;
        CGRect  callBtnViewFrame = Rect(callBtnViewX, callBtnViewY, callBtnViewW, callBtnViewH);
        UIButton *callBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        callBtnView.backgroundColor = [UIColor clearColor];
        callBtnView.frame = callBtnViewFrame;
        [callBtnView addTarget:self action:@selector(callServiceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:callBtnView];
        
        //7.客服按钮
        _callServiceBtn = [[TapImageViewWidget alloc]initWithImage:[UIImage imageNamed:@"MainCall.png"]];
        CGFloat callBtnW = 25.f;
        CGFloat callBtnH = 44.f;
        CGFloat callBtnX = (CGRectGetWidth(callBtnView.frame) - callBtnW)/2;
        CGFloat callBtnY = (CGRectGetHeight(callBtnView.frame) - callBtnH)/2;
        CGRect  callBtnFrame = Rect(callBtnX, callBtnY, callBtnW, callBtnH);
        _callServiceBtn.frame = callBtnFrame;
        _callServiceBtn.delegate = self;
        _callServiceBtn.backgroundColor = [UIColor clearColor];
        _callServiceBtn.contentMode = UIViewContentModeScaleAspectFit;
        [callBtnView addSubview:_callServiceBtn];
    }
    return _headView;
}

#pragma mark
-(void)locateRecognizerTaped:(UITapGestureRecognizer*)gesture
{
    _addresslb.text = locatingTitle;
    [self beginLocate];
}

#pragma mark 客服电话按钮被点击的事件
-(void)callServiceBtnClicked:(UIButton*)btn
{
    [self contactService];
}

#pragma mark 联系客服
-(void)contactService
{
    [ApplicationDelegate showAlertWithTowBtns:nil message:tipmessage doneBtnFinishBlock:^()
     {
         [CommonUtils openUrl:WashCarServiceTelNum urltype:TELURL];
     }];
    
}

#pragma mark 开始定位
-(void)beginLocate
{
    if ([self locationServicesIsOpen])
    {
        [_locService startUserLocationService];
    }
    else
    {
        _addresslb.text = tiplocation;
    }
}

#pragma mark 停止定位
-(void)stopLocate
{
    [_locService stopUserLocationService];
    
}

#pragma mark BMKLocationServiceDelegate代理方法
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (userLocation != nil)
    {
        //创建反地理编码
        BMKReverseGeoCodeOption* reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
        reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
        
        //开始反地理编码
        [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];

        //停止定位
        [self stopLocate];
    }
    else
    {
        [self stopLocate];
         _addresslb.text = locateFailTitle;
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    _addresslb.text = locateFailTitle;
    [self stopLocate];
}


#pragma mark - BMKGeoCodeSearchDelegate代理方法
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (!error)
    {
        _addresslb.text = result.address;
    }
    else
    {
        _addresslb.text = locateFailTitle;
    }
}

#pragma mark TapImageViewWidgetDelegate代理方法
-(void)imageTap:(id)sender imageView:(UIImageView*)imageView
{
    if (imageView == _callServiceBtn)
    {
        [self contactService];
    }
    
}

//-------------其他---------------------//
#pragma 收到内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 自定义导航栏
-(BaseNaviBarWidget *)navBar
{
    return nil;
}

#pragma mark 移除对应的对象
-(void)dealloc
{
    //1.头部视图
    _headView = nil;
    _addresslb = nil;  //地址
    _callServiceBtn = nil;  //联系客服按钮
    
    //2.中间
    _runManImgView = nil; //跑男图
    _callRunManBtn = nil; //呼叫跑男
    _centerView = nil;//中间视图
    
    //3.有订单的提示视图
    _orderTipView = nil;
    _orderTiplb = nil;
    
    //4.地图定位service
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    _locService = nil;
    _geoCodeSearch = nil;
    
    //5.移除通知
    [self removeNofications];
    
    //6.打印日志
    APP_DebugLog(@"%@ dealloc method was invoked",NSStringFromClass([self class]));
}


@end
