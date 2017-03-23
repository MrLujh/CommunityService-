//
//  HMPositioningVCSearchTableViewCell.m
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "HMPositioningVCSearchTableViewCell.h"

@implementation HMPositioningVCSearchTableViewCell

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
    self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 14, 16)];
    self.iconImageView.image = [UIImage imageNamed:@"mypage_list_icon_location"];
    [self.contentView addSubview:self.iconImageView];
    
    // 地址名
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.right+5, 5, KUIScreenWidth -40, 16)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    self.titleLabel.textColor = Theme_ContentColor_M;
    [self.contentView addSubview:self.titleLabel];
    
    // 地址区县
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, KUIScreenWidth -40, 20)];
    [self.subtitleLabel setFont:[UIFont systemFontOfSize:11]];
    self.subtitleLabel.textColor = Theme_ContentColor_S;
    self.subtitleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.subtitleLabel];
    
}

#pragma mark -cell数据更新
/**
 *  cell数据更新
 *
 *  @param hmpositioningModel 模型数据
 */
-(void)setHmpositioningModel:(HMPositioningModel *)hmpositioningModel {

    _hmpositioningModel = hmpositioningModel;

    self.iconImageView.image = [UIImage imageNamed:@"address_icon"];
    self.titleLabel.textColor = Theme_ContentColor_M;
    self.subtitleLabel.textColor = Theme_ContentColor_S;
    
    self.titleLabel.text = hmpositioningModel.name;
    
    self.subtitleLabel.text  = hmpositioningModel.address;

}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.indexPath.row == 0) {
        
        self.titleLabel.text = [NSString  stringWithFormat:@"[当前]%@",_hmpositioningModel.name];
        
        self.iconImageView.image = [UIImage imageNamed:@"cur_location"];
        self.titleLabel.textColor = kNavigationBarBg;
        self.subtitleLabel.textColor = Theme_ContentColor_M;
        
    }
}


@end
