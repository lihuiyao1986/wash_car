//
//  PayIndexController.m
//  Washcar
//
//  Created by yanshengli on 14-12-25.
//  支付首页
//
#import "PayIndexController.h"

#import "LoginController.h"
#import "CustBgViewWidget.h"
#import "LocationViewController.h"
#import "PaySelectBtnItem.h"
#import "CarAreaKeybordWidget.h"
#import "LineViewWidget.h"
#import "NSString+Utility.h"
#import "PayIndexModel.h"
#import "AFViewShaker.h"
#import "CustomTextField.h"
#import "PayDetailController.h"
#import "OrderDao.h"
//#import "PayWayController.h"


#define commomX  (SCREEN_WIDTH -300)/2//默认到屏幕边框距离
#define commomH   39//默认间隙
#define lableX  10//默认lable到屏幕边框距离
#define infoLableX  81//信息lable到父视图左边框距离
#define lableY 0//默认lable到背景边框距离
#define lableW  71//默认lable的宽度
#define lableH  30//默认lable高度

#define phoneViewH  70//手机号所在View高度
#define carmsgViewH 113//爱车信息View高度
#define payViewH 44 // 支付View高度
#define btnViewH 60 // 底部按钮背景View高度

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz"//允许输入车牌号键盘输入的内容
#define doCommitOrderTag 300   //登录请求对应的tag
#define phoneBtnTag  101       //输入手机号请求请求对应的tag
#define carAreaBtnTag  201     //选择车牌省份地区对应的tag
#define carAlphaBtnTag  202    //选择车牌省份地区缩写字母对应的tag
#define sectionBtnTag  203     //选择停车位置请求对应的tag
#define payBtnTag  301         //提交订单请求对应的tag
#define payIndexNavCenterTitle  @"上门洗车"                //下单页面，导航栏标题
#define payIndexLocationFail  @"获取地址失败"              //下单页面，停车位位置定位失败后，停车位置文本框显示的文字
#define payIndexLocationWarning @"亲，请选择停车位置" //下单页面，停车位置定位失败后，点击提交订单后提示
#define payIndexCarNumWarning  @"请输入正确的车牌号"        //下单页面车牌号错误 弹框提示文字
#define defaultCarArea  @"浙" //输入车牌号键盘 初始值
#define defaultCarAlpha  @"A" //输入车牌号键盘 初始值
#define phoneNumPlaceholder @"点击输入手机号"               //下单页面 输入手机号提示文字
#define carNumPlaceholder @"输入车牌号"                    //下单页面 输入手车牌号提示文字
#define carLocationPlaceholder @"请输入停车位置"            //下单页面 输入停车位置提示文字
#define payWayPlaceholder @"请选择支付方式"                 //下单页面 选择支付方式提示文字
#define stratWashTitle @"马上洗车"                         //下单页面 提交订单按钮标题



@interface PayIndexController ()
<CarAreaKeybordWidgetDelegate,
UITextFieldDelegate,
UIScrollViewDelegate,
BMKLocationServiceDelegate,
BMKGeoCodeSearchDelegate,
UIActionSheetDelegate>
{
    UITextField *_phoneNumbertf;//电话号码
    UITextField *_carPositiontf;//停车位置
    UITextField *_carInfotf;//车牌号输入文本框
    UITextField *_payStyletf;//支付方式
    PaySelectBtnItem *_carBtn;//车牌选择按钮1
    PaySelectBtnItem *_carBtn2;//车牌选择按钮2
    UIButton *_startBtn;//提交订单

    NSString *_carArea;//车牌地区
    NSString *_carAlpha;//车牌字母
    NSString *_carNum;//车牌号码
    CLLocationCoordinate2D _carLocation;//车辆经纬度
    
    //地图定位service
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoCodeSearch;

}
@property(nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) PayIndexModel *order_model;
@end
@implementation PayIndexController
-(void)dealloc
{
    _locService = nil;
    _geoCodeSearch =nil;
    [self removeNofications];
}
#pragma mark 生命周期方法- viewDidLoad
-(void)viewDidLoad
{
    [super viewDidLoad];
    //1.数据处理
    [self prepareData];
    //2搭建UI
    [self setUPView];
    //3.注册提交订单按钮通知
    [self setUPNofications];
    //4.初始化定位服务
    [self setUPBDMapLocService];
}

