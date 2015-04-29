//
//  LocationCacheCell.m
//  WashCar
//
//  Created by mac on 15/1/10.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "LocationCacheCell.h"

@implementation LocationCacheCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _lbAddress = [[UILabel alloc] init];
        _lbAddress.numberOfLines = 1;
        _lbAddress.font = [UIFont systemFontOfSize:15];
        _lbAddress.textColor = hexColor(0x414141, 1);
        [self.contentView addSubview:_lbAddress];
        
        _iconImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImgView];
        
        _lineImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_lineImgView];
    }
    return  self;
}

- (void)setModel:(LocationCacheModel *)model
{
    _model = model;
    
    [self setCellData];
    
    [self setCellFrame];
}

- (void) setCellData
{
    _lbAddress.text = _model.modelAddress;
    
    _iconImgView.image = _model.modelIcon;
    
    _lineImgView.image = _model.modelLine;
}

- (void) setCellFrame
{
    _iconImgView.frame = CGRectMake(18, 12, 17, 17);
    
    _lbAddress.frame = CGRectMake(CGRectGetMaxX(_iconImgView.frame) + 9, 12, ScreenWidth - CGRectGetMaxX(_iconImgView.frame) + 15, 18);
    
    _lineImgView.frame = CGRectMake(18, 40.5, ScreenWidth - 18 * 2, 1);
}

@end
