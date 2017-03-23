//
//  HMPositioningVCHistoryTableViewCell.m
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "HMPositioningVCHistoryTableViewCell.h"

@implementation HMPositioningVCHistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 初始化cell布局
        [self setupSubViews];
    }
    
    return  self;
}

#pragma mark -初始化cell布局

-(void)setupSubViews{
    
    // 时钟图标
    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 20, 20)];
    self.iconImageView.image = [UIImage imageNamed:@"time_icon"];
    [self.contentView addSubview:self.iconImageView];
    
    // 地址名
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(self.iconImageView.right +5, 0, KUIScreenWidth -40, self.iconImageView.height);
    CGPoint iconImageViewPoint = self.iconImageView.center;
    CGPoint titlePoint = self.titleLabel.center;
    titlePoint.y = iconImageViewPoint.y;
    [self.titleLabel setCenter:titlePoint];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.titleLabel.textColor = Theme_ContentColor_M;
    [self.contentView addSubview:self.titleLabel];
    
    // cell分隔线
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = CGRectMake(0, self.iconImageView.bottom +10, KUIScreenWidth, 1);
    self.lineView.backgroundColor = Theme_LineColor;
    [self.contentView addSubview:self.lineView];
}

#pragma mark -cell数据更新
/**
 *  cell数据更新
 *
 *  @param dic 模型数据
 */
-(void)setDic:(NSMutableDictionary *)dic {


    _dic = dic;
    
    self.titleLabel.text = _dic[@"title"];

}

@end
