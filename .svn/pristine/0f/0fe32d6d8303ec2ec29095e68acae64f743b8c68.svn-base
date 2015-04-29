//
//  BaseWebviewControl.m
//  WashCar
//
//  Created by yanshengli on 14-12-20.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "BaseWebviewController.h"
#import "MobClick.h"
#import "LoginController.h"
#import "NSString+Utility.h"
#import "NSObject+Utility.h"
#import "NSObject+JSONCategories.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "ZYQAssetPickerController.h"
#import "PECropViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>

//模块
#define invokeMethodProtocal @"invokemethod"
#define redirectNativePgProtocal @"poptopage"

//跳转页面的类型
#define redirectToNativePageType @"native"
#define redirectToWebPageType @"web"

//请求成功之后对应的回调函数名
#define httpReqSuccJsFuncName @"httpSuccCallback"
#define httpReqFailJsFuncName @"httpFailCallback"

//弹框提示
#define cancelBtnText @"知道了..."
#define destructiveBtnTxt @"确定"

//获取照片actionSheet的tag值
#define avActionSheetTag 100000

//拖动手势 距离x方向上，左右，最大的起始偏移量和最终的位置的偏移量
#define panGestureLeftMaxXOffset 180.f
#define panGestureRightMaxXOffset 180.f
#define panGestureLeftMaxStartXOffset 30.f
#define panGestureRightMaxStartXOffset 30.f

//自动登录的tag
#define autoLoginReqTag 100000

@interface BaseWebviewController ()
<UIGestureRecognizerDelegate,
HttpRequestClientDelegate,
NavBarViewWidgetDelegate,
PECropViewControllerDelegate,
ZYQAssetPickerControllerDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UIWebViewDelegate>{
    CGPoint _startMovePoint;//起始移动点
    CGRect _orginFrame;//起始的frame
}
@end

@implementation BaseWebviewController
#pragma mark 属性
@synthesize showErrWithToast;
@synthesize webViewParams = _webViewParams;
@synthesize httpClient = _httpClient;
@synthesize webView = _webView;
@synthesize startPage;
@synthesize wwwFolderName;

//~~~~~~~~~~~~~处理页面生命周期相关的方法~~~~~~~~~~~~~~~~~~//
- (void)viewDidLoad
{
    
    //调用父类的viewDidLoad方法
    [super viewDidLoad];
    
    //默认是用alert方式提示错误
    self.showErrWithToast = NO;
    
    //存放页面的www文件夹
    self.wwwFolderName = @"www";
    
    //创建导航栏
    if([self navBar]){
        [self.view addSubview:[self navBar]];
    }
    
    //创建webView
    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];
    
    //添加tap手势
    if([self needAddTapGesture])
    {
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        singleFingerTap.delegate = self;
        [self.view addGestureRecognizer:singleFingerTap];
    }
    
    //添加pan手势
    if ([self needAddPanGesture])
    {
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        panRecognizer.delegate = self;
        [self.view addGestureRecognizer:panRecognizer];
    }
    
    //添加swipe手势
    if ([self needAddSwipeGesture])
    {
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [[self view] addGestureRecognizer:recognizer];
    }

    //加载url
    [self loadUrl];
}

#pragma mark viewcontroller即将显示到前台
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟统计
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    //拦截登录
    [self interceptLogin];
}

#pragma mark viewController即将退出前台显示
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

#pragma mark 收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _HUD = nil;
    _httpClient = nil;
}

#pragma mark 拦截登录
-(void)interceptLogin
{
    //先判断是否需要登录，如果需要登录，则做登录拦截
    if (self.webViewParams.needLogin && ![CommonUtils loginUser])
    {
        [self redirectToLogin];
    }
}


//~~~~~~~~~~~~~处理页面手势相关的方法~~~~~~~~~~~~~~~~~~//
#pragma mark 处理Swipe手势
-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    if(gesture.direction==UISwipeGestureRecognizerDirectionRight)
    {
        [self gotoBack:nil];//从右向左滑动时，相当于返回操作
    }
}

#pragma mark 处理Tap手势
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture
{
    
}

