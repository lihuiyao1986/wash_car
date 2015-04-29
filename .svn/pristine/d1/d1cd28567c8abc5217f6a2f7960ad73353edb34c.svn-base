//
//  ColorPickViewWidget.m
//  WashCar
//
//  Created by yanshengli on 15-1-6.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "ColorPickViewWidget.h"
#import "NSString+Utility.h"
#import "UIView+WashCarUtility.h"

// 每个cell的高度
#define cellHeight 40.f
// toolbar高度
#define toolBarHeight 44.f
// labelX
#define labelX 20.f
// labelW
#define labelW SCREEN_WIDTH - 60.f -labelX
// cellLabelFont
#define cellLabelFont [UIFont boldSystemFontOfSize:18]
// cellLabelColor
#define cellLabelColor [UIColor whiteColor]
// cancelTitleStr
#define cancelTitleStr @"取消"
// confirmTitleStr
#define confirmTitleStr @"确定"
// titleStr
#define titleStr @"请选择颜色"
// 取消按钮的宽度
#define cancelTitleBtnW  60.f
// 确认按钮的宽度
#define confirmTitleBtnW 60.f

@interface  ColorPickViewWidget()
<UITableViewDelegate,
 UITableViewDataSource>

@end

/***
 *
 *@description:选择颜色的pickview--实现
 *@author:liys
 *@since:2014-1-6
 *@corp:cheletong
 */
@implementation ColorPickViewWidget

#pragma mark 颜色数组
@synthesize colors;

#pragma mark 被选中的颜色
@synthesize selectedColor;

#pragma mark 标题
@synthesize title;

#pragma mark 取消按钮的标题
@synthesize cancelBtnTitle;

#pragma mark 确认按钮标题
@synthesize confirmBtnTitle;

#pragma mark 代理属性
@synthesize delegate;

#pragma mark 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = Rect(0.f, 0.f, SCREEN_WIDTH, toolBarHeight + cellHeight * 5);
        if (!self.colors || self.colors.count <= 0)
        {
            NSString *plistFilePath = [Bundle pathForResource:@"Colors" ofType:@"plist"];
            self.colors =[NSArray arrayWithContentsOfFile:plistFilePath];
        }
        _selectedItem = [self.colors firstObject];
    }
    return self;
}


