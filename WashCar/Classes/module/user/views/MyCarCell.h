//
//  MyCarCell.h
//  WashCar
//
//  Created by mac on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCarModel.h"

@interface MyCarCell : UITableViewCell

@property (strong , nonatomic) UILabel* lbCarLicensePlate; // 车牌号
@property (strong , nonatomic) UILabel* lbCarType; // 车型
@property (strong , nonatomic) UILabel* lbCarColor; // 车颜色
@property (strong , nonatomic) UIImageView* carImgView; // 车照片

@property (strong , nonatomic) MyCarModel* model; // 数据模型

@end