#pragma mark 处理pan手势情况
-(void)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:[SharedApplication keyWindow]];
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        _startMovePoint = touchPoint;
        _orginFrame = self.view.frame;
    }else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        if(_startMovePoint.x < panGestureLeftMaxStartXOffset)//从左边
        {
            [self moveViewWithX:touchPoint.x view:self.view];
        }else if(_startMovePoint.x > SCREEN_WIDTH -panGestureRightMaxStartXOffset)//从右边
        {
            [self moveViewWithX:-(SCREEN_WIDTH-touchPoint.x) view:self.view];
        }
    }else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        if(_startMovePoint.x < panGestureLeftMaxStartXOffset)//从左边
        {
            if (touchPoint.x > panGestureLeftMaxXOffset)
            {
                [self popViewControllerFromLeft];
            }else
            {
                [self restoreToOrignalFrame:self.view];
            }
        }else if(_startMovePoint.x > SCREEN_WIDTH -panGestureRightMaxStartXOffset)//从右边
        {
            if ((SCREEN_WIDTH-touchPoint.x) > panGestureRightMaxXOffset)
            {
                [self popViewControllerFromRight];
            }else{
                [self restoreToOrignalFrame:self.view];
            }
        }
    }
}

#pragma mark 恢复至之前的frame
-(void)restoreToOrignalFrame:(UIView*)view
{
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = _orginFrame;
    } completion:nil];
    
}

#pragma mark 将view移动到x
- (void)moveViewWithX:(float)x view:(UIView*)view
{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat viewX = x;
        CGFloat viewY = view.frame.origin.y;
        CGFloat viewW = view.frame.size.width;
        CGFloat viewH = view.frame.size.height;
        CGRect  viewFrame = (CGRect){viewX,viewY,viewW,viewH};
        self.view.frame = viewFrame;
    } completion:nil];
}

#pragma mark 是否需要添加TapGesture
-(BOOL)needAddTapGesture
{
    return YES;
}

#pragma mark 是否需要添加PanGesture
-(BOOL)needAddPanGesture
{
    return YES;
}

#pragma mark 是否需要添加SwipeGesture
-(BOOL)needAddSwipeGesture
{
    return YES;
}

//~~~~~~~~~~~处理格式化页面url的方法~~~~~~~~~~~~~~~~//
#pragma mark 格式化startPage
-(NSString*)startPage
{
    if (!_startPage) {
        if ([self.webViewParams.startPage isUrl])
        {
            _startPage = self.webViewParams.startPage;
        }else{
            _startPage =[NSString stringWithFormat:@"%@%@",wwwRootDir,self.webViewParams.startPage];
        }

    }
    return _startPage;
}




//~~~~~~~~~~~~~~~处理http请求的方法~~~~~~~~~~~~~~~~~~~~~~~~//
#pragma mark 获取httpClient
-(HttpRequestClient *)httpClient
{
    if (!_httpClient)
    {
        _httpClient = [[HttpRequestClient alloc]init];
        _httpClient.delegate = self;
    }
    return _httpClient;
}


#pragma mark 开始加载
-(void)beginLoading:(NSString*)title view:(UIView*)view{
    [self stopLoading];
    _HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.labelText = [CommonUtils isStrEmpty:title] ? @"正在加载..." : title;
    _HUD.margin = 10.f;
    _HUD.removeFromSuperViewOnHide = YES;
}

#pragma mark 结束加载
-(void)stopLoading
{
    if(_HUD)
    {
        [_HUD hide:YES];
        [_HUD  removeFromSuperview];
        _HUD = nil;
    }
}

#pragma 发送post请求
-(void)doPost:(NSString *)url params:(NSDictionary *)params{
    [self doPost:url params:params tag:0 showProgress:YES];
}

#pragma mark 发送post请求
-(void)doPost:(NSString *)url params:(NSDictionary *)params tag:(int)reqTag{
    [self doPost:url params:params tag:reqTag showProgress:YES];
}

#pragma mark 发送post请求
-(void)doPost:(NSString *)url params:(NSDictionary *)params tag:(int)reqTag showProgress:(BOOL)showProgress{
    if (showProgress)
    {
        isloading=YES;
        [self beginLoading:nil view:self.view];
    }
    [self.httpClient doPostWithUrl:url params:params dataType:json_data_type reqTag:reqTag];
}

