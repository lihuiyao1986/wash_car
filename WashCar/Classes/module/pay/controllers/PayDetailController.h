//
//  PayDetailController.h
//  WashCar
//
//  Created by yanshengli on 15-1-7.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseController.h"
#import "TapImageViewWidget.h"
#import "CustBgViewWidget.h"

/***
 *
 *@description:支付详情页面--接口
 *@author:liys
 *@since:2014-1-7
 *@corp:cheletong
 */
@interface PayDetailController : BaseController
{
    //1.头部视图
    CustBgViewWidget *_headView;
    UILabel *_addresslb;  //地址
    TapImageViewWidget *_callServiceBtn;  //联系客服按钮
    
    //2.中间视图
    CustBgViewWidget *_centerView;
    TapImageViewWidget *_orderStatusImgView;
    UIButton *_backToHomeBtn;
    
    //3.底部视图
    UIView *_bottomView;
    UITableView *_orderStatusTBView;
    
    //4.地图定位service
    //BMKLocationService *_locService;
    //BMKGeoCodeSearch *_geoCodeSearch;
    
    //5.数据对象
    NSMutableArray *_data;
    
    //6.当前状态的index
    int _currentStatusIndex;
}

#pragma mark 头部视图
@property (nonatomic,strong,readonly)UIView *headView;

#pragma mark 中间视图
@property (nonatomic,strong,readonly)UIView *centerView;

#pragma mark 底部视图
@property (nonatomic,strong,readonly)UIView *bottomView;

@end