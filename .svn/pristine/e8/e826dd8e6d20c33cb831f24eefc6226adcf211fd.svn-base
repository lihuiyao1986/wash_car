//
//  MyCarCell.m
//  WashCar
//
//  Created by mac on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "MyCarCell.h"
#import "ImageCache.h"

#define carImgX         10
#define carImgY         10
#define carImgW         50
#define carIMgH         50

#define lbCarLicensePlateX      CGRectGetMaxX(_carImgView.frame) + 20
#define lbCarLicensePlateY      10
#define lbCarLicensePlateW      (ScreenWidth - carImgW - carImgX * 2)
#define lbCarLicensePlateH      25

@implementation MyCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写cell初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 初始化cell组件
        _lbCarColor = [[UILabel alloc] init];
        _lbCarColor.font = FONT_TextSize_S0;
        [self.contentView addSubview:_lbCarColor];
        
        _lbCarLicensePlate = [[UILabel alloc] init];
        _lbCarLicensePlate.font = FONT_TextSize_S1;
        [self.contentView addSubview:_lbCarLicensePlate];
        
        _lbCarType = [[UILabel alloc] init];
        _lbCarType.font = FONT_TextSize_S0;
        [self.contentView addSubview:_lbCarType];
        
        _carImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_carImgView];
    }
    return self;
}

#pragma mark - 重写set方法
- (void)setModel:(MyCarModel *)model
{
    _model = model;
    
    [self setCellData];
    
    [self setCellFrame];
}

#pragma mark - 设置cell组件的值
- (void) setCellData
{
    _lbCarColor.text = _model.modelCarColor;
    
    _lbCarLicensePlate.text = _model.modelCarLicensePlate;
    
    _lbCarType.text = _model.modelCarType;
    
    [ImageCache loadImageWithUrl:_model.modelCarImgURL imageView:_carImgView placeholderImage:@"" cacheImage:NO];
}

#pragma mark - 设置cell组件的frame
- (void) setCellFrame
{
    _carImgView.frame = CGRectMake(carImgX, carImgY, carImgW, carIMgH);
    
    _lbCarLicensePlate.frame = CGRectMake(lbCarLicensePlateX, lbCarLicensePlateY, lbCarLicensePlateW, lbCarLicensePlateH);
    
    _lbCarType.frame = CGRectMake(lbCarLicensePlateX, CGRectGetMaxY(_lbCarLicensePlate.frame) + 10, lbCarLicensePlateW * 2 / 3 , lbCarLicensePlateH - 5);
    
    _lbCarColor.frame = CGRectMake(CGRectGetMaxX(_lbCarType.frame) + 10, CGRectGetMaxY(_lbCarLicensePlate.frame) + 10, lbCarLicensePlateW * 1 / 3, lbCarLicensePlateH - 5);
}

@end