#pragma mark 上传图片
- (void) uploadImage:(NSString *) url image:(UIImage *)image params:(NSDictionary *) params tag:(int)reqTag
{
    [self.httpClient uploadImgWithUrl:url
                                image:image
                               params:params
                             dataType:json_data_type
                                  tag:reqTag];
}


#pragma mark 请求成功或失败后回调
-(void)respResult:(NSDictionary*)result errorcode:(int)errorcode
         errorMsg:(NSString*)errorMsg
         dataType:(HttpRequestDataType)dataType
              tag:(int)reqTag{
    if (isloading)
    {
        isloading = NO;
        [self stopLoading];
    }
    //响应失败
    if (errorcode != HttpRespCode_RespSuceess)
    {
        if (errorcode == HttpRespCode_Need_AutoLogin || errorcode == HttpRespCode_Need_Login)
        {
            //需要自动登录
            __weak BaseWebviewController *this = self;
            [self showAlertWithTowBtns:nil
                               message:@"会话已过期，是否重新登录？"
                    doneBtnFinishBlock:^{
                [this redirectToLogin];
            }];
        }
        else
        {
            [self handleErrorCode:errorcode errormsg:errorMsg tag:reqTag];
        }
    }
    else
    {
        [self handleRespResult:result tag:reqTag];//响应成功
    }
}

#pragma mark 自动登录
-(void)doAutoLogin
{
    NSDictionary  *loginUser = [CommonUtils loginUser];
    if (loginUser)
    {
        //1.做一次自动登录
        NSString *userEncrypt = [loginUser objectForKey:@"userEncrypt"];
        NSString *userUuid = [loginUser objectForKey:@"userUuid"];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:userEncrypt,@"userEncrypt",userUuid,@"userUuid",nil];
        [self doPost:autoLoginUrl params:params tag:autoLoginReqTag showProgress:NO];
    }
    else
    {
        //2.直接跳转到登录页面
        [self redirectToLogin];
    }
}

#pragma mark 跳转到登录页面
-(void)redirectToLogin
{
    LoginController *loginController = [[LoginController alloc] init];
    NSDictionary *loginUser = [CommonUtils loginUser];
    if (loginUser)
    {
        loginController.mobileNo = [loginUser objectForKey:@"userAccount"];
    }
    [self pushViewControllerFromBottom:loginController];
}

#pragma mark 响应成功后回调
-(void)handleRespResult:(NSDictionary*)result tag:(int)reqTag
{
    NSString *funcName = [NSString stringWithFormat:@"%@(%@,'%i')",httpReqSuccJsFuncName,[result JSONToStr],reqTag];
    [self.webView stringByEvaluatingJavaScriptFromString:funcName];
}

#pragma mark 响应失败后回调
-(void)handleErrorCode:(int)errorCode errormsg:(NSString *)message tag:(int)reqTag
{
    //执行对应的函数
    NSString *funcName = [NSString stringWithFormat:@"%@('%@','%i','%i')",httpReqFailJsFuncName,message,errorCode,reqTag];
    [self.webView stringByEvaluatingJavaScriptFromString:funcName];
    //是否显示错误信息
    BOOL alertError = [self handleErrorCode:errorCode info:message tag:reqTag];
    if(alertError)
    {
        //如果错误信息为空，直接给一个默认的
        if([CommonUtils isStrEmpty:message])
        {
            message = DEFAULT_REQUEST_ERROR_MESSAGE;
        }
        //提示错误信息
        if(showErrWithToast)
        {
            [self showAlert:nil message:message type:AlertViewType_Toast];
        }else
        {
            [self showAlert:nil message:message type:AlertViewType_Alert];
        }
    }
}

#pragma mark 错误码处理，返回yes代表需要弹出提示
-(BOOL)handleErrorCode:(int) code info:(NSString *)info tag:(int)reqTag
{
    return NO;
}

