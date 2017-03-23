//
//  CESTabBarView.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESTabBarView.h"
#import "CESTabBarButton.h"

@interface CESTabBarView()

@property (nonatomic,weak)UIButton *selecteBtn;

@end

@implementation CESTabBarView

- (void)setControllers:(NSArray *)controllers{
    
    _controllers = controllers;
    
    CGFloat viewW = self.frame.size.width/controllers.count;
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < _controllers.count; i++) {
        
        UIViewController *vc = _controllers[i];
        CESTabBarButton *btn = [[CESTabBarButton alloc]initWithFrame:CGRectMake(viewW *i, 0, viewW, 49)];
        btn.tag = 100+i;
        //设置图片
        [btn setImage:vc.tabBarItem.image forState:UIControlStateNormal];
        [btn setImage:vc.tabBarItem.selectedImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置字体的颜色
        [btn setTitle:vc.tabBarItem.title forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        [btn setTitleColor:kNavigationBarBg forState:UIControlStateSelected];
        
        if (btn.tag == 100) {
            
            btn.selected = YES;
            self.selecteBtn = btn;
        }
        [self addSubview:btn];
        [items addObject:btn];
    }
    
    self.items = items;
    
}

- (void)btnClick:(UIButton *)btn{
    
    if ([self.selectTabarItmDelegate respondsToSelector:@selector(selectTabarItem:)]) {
        
        [self.selectTabarItmDelegate selectTabarItem:btn.tag];
    }
    
    if (!btn.selected) {
        btn.selected = YES;
        self.selecteBtn.selected = NO;
        self.selecteBtn = btn;
    }
    self.block(btn.tag - 100);
    
    if (_block) {
        self.block(btn.tag - 100);
    }
}


@end
