//
//  LocationViewController.h
//  WashCar
//
//  Created by Cheletong on 15-1-7.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseController.h"
#import "ILRemoteSearchBar.h"

// 车位置确定后回调
typedef void (^pageCallBack)(NSString* carLocationAddress,CLLocationCoordinate2D coordinate,NSDictionary* info);

@interface LocationViewController : BaseController<NavBarViewWidgetDelegate>

@property (strong , nonatomic) pageCallBack pageCallBack;

@end
