//
//  HMPositioningModel.h
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMPositioningModel : NSObject
//省
@property(nonatomic,copy)NSString *province;
//市
@property(nonatomic,copy)NSString *city;
//区
@property(nonatomic,copy)NSString *district;
//街道
@property(nonatomic,copy)NSString *address;
//详细地名
@property(nonatomic,copy)NSString *name;
//纬度
@property(nonatomic,assign)CGFloat lat;
//经度
@property(nonatomic,assign)CGFloat lon;

@end