#pragma mark 生命周期方法- viewWillAppear
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //1.发送通知
    [self postNotifications];
    //2.设置代理
  
    //3.开始定位//如果订单已经有位置了，就不需要定位了
    if ([CommonUtils isStrEmpty:_carPositiontf.text]) {
        _locService.delegate = self;
        _geoCodeSearch.delegate = self;
        
        [self beginLocate];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //.释放内存
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    
    [self stopLocate];
}

#pragma mark ----------------通知处理--------------
-(void)setUPNofications
{
    //1.添加监听器
    [self registerNofications];
}
#pragma mark 添加监听器
-(void)registerNofications
{
    [WashcarDefaultCenter addObserver:self selector:@selector(updatestarBtnStatus:)name:updateStarBtnStatusNotification object:nil];
}
#pragma mark 发送通知
-(void)postNotifications
{
    [WashcarDefaultCenter postNotificationName:updateStarBtnStatusNotification object:nil];
}

#pragma mark 移除通知
-(void)removeNofications
{
    [WashcarDefaultCenter removeObserver:self name:updateStarBtnStatusNotification object:nil];
    [WashcarDefaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    APP_DebugLog(@"通知移除了");
}

#pragma mark 更新确认按钮状态的通知
-(void)updatestarBtnStatus:(NSNotification *)notification
{
    //手机号
    NSString *phone1 = _phoneNumbertf.text;
    //车牌信息
    _carNum = _carInfotf.text;
    //停车位置
    NSString *carPlace  = _carPositiontf.text;
    //提交订单按钮的状态
    _startBtn.enabled =![CommonUtils isStrEmpty:_carNum] && ![CommonUtils isStrEmpty:phone1] && ![CommonUtils isStrEmpty:carPlace] ;
    APP_DebugLog(@">>>>>>更新提交订单按钮状态中查看-手机号-停车位置-车牌-%@ %@ %@",_phoneNumbertf.text,carPlace,_carNum);
}

#pragma mark --------------搭建UI-------------------
-(void)setUPView
{
    //滚动视图背景
    CGFloat mainScrollViewX = 0.f;
    CGFloat mainScrollViewY = TOP_BLANNER_HEIGHT + SCREEN_HEIGHT_START;
    CGFloat mainScrollViewW = SCREEN_WIDTH;
    CGFloat mainScrollViewH = SCREEN_HEIGHT - mainScrollViewY - btnViewH;
    CGRect  mainScrollViewFrame = Rect(mainScrollViewX, mainScrollViewY, mainScrollViewW, mainScrollViewH);
    _mainScrollView = [[UIScrollView alloc]initWithFrame:mainScrollViewFrame];
    _mainScrollView.backgroundColor = RGB_TextColor_C3;
    _mainScrollView.contentSize = CGSizeMake(mainScrollViewW, mainScrollViewH + 40.f);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    /*
     1.0联系方式下面白色View
    */
    CGFloat phoneViewX = commomX;
    CGFloat phoneViewY = commomH;
    CGFloat phoneViewW = 300;
    CustBgViewWidget *phoneView = [[CustBgViewWidget alloc]initWithFrame:CGRectMake(phoneViewX, phoneViewY, phoneViewW, phoneViewH)];
    [self.mainScrollView addSubview:phoneView];
    phoneView.backgroundColor = [UIColor whiteColor];
    //1.1联系方式
    CGFloat lable1X = phoneViewX;
    CGFloat lable1Y = 19;
    CGFloat lable1W = 300;
    CGFloat lable1H = 13;
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(lable1X,lable1Y,lable1W,lable1H)];
    lable1.text = @"联系方式";
    lable1.textColor =RGB_TextColor_C8;
    lable1.font =FONT_TextSize_S5;
    lable1.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:lable1];

    //1.2手机号
    UILabel *phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(lableX,lableY,lableW,44)];
    phoneLb.text = @"手机号";
    phoneLb.textColor = RGB_TextColor_C12;
    phoneLb.font = FONT_TextSize_S6;
    [phoneView addSubview:phoneLb];
    //1.3点击输入手机号
    _phoneNumbertf = [[UITextField alloc]initWithFrame:CGRectMake(infoLableX, lableY, phoneViewW - lableW  - 60, 44)];
    _phoneNumbertf.placeholder = phoneNumPlaceholder;
    _phoneNumbertf.text = _order_model.userPhone;
    _phoneNumbertf.font = FONT_TextSize_S2;
    _phoneNumbertf.textColor =RGB_TextColor_C11;
    _phoneNumbertf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //改变placeholder字体颜色
    [_phoneNumbertf setValue:RGB_TextColor_C8 forKeyPath:@"_placeholderLabel.textColor"];

    [phoneView addSubview:_phoneNumbertf];
    //1.4尾部小图片
    UIImageView *phoneImgv = [[UIImageView alloc]initWithFrame:CGRectMake(phoneViewW - 16.f,16.f,6.f, 12.f)];
    phoneImgv.image = [UIImage imageNamed:@"arrow_right_gray"];
    phoneImgv.contentMode = UIViewContentModeScaleAspectFill;
    [phoneView addSubview:phoneImgv];
    //1.5跑男通过手机号联系你文字
    CGFloat phoneMsgLbX  = lableX;
    CGFloat phoneMsgLbY  = phoneViewH - 25;
    CGFloat phoneMsgLbW  = SCREEN_WIDTH - 40;
    CGFloat phoneMsgLbH  = 25;
    UILabel *phoneMsgLb = [[UILabel alloc]initWithFrame:CGRectMake(phoneMsgLbX, phoneMsgLbY,phoneMsgLbW, phoneMsgLbH)];
    phoneMsgLb.text = @"跑男通过手机号联系你";
    phoneMsgLb.font = FONT_TextSize_S7;
    phoneMsgLb.textColor = RGB_TextColor_C8;
    [phoneView addSubview:phoneMsgLb];
    //1.6点击事件按钮
    CGFloat phoneBtnX  = lableW +lableX;
    CGFloat phoneBtnY = 0;
    CGFloat phoneBtnW  = phoneViewW - lableX- lableW;
    CGFloat phoneBtnH = 44;
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.frame = CGRectMake(phoneBtnX, phoneBtnY, phoneBtnW,phoneBtnH);
    [phoneView addSubview:phoneBtn];
    phoneBtn.tag = phoneBtnTag;
    [phoneBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     2.0  爱车信息下的白色View
     */
    CGFloat carmsgViewX  = commomX;
    CGFloat carmsgViewY =  commomH *2 +phoneViewH;
    CGFloat carmsgViewW = SCREEN_WIDTH - commomX*2;
    CustBgViewWidget *carmsgView = [[CustBgViewWidget alloc]initWithFrame:CGRectMake(carmsgViewX, carmsgViewY, carmsgViewW, carmsgViewH)];
    carmsgView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:carmsgView];

    //2.1爱车信息
    UILabel *lable2 =[[UILabel alloc]initWithFrame:CGRectMake(lable1X,carmsgViewY - lable1H - 7,lable1W,lable1H)];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.text = @"爱车信息";
    lable2.textColor =RGB_TextColor_C8;
    lable2.font =FONT_TextSize_S5;
    [self.mainScrollView addSubview:lable2];
    
    //2.2车牌号
    UILabel *carLb = [[UILabel alloc]initWithFrame:CGRectMake(lableX,lableY,lableW,44)];
    carLb.text = @"车牌号";
    carLb.textColor = RGB_TextColor_C12;
    carLb.font = FONT_TextSize_S6;
    [carmsgView addSubview:carLb];
    UILabel *carLb2 = [[UILabel alloc]initWithFrame:CGRectMake(lableX,carmsgViewH - 44,lableW,44)];
    carLb2.text = @"停车位置";
    carLb2.textColor = RGB_TextColor_C12;
    carLb2.font = FONT_TextSize_S6;
    [carmsgView addSubview:carLb2];
    
    //2.3选择车牌信息选择2个按钮和1个单行编辑文本框
    _carBtn = [PaySelectBtnItem buttonWithType:UIButtonTypeCustom];
    _carBtn.frame = CGRectMake(infoLableX, 0, 30, 44);
    _carBtn.tag = carAreaBtnTag;
    _carBtn.titleLabel.font = FONT_TextSize_S3_Bold;
    [_carBtn setTitle:_carArea forState:UIControlStateNormal];
    [_carBtn setImage:[UIImage imageNamed:@"arrow_down_blue"] forState:UIControlStateNormal];
    [_carBtn setImage:[UIImage imageNamed:@"arrow_down_blue"] forState:UIControlStateSelected];
    [_carBtn setTitleColor:RGB_TextColor_C11 forState:UIControlStateNormal];
    _carBtn2  = [PaySelectBtnItem buttonWithType:UIButtonTypeCustom];
    _carBtn2.frame = CGRectMake(137, 0, 26, 44);
    _carBtn2.tag = carAlphaBtnTag;
    _carBtn2.titleLabel.font = FONT_TextSize_S3_Bold;
    [_carBtn2 setTitleColor:RGB_TextColor_C11 forState:UIControlStateNormal];
    [_carBtn2 setTitle:_carAlpha forState:UIControlStateNormal];
    [_carBtn2 setImage:[UIImage imageNamed:@"arrow_down_blue"] forState:UIControlStateNormal];
    [_carBtn2 setImage:[UIImage imageNamed:@"arrow_down_blue"] forState:UIControlStateSelected];
    [_carBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_carBtn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //输入车牌号文本框
    _carInfotf = [[CustomTextField alloc]initWithFrame:CGRectMake(carmsgViewW - 110.f,0.f,110.f,44.f)];
    _carInfotf.placeholder = carNumPlaceholder;
    _carInfotf.font = FONT_TextSize_S4_Bold;
    _carInfotf.textColor =RGB_TextColor_C11;
    _carInfotf.text = _carNum;
    _carInfotf.keyboardType = UIKeyboardTypeASCIICapable;
    _carInfotf.returnKeyType = UIReturnKeyDone;
    _carInfotf.autocorrectionType = UITextAutocorrectionTypeYes;
    _carInfotf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _carInfotf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _carInfotf.delegate = self;
    
    // 添加textfield输入改变通知
    [WashcarDefaultCenter addObserver:self selector:@selector(tfChanged) name:UITextFieldTextDidChangeNotification object:_carInfotf];
    
    //设置文本框左边显示的view  永远显示
    _carInfotf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
    _carInfotf.leftViewMode = UITextFieldViewModeAlways;
    [carmsgView addSubview:_carBtn];
    [carmsgView addSubview:_carBtn2];
    [carmsgView addSubview:_carInfotf];
    
    //2.4请输入停车位置信息
    _carPositiontf = [[UITextField alloc]initWithFrame:CGRectMake(infoLableX, carmsgViewH - 44, phoneViewW - infoLableX - 16 , 44)];
    _carPositiontf.placeholder  = @"请输入停车位置";
    //改变placeholder字体颜色
    [_carPositiontf setValue:RGB_TextColor_C8 forKeyPath:@"_placeholderLabel.textColor"];
    //改变placeholder字体大小
    [_carPositiontf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carPositiontf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _carPositiontf.textColor = RGB_TextColor_C11;
    _carPositiontf.font = FONT_TextSize_S5;
    [carmsgView addSubview:_carPositiontf];
    //2.5跑男通过车牌号找到您的车辆
    UILabel *carMsgLb = [[UILabel alloc]initWithFrame:CGRectMake(phoneMsgLbX, phoneMsgLbY-2,phoneMsgLbW, phoneMsgLbH)];
    [carmsgView addSubview:carMsgLb];
    carMsgLb.text = @"跑男通过车牌号找到您的车辆";
    carMsgLb.font = FONT_TextSize_S7;
    carMsgLb.textColor =RGB_TextColor_C8;
    //2.6尾部小图标
    UIImageView *carImgv = [[UIImageView alloc]initWithFrame:CGRectMake(carmsgViewW - 16.f, carmsgViewH - 28.f,6.f, 12.f)];//CGRectMake(phoneViewW - 30, lableY, 30, 44)
    carImgv.image = [UIImage imageNamed:@"arrow_right_gray"];
    carImgv.contentMode = UIViewContentModeScaleAspectFill;
    [carmsgView addSubview:carImgv];
    
    //2.7 停车位置点击事件按钮
    UIButton *sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionBtn.frame = CGRectMake(0.f, carmsgViewH - 44.f, carmsgViewW,phoneBtnH);
    sectionBtn.tag = sectionBtnTag;
    [carmsgView addSubview:sectionBtn];
    [sectionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    

    //**//3.0付款服务
    CGFloat payViewX = commomX;
    CGFloat payViewY = carmsgViewH + phoneViewH +commomH *3;
    CGFloat payViewW = SCREEN_WIDTH - commomX*2;
    CustBgViewWidget *payView = [[CustBgViewWidget alloc]initWithFrame:CGRectMake(payViewX, payViewY, payViewW, payViewH)];
    payView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:payView];
    //3.0付款服务
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(lable1X,payViewY - lable1H - 7,lable1W,lable1H)];
    lable3.text = @"付款服务";
    lable3.textColor =RGB_TextColor_C8;
    lable3.font =FONT_TextSize_S5;
    lable3.backgroundColor = [UIColor clearColor];

    [self.mainScrollView addSubview:lable3];
    //3.1支付方式
    UILabel *payLb = [[UILabel alloc]initWithFrame:CGRectMake(lableX,lableY,lableW,44)];
    payLb.text = @"支付方式";
    payLb.textColor = RGB_TextColor_C12;
    payLb.font =FONT_TextSize_S6;
    [payView addSubview:payLb];
    _payStyletf = [[UITextField alloc]initWithFrame:CGRectMake(infoLableX, lableY, phoneViewW - lableW  - 60, 44)];
    _payStyletf.placeholder = payWayPlaceholder;
    _payStyletf.text = @"洗车券";
    [_payStyletf setValue:RGB_TextColor_C8 forKeyPath:@"_placeholderLabel.textColor"];
    [_payStyletf setValue: [UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _payStyletf.font = FONT_TextSize_S2;
    _payStyletf.textColor = RGB_TextColor_C11;
    _payStyletf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
 

//    _payStylelb.textColor = RGB_TextColor_C8;
    [payView addSubview:_payStyletf];
    //3.2尾部图标
    UIImageView *payImgv = [[UIImageView alloc]initWithFrame:CGRectMake(phoneViewW - 16.f,16.f,6.f, 12.f)];
    payImgv.image = [UIImage imageNamed:@"arrow_right_gray"];
    payImgv.contentMode = UIViewContentModeScaleAspectFill;
    [payView addSubview:payImgv];
    //3.3支付方式点击选择按钮
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(phoneBtnX, phoneBtnY, phoneBtnW,phoneBtnH);
    payBtn.tag = payBtnTag;
    [payView addSubview:payBtn];
    [payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    

    //4.0最底部视图背景
    CGFloat btnViewX = 0.f;
    CGFloat btnViewY = TOP_BLANNER_HEIGHT + SCREEN_HEIGHT_START + mainScrollViewH;
    CGFloat btnViewW = SCREEN_WIDTH;
    CGRect btnViewWframe = CGRectMake(btnViewX,btnViewY ,btnViewW , btnViewH);
    CustBgViewWidget *btnView = [[CustBgViewWidget alloc]initWithFrame:btnViewWframe
                                                          shadowOpacity:0.15f
                                                            shadowColor:0Xbbbbbb
                                                           shadowRadius:1.5f
                                                                bgColor:0xffffff
                                                           cornerRadius:0.f
                                                          shadowYOffset:-1.5f
                                                          shadowXOffset:0.f];
    [self.view addSubview:btnView];
    
    
    //4.1马上洗车按钮
    CGFloat startBtnX = (SCREEN_WIDTH - 250)/2;
    CGFloat startBtnY = 8.f;
    CGFloat startBtnW = 250.f;
    CGFloat startBtnH = 44.f;
    _startBtn = [CommonUtils washCarBtn:CGRectMake(startBtnX, startBtnY, startBtnW , startBtnH)];
    _startBtn.titleLabel.font = FONT_TextSize_S3_Bold;
    [_startBtn setTitle:@"马上洗车" forState:UIControlStateNormal];
    [_startBtn setTitle:@"马上洗车" forState:UIControlStateHighlighted];
    [_startBtn setTitle:@"马上洗车" forState:UIControlStateSelected];
    [_startBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:_startBtn];

    //添加页面中的三个分割线
    LineViewWidget *line1View = [[LineViewWidget alloc]initWithXoffset:10.f//到父视图的远点x方向的偏移量
                                                               yOffset:44.f//到父视图的远点y方向的偏移量
                                                            lineHeight:1.f//分割线高度
                                                             lineWidth:280.f//分割线宽度
                                                             lineColor:0xe3e2e2//分割线颜色
                                                             lineAlpha:0.5];//分割线透明度
    LineViewWidget *line2View = [[LineViewWidget alloc]initWithXoffset:189.f
                                                               yOffset:4.5f
                                                            lineHeight:37.f
                                                             lineWidth:1.f
                                                             lineColor:0xe3e2e2
                                                             lineAlpha:0.5];
    LineViewWidget *line3View = [[LineViewWidget alloc]initWithXoffset:10.f
                                                               yOffset: phoneMsgLbY +23
                                                            lineHeight:1.f
                                                             lineWidth:280.f
                                                             lineColor:0xe3e2e2
                                                             lineAlpha:0.5];
    [phoneView addSubview:line1View];
    [carmsgView addSubview:line2View];
    [carmsgView addSubview:line3View];
    
}

- (void)tfChanged
{
    _carInfotf.text = [_carInfotf.text uppercaseString];
    APP_DebugLog(@"text - %@",_carInfotf.text);
}
#pragma mark --------------数据处理-------------------
-(void)prepareData
{
    //1.读取账号
    [self readAccoun];
}

#pragma mark ---------- 读取数据 ---------------
-(void)readAccoun
{
    NSDictionary *loginUser1 = [CommonUtils loginUser];
    if (loginUser1) {
        _order_model = [PayIndexModel orderWithDict:loginUser1];
        _phoneNumbertf.text = _order_model.userPhone;
        NSString *carInfo =  _order_model.carPlateNum;
        _carArea =[carInfo substringToIndex:1];
        _carAlpha =[carInfo substringWithRange:NSMakeRange(1, 1)];
        _carNum = [carInfo substringFromIndex:2];
        
        APP_DebugLog( @"账号已经登录 读取的内容为---->>> loginUser1 %@",loginUser1);
    }
    
    if (_carAlpha == nil || _carArea == nil) {//给键盘付初始值
        _carArea = defaultCarArea;
        _carAlpha = defaultCarAlpha;
    }
    APP_DebugLog(@"--->>读取已登陆账号信息<<---%@  %@ %@ %@ 经度%f 纬度%f",_order_model.userPhone,_carArea,_carAlpha,_carNum,_carLocation.longitude,_carLocation.latitude);
}

#pragma mark --------- 订单的请求数据 -----------
-(void)saveAccoun
{
    NSString *carPlateNum = [NSString stringWithFormat:@"%@%@%@",_carArea,_carAlpha,_carNum] ;
    NSString *address = [_carPositiontf.text trimNull];
    NSString *carLongitude =[NSString stringWithFormat:@"%f",_carLocation.longitude];
    NSString *carLatitude =[NSString stringWithFormat:@"%f",_carLocation.latitude];
    
    address = [CommonUtils isStrEmpty:address] ? @"" : address;
    carPlateNum = [CommonUtils isStrEmpty:carPlateNum] ? @"" : carPlateNum;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            carPlateNum,@"carPlateNum",
                            address,@"address",
                            carLongitude,@"carLongitude",
                            carLatitude,@"carLatitude",
                            //carId,@"carId",
                            nil];
    [self doPost:placeOrderUrl params:params tag:doCommitOrderTag];
    APP_DebugLog(@"%@---%@---%@---%@--",carPlateNum,address,carLongitude,carLatitude);
    APP_DebugLog(@"--->>>>下单提交的订单为%@",params);
}

#pragma mark -------- 提交订单成功回调 ------------------
-(void) handleRespResult:(NSDictionary*)result tag:(int)reqTag
{
    [super handleRespResult:result tag:reqTag];
    if (reqTag == doCommitOrderTag)
    {
        APP_DebugLog( @"---->>>>>提交订单回调结果result%@",result);
        PayDetailController *payView = [[PayDetailController alloc]init];
        [self pushViewControllerFromRight:payView];
    }
}

- (NSString *)handleErrorMsg:(NSString *)message tag:(int)reqTag errorCode:(int)errorCode
{
    if (reqTag == doCommitOrderTag && errorCode == 9002002)
    {
        return @"当前用户存在订单";
    }
    return [super handleErrorMsg:message tag:reqTag errorCode:errorCode];
}

#pragma mark ---------输入手机号码，停车地点，车牌号 的 点击事件处理----------
-(void)btnAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case phoneBtnTag:{//手机号码选择按钮
            [self showPhoneInfo];
            break;
        }
        case carAreaBtnTag:{//省份键盘选择  -->弹出地区键盘
            [self showCarAreaKeyBorder];
            break;
        }
        case carAlphaBtnTag:{//城市键盘选择  -->弹出字母键盘
            [self showCarAlphaKeyBorder];
            break;
        }
        case sectionBtnTag:{//地图选择停车位置按钮
            [self showLocationInfo];
            break;
        }
        case payBtnTag:{//支付方式选择
            [self showActionSheet];
            break;
        }
        default:
            break;
    }
}
//手机号码选择按钮事件处理
-(void)showPhoneInfo
{
    [_carInfotf resignFirstResponder];
    LoginController *LC = [[LoginController alloc]init];
    [self pushViewControllerFromBottom:LC];
    __weak UITextField *phonetf = _phoneNumbertf;
    LC.mobileNo = _phoneNumbertf.text;
    LC.sucessCallBack = ^(NSString *mobileno,NSMutableDictionary *userinfo){
        phonetf.text = mobileno;
    };
}
//省份键盘选择  -->弹出地区键盘
-(void)showCarAreaKeyBorder
{
    [_carInfotf resignFirstResponder];
    __weak UIButton *carBtn = _carBtn;
    CarAreaKeybordWidget *areaKeyBorder = [[CarAreaKeybordWidget alloc]initWithType:CarAreaKeyBorderType_Area];
    areaKeyBorder.selectedBlock = ^(NSString *item){
        [carBtn setTitle:item forState:UIControlStateNormal];
        _carArea = item;
    };
    [areaKeyBorder show];
}
//城市键盘选择  -->弹出字母键盘
-(void)showCarAlphaKeyBorder
{
    [_carInfotf resignFirstResponder];
    CarAreaKeybordWidget *areaKeyBorder = [[CarAreaKeybordWidget alloc]initWithType:CarAreaKeyBorderType_Alpha];
    __weak UIButton *carBtn2 = _carBtn2;
    areaKeyBorder.selectedBlock = ^(NSString *item){
        [carBtn2 setTitle:item forState:UIControlStateNormal];
        _carAlpha = item;
    };
    [areaKeyBorder show];
}
//选择停车位置按钮 设定
-(void)showLocationInfo
{
    LocationViewController *LVC = [[LocationViewController alloc]init];
    [self pushViewControllerFromBottom:LVC];
    __weak UITextField *carPositionInfo = _carPositiontf;
    __weak PayIndexController *payVC = self;
    LVC.pageCallBack = ^(NSString* carLocationAddress,CLLocationCoordinate2D coordinate,NSDictionary* info){
        carPositionInfo.text = carLocationAddress;
        _carLocation = coordinate;
        [payVC postNotifications];
    };
}
//支付方式选择
-(void)showActionSheet
{
//    PayWayController *paywayVC = [[PayWayController alloc]init];
//    [self pushViewControllerFromBottom:paywayVC];
}

