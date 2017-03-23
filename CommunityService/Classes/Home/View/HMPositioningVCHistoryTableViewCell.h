//
//  HMPositioningVCHistoryTableViewCell.h
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPositioningVCHistoryTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableDictionary *dic;

// 时钟图标
@property(nonatomic,strong)UIImageView *iconImageView;
// 地址名
@property(nonatomic,strong)UILabel *titleLabel;

// cell分隔线
@property(nonatomic,strong)UIView *lineView;

-(void)setDic:(NSMutableDictionary *)dic;

@end
