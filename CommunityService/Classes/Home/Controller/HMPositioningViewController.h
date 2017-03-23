//
//  HMPositioningViewController.h
//  CommunityService
//
//  Created by lujh on 2017/1/3.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "CESBaseViewController.h"
@protocol RefreshLocationDelegate <NSObject>

-(void)refreshLocation:(NSString*)location;

@end

@interface HMPositioningViewController : CESBaseViewController

typedef void (^RefreshLocation)(id params);

@property(nonatomic,copy)NSString *isFrom;

@property(nonatomic,strong) id<RefreshLocationDelegate>  refreshLocationDelegate;

@property(nonatomic,copy)RefreshLocation refreshLocation;

@end
