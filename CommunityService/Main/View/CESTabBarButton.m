//
//  CESTabBarButton.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESTabBarButton.h"

//设置图片的宽度
#define IMAGEGWIDTH 22.5

@interface CESTabBarButton()

@property (nonatomic, strong) UIButton *badgeButton;

@end

@implementation CESTabBarButton

//设置文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+5, self.frame.size.width, 13);
}

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    
    return CGRectMake((self.frame.size.width-IMAGEGWIDTH)/2, 8, IMAGEGWIDTH, IMAGEGWIDTH);
}

//去除高亮状态
- (void)setHighlighted:(BOOL)highlighted {
    
}

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel sizeToFit];
        
        self.badgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.badgeButton.userInteractionEnabled = NO;
        self.badgeButton.clipsToBounds = YES;
        self.badgeButton.backgroundColor = [UIColor redColor];
        self.badgeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.badgeButton];
        self.badgeStyle = TabItemBadgeStyleNone;
    }
    return self;
}

- (void)setIsHideBadgeBtn:(BOOL)isHideBadgeBtn{
    
    _isHideBadgeBtn = isHideBadgeBtn;
    if (isHideBadgeBtn) {
        self.badgeButton.hidden = YES;
    }else{
        self.badgeButton.hidden = NO;
    }
}

- (void)setBadge:(NSInteger)badge{
    
    _badge = badge;
    [self updateBadge];
}

- (void)setBadgeStyle:(TabItemBadgeStyle)badgeStyle {
    _badgeStyle = badgeStyle;
    [self updateBadge];
}

- (void)updateBadge{
    
    switch (self.badgeStyle) {
        case TabItemBadgeStyleNone:{
            self.badgeButton.hidden = YES;
        }
            break;
        case TabItemBadgeStyleNumber:{
            [self setTabItemBadgeStyleNumber];
        }
            break;
        case TabItemBadgeStyleDot:{
            [self setTabItemBadgeStyleDot];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setTabItemBadgeStyleNumber{
    
    if (self.badge == 0){
        self.badgeButton.hidden = YES;
        return;
    };
    
    NSString *badgeStr = @(self.badge).stringValue;
    if (self.badge > 99) {
        badgeStr = @"99+";
    } else if (self.badge < -99) {
        badgeStr = @"-99+";
    }
    // 计算badgeStr的size
    CGSize size = [badgeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName : self.badgeButton.titleLabel.font}
                                         context:nil].size;
    // 计算badgeButton的宽度和高度
    CGFloat width = ceilf(size.width) +6;
    CGFloat height = ceilf(size.height) + 2;
    
    // 宽度取width和height的较大值，使badge为个位数时，badgeButton为圆形
    width = MAX(width, height);
    
    self.badgeButton.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)- width*0.5+5,2,width,height);
    self.badgeButton.layer.cornerRadius = self.badgeButton.bounds.size.height / 2;
    [self.badgeButton setTitle:badgeStr forState:UIControlStateNormal];
    self.badgeButton.hidden = NO;
}

- (void)setTabItemBadgeStyleDot{
    
    [self.badgeButton setTitle:nil forState:UIControlStateNormal];
    self.badgeButton.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame),5,10,10);
    self.badgeButton.layer.cornerRadius = self.badgeButton.bounds.size.height / 2;
    self.badgeButton.hidden = NO;
    
}

@end