#pragma mark 开始绘画
-(void)drawRect:(CGRect)rect
{
    //重置子视图
    [self removeAllSubviews];
    
    //toolBar
    CGFloat toolBarX = 0.f;
    CGFloat toolBarY = 0.f;
    CGFloat toolBarW = self.frame.size.width;
    CGFloat toolBarH = toolBarHeight;
    CGRect  toolBarFrame = (CGRect){toolBarX,toolBarY,toolBarW,toolBarH};
    _toolBar = [[UIView alloc]initWithFrame:toolBarFrame];
    _toolBar.backgroundColor = hexColor(0x000000,0.6);
    [self addSubview:_toolBar];
    
    //取消按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat cancelBtnX = 0.f;
    CGFloat cancelBtnY = 0.f;
    CGFloat cancelBtnW = cancelTitleBtnW;
    CGFloat cancelBtnH = CGRectGetHeight(_toolBar.frame);
    CGRect  cancelBtnFrame = (CGRect){cancelBtnX,cancelBtnY,cancelBtnW,cancelBtnH};
    _cancelBtn.frame = cancelBtnFrame;
    _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    if ([CommonUtils isStrEmpty:self.cancelBtnTitle])
    {
        self.cancelBtnTitle = cancelTitleStr;
    }
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateHighlighted];
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateSelected];
    [_cancelBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateHighlighted];
    [_cancelBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateSelected];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_cancelBtn];
    
    //标题
    CGFloat titlelbX = CGRectGetMaxX(_cancelBtn.frame);
    CGFloat titlelbY = 0.f;
    CGFloat titlelbW = self.frame.size.width - titlelbX - confirmTitleBtnW;
    CGFloat titlelbH = toolBarHeight;
    CGRect  titlelbFrame = (CGRect){titlelbX,titlelbY,titlelbW,titlelbH};
    _titlelb = [[UILabel alloc]initWithFrame:titlelbFrame];
    _titlelb.textAlignment = NSTextAlignmentCenter;
    _titlelb.textColor = RGB_TextColor_C4;
    _titlelb.lineBreakMode = NSLineBreakByTruncatingTail;
    _titlelb.font = [UIFont boldSystemFontOfSize:18];
    if ([CommonUtils isStrEmpty:self.title])
    {
        self.title = titleStr;
    }
    _titlelb.text = self.title;
    [_toolBar addSubview:_titlelb];
    
    //确认按钮
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat confirmBtnX = CGRectGetMaxX(_titlelb.frame);
    CGFloat confirmBtnY = 0.f;
    CGFloat confirmBtnW = confirmTitleBtnW;
    CGFloat confirmBtnH = CGRectGetHeight(_toolBar.frame);
    CGRect  confirmBtnFrame = (CGRect){confirmBtnX,confirmBtnY,confirmBtnW,confirmBtnH};
    _confirmBtn.frame = confirmBtnFrame;
    _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    if ([CommonUtils isStrEmpty:self.confirmBtnTitle])
    {
        self.confirmBtnTitle = confirmTitleStr;
    }
    [_confirmBtn setTitle:self.confirmBtnTitle forState:UIControlStateNormal];
    [_confirmBtn setTitle:self.confirmBtnTitle forState:UIControlStateHighlighted];
    [_confirmBtn setTitle:self.confirmBtnTitle forState:UIControlStateSelected];
    [_confirmBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateHighlighted];
    [_confirmBtn setTitleColor:RGB_TextColor_C4 forState:UIControlStateSelected];
    [_confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_confirmBtn];
    
    //tableview
    CGFloat tbX = 0.f;
    CGFloat tbY = CGRectGetMaxY(_toolBar.frame);
    CGFloat tbW = self.frame.size.width;
    CGFloat tbH = self.frame.size.height - tbY;
    CGRect  tbFrame = (CGRect){tbX,tbY,tbW,tbH};
    _colorTV = [[UITableView alloc]initWithFrame:tbFrame style:UITableViewStylePlain];
    _colorTV.delegate = self;
    _colorTV.dataSource = self;
    _colorTV.contentSize = CGSizeMake(self.frame.size.width, cellHeight * self.colors.count);
    _colorTV.pagingEnabled = YES;
    _colorTV.backgroundColor = [UIColor clearColor];
    _colorTV.showsHorizontalScrollIndicator = NO;
    _colorTV.showsVerticalScrollIndicator = NO;
    _colorTV.backgroundColor = hexColor(0x333333, 0.6);
    _colorTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_colorTV];
    
    int selectedIndex = 0;
    if (![CommonUtils isStrEmpty:self.selectedColor]) {
        selectedIndex = [self.colors indexOfObject:self.selectedColor];
    }
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [_colorTV selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark 取消按钮被点击触发的事件处理
-(IBAction)cancelBtnClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(colorPickViewCancelBtnClicked:)])
    {
        [self.delegate colorPickViewCancelBtnClicked:sender];
    }
}

#pragma mark 确认按钮被点击触发的事件处理
-(IBAction)confirmBtnClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(colorPickViewConfirmBtnClicked:color:)])
    {
        [self.delegate colorPickViewConfirmBtnClicked:sender color:_selectedItem];
    }
    
}

#pragma mark UITableViewDelegate代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = [self.colors objectAtIndex:indexPath.row];
}

//将取消选中时执行, 也就是上次先中的行
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark UITableViewDataSource代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"colorItemCell";
    UITableViewCell *cellItem = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cellItem)
    {
        cellItem = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cellItem.backgroundColor = [UIColor clearColor];
        UIView *selectedBGView = [[UIView alloc] initWithFrame:cellItem.frame];
        cellItem.selectedBackgroundView = selectedBGView;
        cellItem.selectedBackgroundView.backgroundColor = hexColor(0x333333, 0.2);
    }
    [cellItem.contentView removeAllSubviews];
    CGFloat colorNamelbX  = labelX;
    CGFloat colorNamelbY = 0.f;
    CGFloat colorNamelbW = labelW;
    CGFloat colorNamelbH = cellHeight;
    CGRect  colorNamelbFrame = (CGRect){colorNamelbX,colorNamelbY,colorNamelbW,colorNamelbH};
    UILabel *colorlb = [[UILabel alloc]initWithFrame:colorNamelbFrame];
    NSString *colorName = [self.colors objectAtIndex:indexPath.row];
    colorlb.text = colorName;
    colorlb.font = cellLabelFont;
    colorlb.textColor = cellLabelColor;
    colorlb.textAlignment = NSTextAlignmentLeft;
    colorlb.lineBreakMode = NSLineBreakByTruncatingTail;
    [cellItem.contentView addSubview:colorlb];
    return cellItem;
}

@end