//~~~~~~~~~~~~创建加载页面需要的webview~~~~~~~~~~~~~~~~//
#pragma mark 创建webview
-(UIWebView*)webView
{
    if (!_webView)
    {
        CGFloat webViewX = 0.f;
        CGFloat webViewY = SCREEN_HEIGHT_START + TOP_BLANNER_HEIGHT;
        if ([self navBar])
        {
            webViewY = CGRectGetMaxY([self navBar].frame);
        }
        CGFloat webViewW = SCREEN_WIDTH;
        CGFloat webViewH = SCREEN_HEIGHT - webViewY;
        CGRect webviewFrame = (CGRect){webViewX,webViewY,webViewW,webViewH};
        _webView = [[UIWebView alloc]initWithFrame:webviewFrame];
        _webView.delegate = self;
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    return _webView;
}

#pragma mark 加载url
-(void)loadUrl{
    id url = [self appURL];
    if (url && [url isKindOfClass:[NSURL class]]) {
        NSURL *tempUrl = (NSURL*)url;
        NSURLRequest* appReq = [NSURLRequest requestWithURL:tempUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
        [self.webView loadRequest:appReq];
    }else if(url && [url isKindOfClass:[NSString class]]){
        NSString *urlStr = (NSString*)url;
        NSString* appHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:appHtml baseURL:nil];
    }else{
        NSString* html = [NSString stringWithFormat:@"<html><body> %@ </body></html>", @"加载页面失败"];
        [self.webView loadHTMLString:html baseURL:nil];
    }
}

#pragma mark 获取请求的url
-(id)appURL
{
    id appURL;
    if ([self.startPage rangeOfString:@"://"].location != NSNotFound)
    {
        appURL = [NSURL URLWithString:self.startPage];
    } else if ([self.wwwFolderName rangeOfString:@"://"].location != NSNotFound)
    {
        appURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", self.wwwFolderName, self.startPage]];
    } else
    {
        NSString* startFilePath = [self pathForResource:self.startPage];
        if (startFilePath == nil) {
            appURL = [NSString stringWithFormat:@"ERROR: Start Page at '%@/%@' was not found.",
                      self.wwwFolderName, self.startPage];
        } else {
            appURL = [NSURL fileURLWithPath:startFilePath];
        }
    }
    return appURL;
}

#pragma mark 加载资源
- (NSString*)pathForResource:(NSString*)resourcepath
{
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSMutableArray* directoryParts = [NSMutableArray arrayWithArray:[resourcepath componentsSeparatedByString:@"/"]];
    NSString* filename = [directoryParts lastObject];
    
    [directoryParts removeLastObject];
    
    NSString* directoryPartsJoined = [directoryParts componentsJoinedByString:@"/"];
    NSString* directoryStr = self.wwwFolderName;
    
    if ([directoryPartsJoined length] > 0) {
        directoryStr = [NSString stringWithFormat:@"%@/%@", self.wwwFolderName, [directoryParts componentsJoinedByString:@"/"]];
    }
    
    return [mainBundle pathForResource:filename ofType:@"" inDirectory:directoryStr];
}


//~~~~~~~~~~~~~~UIWebViewDelegate代理方法~~~~~~~~~~~~~~~~~~~//
#pragma mark UIWebViewDelegate 方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *reqUrl = [[request URL] absoluteString];
    //处理参数中有中文的乱码问题
    reqUrl = [reqUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray  *urlComps = [reqUrl componentsSeparatedByString:@"://"];
    if (urlComps && urlComps.count > 0)
    {
        NSString *protocalName = [[urlComps objectAtIndex:0] lowercaseString];
        if ([protocalName isEqualToString:invokeMethodProtocal])
        {
            return [self handleMethodInvokeWithUrlComps:urlComps];//调用原生的方法
        }else if([protocalName isEqualToString:redirectNativePgProtocal])
        {
            return [self handleRedirectPageWithUrlComps:urlComps];//跳转到原生页面
        }else
        {
            return YES;
        }
    }
    return YES;
}

#pragma mark 开始加载页面
- (void)webViewDidStartLoad:(UIWebView*)theWebView
{
    [self beginLoading:nil view:self.view];
}

#pragma mark 加载完毕
- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    [self stopLoading];
}

#pragma 页面加载出错
- (void)webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    [self stopLoading];
    [self showAlert:nil message:@"页面加载出错咯" type:AlertViewType_Toast];
}