#pragma mark --------提交订单按钮的点击事件----------
-(void)commitBtnClicked:(UIButton *)sender
{
    if ([self carInfoRight] && [self carLocationRight])
    {
        //提交订单
        [self saveAccoun];
        APP_DebugLog(@"下单按钮被点击了");
    }
}

//检验车牌号是否合法
-(BOOL)carInfoRight
{
    if (![_carInfotf.text isValidCarNumber] || !(_carInfotf.text.length ==5)){
        [self showAlert:payIndexCarNumWarning type:AlertViewType_Toast];
        return NO;
    }
    return YES;
}
//判断定位是否是否成功方法
-(BOOL)carLocationRight
{
    NSString *carPlace = _carPositiontf.text;//停车位置
    if ([CommonUtils isStrEmpty:carPlace] ) {
        [self showAlert:payIndexLocationWarning type:AlertViewType_Toast];
        return NO;
    }
    return YES;
}

#pragma mark---------------------- 输入车牌号码键盘代理方法 ---------------------
// 车牌号码输入处理    只能输入5位数，只能是数字和字母
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //车牌号不能超过5位
    if ((textField == _carInfotf && range.location > 4) || (string.length + _carInfotf.text.length > 5))
    {
        return NO;
    }
    //判断只能输入大写字母和数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //键盘弹出方式自定义
    [self moveView:textField leaveView:NO];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //键盘消失的方式自定义
    [self moveView:textField leaveView:YES];
    _carNum = _carInfotf.text;
    [self postNotifications];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_carInfotf resignFirstResponder];
    [self moveView:_carInfotf leaveView:YES];
    return YES;
}

