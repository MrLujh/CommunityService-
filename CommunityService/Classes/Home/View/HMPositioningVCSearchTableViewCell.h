//
//  HMPositioningVCSearchTableViewCell.h
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPositioningModel.h"

@interface HMPositioningVCSearchTableViewCell : UITableViewCell
// 时钟图标
@property(nonatomic,strong)UIImageView *iconImageView;
// 地址名
@property(nonatomic,strong)UILabel *titleLabel;
// 地址区县
@property(nonatomic,strong)UILabel *subtitleLabel;
// NSIndexPath
@property(nonatomic,strong)NSIndexPath *indexPath;
// 地址模型
@property(nonatomic,strong)HMPositioningModel *hmpositioningModel;

@end