//~~~~~~~~~~~~~~处理页面跳转的方法~~~~~~~~~~~~~~~~~~~//
#pragma mark 处理跳转到页面的请求
-(BOOL)handleRedirectPageWithUrlComps:(NSArray*)urlComps
{
    NSArray *array = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"?"];
    NSString *type;
    NSString *pageParamsStr;
    if (!array && array.count ==0)
    {
        return NO;
    }else if (array.count == 1)
    {
        type = [array objectAtIndex:0];
    }else if (array.count > 1)
    {
        type = [array objectAtIndex:0];
        pageParamsStr = [array objectAtIndex:1];
    }
    NSMutableDictionary *pageParams;
    if (![CommonUtils isStrEmpty:pageParamsStr])
    {
        NSArray *paramArray = [pageParamsStr componentsSeparatedByString:@"&"];
        if (paramArray && paramArray.count > 0)
        {
            pageParams = [NSMutableDictionary dictionary];
            for (int index = 0 ; index < paramArray.count; index ++)
            {
                NSString *itemStr = [paramArray objectAtIndex:index];
                if ([CommonUtils isStrEmpty:itemStr])
                {
                    continue;
                }
                NSArray *items = [itemStr componentsSeparatedByString:@"="];
                [pageParams setObject: [items[1] trimNull] forKey:[items[0] trimNull]];
            }
        }
    }
    type = [type trimNull];
    if ([type isEqualToString:redirectToNativePageType])
    {
        return [self popToNativePage:pageParams];//跳转到原生页面
    }else if([type isEqualToString:redirectToWebPageType])
    {
        return [self popToWebPage:pageParams];//跳转到web页面
    }else
    {
        return NO;
    }
}

#pragma mark 跳转到原生页面
-(BOOL)popToNativePage:(NSDictionary*)pageParams
{
    NSMutableDictionary *configData = [CommonUtils nativePageConfig];
    NSString *pageUrl = [pageParams objectForKey:@"startPage"];
    if ([CommonUtils isStrEmpty:pageUrl])
    {
        [self showAlert:nil message:@"亲，页面不存在了" type:AlertViewType_Toast];
        return NO;
    }
    NSString *className = [configData objectForKey:pageUrl];
    if (![CommonUtils isStrEmpty:className])
    {
        Class clazz = NSClassFromString(className);
        if (clazz && [clazz isSubclassOfClass:[BaseController class]])
        {
            BaseController *controller = [clazz new];
            controller.reqParams = pageParams;
            [self pushViewControllerFromBottom:controller];
        }else
        {
            [self showAlert:nil message:@"亲，页面无法跳转哦" type:AlertViewType_Toast];
        }
    }
    return NO;
}

#pragma mark 跳转到web页面
-(BOOL)popToWebPage:(NSDictionary*)pageParams
{
    BaseWebviewController *controller = [[BaseWebviewController alloc] init];
    WebViewParam *params = [[WebViewParam alloc] init];
    params.startPage = [pageParams objectForKey:@"startPage"];
    if ([CommonUtils isStrEmpty:params.startPage])
    {
        [self showAlert:nil message:@"亲，页面无法跳转哦" type:AlertViewType_Alert];
        return NO;
    }
    params.leftBtnTitle = [pageParams objectForKey:@"leftTitle"];
    params.leftBtnIcon = [pageParams objectForKey:@"leftIcon"];
    params.centerBtnTitle = [pageParams objectForKey:@"centerTitle"];
    params.centerBtnIcon = [pageParams objectForKey:@"centerIcon"];
    params.rightBtnTitle = [pageParams objectForKey:@"rightTitle"];
    params.rightBtnIcon = [pageParams objectForKey:@"rightIcon"];
    controller.webViewParams = params;
    [self pushViewControllerFromBottom:controller];
    return NO;
}


