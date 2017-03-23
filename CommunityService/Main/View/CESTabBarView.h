//
//  CESTabBarView.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CESTabBarButton.h"

@protocol SelectTabarItmDelegate <NSObject>

- (void)selectTabarItem:(NSInteger)tag;

@end

typedef void (^Block)(NSInteger integer);

@interface CESTabBarView : UIView


@property (nonatomic,strong)NSArray *controllers;

@property (nonatomic, copy) NSArray <CESTabBarButton *> *items;

@property (nonatomic,copy)Block block;

@property(nonatomic,assign)id <SelectTabarItmDelegate> selectTabarItmDelegate;


@end