#pragma mark --------------------- 初始化百度地图定位的service -----------
-(void)setUPBDMapLocService
{
    _locService = [[BMKLocationService alloc]init];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
}

#pragma mark BMKLocationServiceDelegate代理方法
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (userLocation != nil){
        APP_DebugLog(@"定位成功 - %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        //创建反地理编码
        if (!userLocation.location.coordinate.latitude) {
            [self beginLocate];
            return;
        }
        
        BMKReverseGeoCodeOption* reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
        reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
        //
        _carLocation = userLocation.location.coordinate;
        
        //开始反地理编码
        [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption] ? APP_DebugLog(@"反地理编码成功") : APP_DebugLog(@"反地理编码失败");
        
        //停止定位
        [self stopLocate];
    }
    else{
        [self stopLocate];
        _carPositiontf.text = payIndexLocationFail;
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    _carPositiontf.text =payIndexLocationFail;
    [self stopLocate];
}

#pragma mark - BMKGeoCodeSearchDelegate代理方法
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (!error){
        _carPositiontf.text = result.address;
        [self postNotifications];
    }
    else{
        _carPositiontf.text = payIndexLocationFail;
    }
}

#pragma mark 开始定位
-(void)beginLocate
{
    if ([self locationServicesIsOpen]) {
        APP_DebugLog(@"开始定位");
        [_locService startUserLocationService];
    }
}

#pragma mark 停止定位
-(void)stopLocate
{
    [_locService stopUserLocationService];
}

#pragma mark ------- 获取导航栏信息 -----------
-(NavBarInfoModel*)navBarInfo{
    NavBarInfoModel *navBarInfo = [[NavBarInfoModel alloc]init];
    navBarInfo.navCenterTitle = payIndexNavCenterTitle;
    return navBarInfo;
}

-(BOOL)needAddPanGesture{
    return NO;
}
@end