//~~~~~~~~~~~~~~js调用ios原生的方法~~~~~~~~~~~~~~~~~~~//
#pragma mark 处理js调用原生的方法
-(BOOL)handleMethodInvokeWithUrlComps:(NSArray*)urlComps
{
    NSArray *array = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@"?"];
    NSString *methodName;
    NSString *methodParamStr;
    if (!array && array.count ==0)
    {
        return NO;
    }else if (array.count == 1)
    {
        methodName = [array objectAtIndex:0];
    }else if (array.count > 1)
    {
        methodName = [array objectAtIndex:0];
        methodParamStr = [array objectAtIndex:1];
    }
    NSMutableDictionary *methodParams;
    if (![CommonUtils isStrEmpty:methodParamStr])
    {
        NSArray *paramArray = [methodParamStr componentsSeparatedByString:@"&"];
        if (paramArray && paramArray.count > 0)
        {
            methodParams = [NSMutableDictionary dictionary];
            for (int index = 0 ; index < paramArray.count; index ++)
            {
                NSString *itemStr = [paramArray objectAtIndex:index];
                if ([ CommonUtils isStrEmpty:itemStr])
                {
                    continue;
                }
                NSArray *items = [itemStr componentsSeparatedByString:@"="];
                [methodParams setObject: [items[1] trimNull] forKey:[items[0] trimNull]];
            }
        }
    }
    methodName = [NSString stringWithFormat:@"%@%@",methodName,@":"];
    //执行对应的方法
    if ([self respondsToSelector:NSSelectorFromString(methodName)])
    {
        [self performSelector:NSSelectorFromString(methodName) withObject:methodParams];
    }
    return NO;
}

#pragma mark 用原生显示警告信息
-(void)doAlert:(NSMutableDictionary*)params
{
    NSString *title = [params objectForKey:@"title"];
    NSString *message = [params objectForKey:@"message"];
    NSString *type = [params objectForKey:@"type"];
    AlertViewType alertType = AlertViewType_Alert;
    if ([@"toast" isEqualToString:type])
    {
        alertType = AlertViewType_Toast;
    }
    [self showAlert:title message:message type:alertType];
}

#pragma mark 发送http请求
-(void)doHttpReq:(NSMutableDictionary*)params
{
    NSString *url = [params objectForKey:@"url"];
    int reqTag = [[params objectForKey:@"reqTag"] intValue];
    [self doPost:url params:params tag:reqTag showProgress:YES];
}

//~~~~~~~~~~~~~处理页面回退的方法~~~~~~~~~~~~~~~~~~//
#pragma mark 回退
-(void)gotoBack:(UIButton *)sender
{
    //返回处理
    [self popViewControllerFromLeft];
}


//~~~~~~~~~~~~~处理控制器导航栏的方法~~~~~~~~~~~~~~//
#pragma mark 获取导航栏
-(BaseNaviBarWidget*)navBar
{
    NavBarViewWidget *navBar = nil;
    if (self.webViewParams)
    {
        navBar = [[NavBarViewWidget alloc] init];
        navBar.delegate = self;
        navBar.leftTitle = self.webViewParams.leftBtnTitle;
        navBar.leftIcon = [UIImage imageNamed:self.webViewParams.leftBtnIcon];
        navBar.centerTitle = self.webViewParams.centerBtnTitle;
        navBar.centerIcon = [UIImage imageNamed:self.webViewParams.centerBtnIcon];
        navBar.rightTitle = self.webViewParams.rightBtnTitle;
        navBar.rightIcon = [UIImage imageNamed:self.webViewParams.rightBtnIcon];
    }
    return navBar;
}

#pragma mark BaseNaviBarWidgetDelegate 方法
-(void)leftNavBarBtnClicked:(UIButton *)leftNavBarBtn{
    [self gotoBack:nil];
}

//~~~~~~~~~~~~~~~处理页面出现效果的方法~~~~~~~~~~~~~~~~~//
#pragma mark - 自上而下推进视图控制器的动画效果
- (void)pushViewControllerFromTop:(UIViewController *)viewController
{
    CATransition* animation = [self pushTopMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:viewController animated:NO];
}

