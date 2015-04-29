//
//  PhoneController.m
//  WashCar
//
//  Created by yangyixian on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//  订单手机验证页面

#define sureBtnX                30
#define sureBtnY                SCREEN_HEIGHT - 150
#define sureBtnW                SCREEN_WIDTH - 30*2
#define commonH                 44//默认高度
#define commonX                 30//默认距离


#import "PhoneController.h"
#import "TapImageViewWidget.h"
#import "PayIndexController.h"


@interface PhoneController ()<TapImageViewWidgetDelegate>
{
    UITextField *_phonetextField;
    UITextField *_codeField;
    UIButton *_getCodeBtn;
}
@property(nonatomic,copy)NSString *phoneNumber;//电话号码
@property(nonatomic,copy)NSString *codeDemo;//验证码

@end

@implementation PhoneController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    //1.搭建UI
    [self setupUI];
    //2.数据处理
    [self prepareData];
}

#pragma mark -- 
-(void)setupUI
{
    //
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, 300, 30)];
    lable1.text = @"跑男通过手机联系你噢";
    lable1.textColor = [UIColor blackColor];
    [self.view addSubview:lable1];
    
    //手机号
    CGFloat phoneLableX =20 ;
    CGFloat phoneLableY = 150;
    CGFloat phoneLableW = 60;
    CGFloat phoneLableH = 30;
    UILabel *phoneLable = [[UILabel alloc]initWithFrame:CGRectMake(phoneLableX,phoneLableY, phoneLableW, phoneLableH)];
    phoneLable.text = @"手机号";
    phoneLable.textColor = [UIColor lightGrayColor];
    [self.view addSubview:phoneLable];
    
    //输入手机号textfield
    CGFloat _phonetextFieldX =80;
    CGFloat _phonetextFieldY =150;
    CGFloat _phonetextFieldW = SCREEN_WIDTH - 164;
    CGFloat _phonetextFieldH = 30;
    _phonetextField = [[UITextField alloc]initWithFrame:CGRectMake(_phonetextFieldX, _phonetextFieldY,_phonetextFieldW,_phonetextFieldH )];
    _phonetextField.layer.borderWidth = 1;
    _phonetextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_phonetextField];
    _phonetextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeField.returnKeyType = UIReturnKeyGo;
    _phoneNumber = _phonetextField.text;
    
    //获取验证码btn
    CGFloat btnX =SCREEN_WIDTH - 84 ;
    CGFloat btnY = 150;
    CGFloat btnW = 64;
    CGFloat btnH = 30;
    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _getCodeBtn.frame = CGRectMake(btnX,btnY,btnW,btnH);
    _getCodeBtn.backgroundColor = [UIColor lightGrayColor];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateNormal];
    [self.view addSubview:_getCodeBtn];
    [_getCodeBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    
    //验证码lable
    CGFloat codeLableX =20 ;
    CGFloat codeLableY = 200;
    CGFloat codeLableW = 60;
    CGFloat codeLableH = 30;
    UILabel *codeLable = [[UILabel alloc]initWithFrame:CGRectMake(codeLableX,codeLableY, codeLableW,codeLableH)];
    codeLable.text = @"验证码";
    codeLable.textColor = [UIColor lightGrayColor];
    [self.view addSubview:codeLable];
    
    //输入验证码textField
    CGFloat _codeFieldX =80 ;
    CGFloat _codeFieldY =200;
    CGFloat _codeFieldW =SCREEN_WIDTH - 100;
    CGFloat _codeFieldH = 30;
    _codeField = [[UITextField alloc]initWithFrame:CGRectMake(_codeFieldX,_codeFieldY ,_codeFieldW, _codeFieldH)];
    [self.view addSubview:_codeField];
    _codeField.layer.borderWidth = 1;
    _codeField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _codeDemo = _codeField.text;
    _codeField.keyboardType = UIKeyboardTypeNumberPad;
    _codeField.returnKeyType = UIReturnKeyDone;
    
    //确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureBtn.frame = CGRectMake(sureBtnX, sureBtnY, sureBtnW, commonH);
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateHighlighted];
    [sureBtn setTitle:@"确定" forState:UIControlStateSelected];
    [sureBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateHighlighted];
    [sureBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateSelected];
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //说明的两个lable和两个button
    CGFloat desLableX =30 ;
    CGFloat desLableY = SCREEN_HEIGHT - 80;
    CGFloat desLableW = SCREEN_WIDTH - 60;
    CGFloat desLableH = 20;
    UILabel *desLable = [[UILabel alloc]initWithFrame:CGRectMake(desLableX, desLableY,desLableW , desLableH)];
    desLable.text = @"注册表示同意车乐通的隐私条款和服务条款";
    desLable.text = @"注册表示同意车乐通的________和________";

    desLable.textColor = [UIColor lightGrayColor];
    desLable.font = [UIFont systemFontOfSize:13];
    desLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:desLable];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =CGRectMake(commonX +80+50+2,desLableY-1,60, desLableH);
    //btn1.backgroundColor = [UIColor whiteColor];
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn1 setTitle:@"隐私政策" forState:UIControlStateNormal];
    [btn1 setTitle:@"隐私政策" forState:UIControlStateHighlighted];
    [btn1 setTitle:@"隐私政策" forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(commonX +160 +40, desLableY-1,60, desLableH);
   // btn2.backgroundColor = [UIColor whiteColor];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitle:@"服务条款" forState:UIControlStateNormal];
    [btn2 setTitle:@"服务条款" forState:UIControlStateHighlighted];
    [btn2 setTitle:@"服务条款" forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn2];
}

-(void)prepareData
{
    
}

//获取验证码点击事件 用 GCD实现倒计时
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                APP_Log(@"____%@",strTime);
                [_getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
                _getCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
    APP_Log(@"1111111");
    
}

//确定按钮点击事件
-(void)sureBtnAction:(UIButton *)sender
{
    [self popViewControllerFromTop];
}

//键盘处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

//block传值 //停止倒计时
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.blocks(_phonetextField.text);
    
    
}



#pragma 导航栏设置
-(BaseNaviBarWidget*)navBar{
    NavBarViewWidget *navBar = [[NavBarViewWidget alloc]init];
    navBar.centerTitle = @"输入手机号";
    navBar.leftIcon = [UIImage imageNamed:@"back"];
    navBar.leftTitle = @"返回";
    navBar.delegate = self;
    return navBar;
}
#pragma NavBarViewWidgetDelegate method
-(void)leftNavBarBtnClicked:(UIButton *)leftNavBarBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)needAddPanGesture
{
    return YES;
}
@end
