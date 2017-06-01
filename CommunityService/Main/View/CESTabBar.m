
//
//  CESTabBar.m
//  CommunityService
//
//  Created by lujh on 2017/4/26.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "CESTabBar.h"

@implementation CESTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.width/5.0;
    
    UIButton *publishBtn = [[UIButton alloc] init];
    [publishBtn setImage:[UIImage imageNamed:@"tabar_plus_normal"] forState:UIControlStateNormal];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [publishBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.adjustsImageWhenHighlighted = NO;
    publishBtn.size = CGSizeMake(w, 70);
    publishBtn.centerX = self.width / 2;
    publishBtn.centerY = 12;
    [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:publishBtn];
    self.publishBtn = publishBtn;
    
    [publishBtn setImagePositionWithType:SSImagePositionTypeTop spacing:5];
    
    
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / 5.0;
            view.x = self.width * j / 5.0;
            
            j++;
            if (j == 2) {
                j++;
            }
        }
    }
    
}

// 点击发布
- (void) didClickPublishBtn:(UIButton*)sender {
    //    NSLog(@"点击了发布");
    if (self.didClickPublishBtn) {
        self.didClickPublishBtn();
    }
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.publishBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.publishBtn pointInside:newP withEvent:event]) {
            return self.publishBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        
        return [super hitTest:point withEvent:event];
    }
}

@end