#pragma mark - 自上而下推出视图控制器的动画效果
- (void)popViewControllerFromTop
{
    self.view.alpha = 0;
    CATransition* animation = [self popTopMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 自下而上推进视图控制器的动画效果
- (void)pushViewControllerFromBottom:(UIViewController *)viewController
{
    CATransition* animation = [self pushBottomMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:viewController animated:NO];
}

#pragma mark - 自下而上推出视图控制器的动画效果
- (void)popViewControllerFromBottom
{
    self.view.alpha = 0;
    CATransition* animation = [self popBottomMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark 自左而右的推进视图控制器
-(void)pushViewControllerFromLeft:(UIViewController*)viewController
{
    CATransition* animation = [self pushLeftMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:@"left-push"];
    [self.navigationController pushViewController:viewController animated:NO];
}

#pragma mark 自左而右的推出视图控制器
-(void)popViewControllerFromLeft
{
    self.view.alpha = 0;
    CATransition* animation = [self popLeftMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:@"left-pop"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 自右而左的推进视图控制器
-(void)pushViewControllerFromRight:(UIViewController*)viewController
{
    CATransition* animation = [self pushRightMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:@"right-push"];
    [self.navigationController pushViewController:viewController animated:NO];
}

#pragma mark 自左而右的推出视图控制器
-(void)popViewControllerFromRight
{
    self.view.alpha = 0;
    CATransition* animation = [self popRightMoveAnimation];
    [self.navigationController.view.layer addAnimation:animation forKey:@"right-pop"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 弹框显示－－带标题
-(void)showAlert:(NSString*)title message:(NSString*)message type:(AlertViewType)type
{
    [ApplicationDelegate showAlert:title message:message type:type];
}

#pragma mark 弹框显示－－带标题
-(void)showAlertWithTowBtns:(NSString*)title message:(NSString*)message doneBtnFinishBlock:(void(^)(void))doneBtnFinishBlock
{
    [ApplicationDelegate showAlertWithTowBtns:title message:message doneBtnFinishBlock:doneBtnFinishBlock];
}

//~~~~~~~~~~~~~从图库中获取照片或者是拍摄相关的处理方法~~~~~~~~~~~~~~~~//
#pragma mark 是否有拍照的权限
-(BOOL)hasAvAuthority
{
    if (IOS7)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus != AVAuthorizationStatusAuthorized && authStatus != AVAuthorizationStatusNotDetermined)
        {
            [self showAlert:nil message:@"相机权限目前为关闭，请前往“设置”打开。" type:AlertViewType_Alert];
            return NO;
        }
    }
    return YES;
}

#pragma mark 从相机或者相册中获取图片
-(void)pickImages:(NSString*)title
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"相册", nil];
    actionSheet.tag = avActionSheetTag;
    [actionSheet showInView:[ApplicationDelegate window]];
}

#pragma mark 处理从相机或者相册中获取到的图片--(子类覆盖)
-(void)handlePickImage:(UIImage*)image
{
    
}

#pragma mark UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == avActionSheetTag)
    {
        [self handleActionSheetPickImages:buttonIndex];
    }
    
}

#pragma mark 处理获取图片的方法
-(void)handleActionSheetPickImages:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self takePicFromCamera];
            break;
        case 1:
            [self takePicFromAlbum];
            break;
        default:
            break;
    }
}

#pragma mark 从相册中选择图片
-(void)takePicFromAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
        picker.maximumNumberOfSelection = 1;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups=NO;
        picker.delegate = self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
                                  {
                                      if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
                                      {
                                          NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                                          return duration >= 5;
                                      } else
                                      {
                                          return YES;
                                      }
                                  }];
        [self presentViewController:picker animated:YES completion:NULL];
    }else
    {
        [self showAlert:nil message:@"对不起，您的手机暂不支持从图库中获取照片" type:AlertViewType_Alert];
    }
    
    
}

#pragma mark 从相机中获取图片
-(void)takePicFromCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [self hasAvAuthority])
    {
        UIImagePickerController *pickView = [[UIImagePickerController alloc] init];
        pickView.delegate = self;
        [pickView setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:pickView animated:YES completion:nil];
    }else
    {
        [self showAlert:nil message:@"对不起，您的设备暂不支持拍照" type:AlertViewType_Toast];
    }
}

#pragma mark UIImagePickerControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = original;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ZYQAssetPickerControllerDelegate代理方法
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    ALAsset *asset=assets[0];
    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = image;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)assetPickerControllerDidCancel:(ZYQAssetPickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NO];
}


#pragma mark PECropViewControllerDelegate代理方法
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    //处理图片
    [self handlePickImage:croppedImage];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
