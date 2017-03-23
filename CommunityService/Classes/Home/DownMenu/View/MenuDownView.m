//
//  MenuDownView.m
//  tableView悬浮
//
//  QQ:287929070
//  Created by lujh on 16/4/19.
//  Copyright © 2016年 lujh. All rights reserved.
//  QQ:287929070
//

#import "MenuDownView.h"
#import "MenuDetailView.h"
#import "MenuDataModel.h"
#import "MenuRightDataModel.h"

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

static NSInteger const kMenuBtnTempTag = 10000;
static NSInteger const kLineTag = 500;

@interface MenuDownView () <MenuDetailViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuBgView;

/**控件的尺寸大小*/
@property (nonatomic,assign) CGSize menuSize;
/**标记目前选中的MenuBtn*/
@property (nonatomic,assign) NSInteger tempSelectedBtnIndex;
/**singleTable的indexPath*/
@property (nonatomic,strong) NSIndexPath * singleTableIndexPath;
/**菜单的主界面是否展开*/
@property (nonatomic,assign) BOOL isExpend;
/**两个视图时候左边的索引*/
@property (nonatomic,assign) NSInteger leftTabIndex;
/**左边视图被选中的String*/
@property (nonatomic,copy) NSString * leftSelectedString;
@end


@implementation MenuDownView

+(instancetype)MenuDropViewWithSize:(CGSize)size{
    MenuDownView * view = [[[NSBundle mainBundle] loadNibNamed:@"MenuDownView" owner:nil options:nil]lastObject];
    view.width = size.width;
    view.height = size.height;
    view.menuSize = size;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setDelegate:(id<MenuDropViewDelegate>)delegate{
    _delegate = delegate;
    NSInteger totolCol = [delegate numOfColInMenuView];
    NSLog(@"---%zd",totolCol);
    
    for (UIView * subView in self.menuBgView.subviews) {
        if (subView.tag == kLineTag) {
            [subView removeFromSuperview];
        }
    }
    
    /**创建Btn*/
    CGFloat line_Y = 5;
    CGFloat line_Temp_X = self.menuSize.width/totolCol;
    CGFloat line_Height = self.menuSize.height - line_Y * 2;
    
    for (int i = 0; i < totolCol - 1; i++) {
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(line_Temp_X*(1 + i), line_Y, 0.5, line_Height)];
        line.tag = kLineTag;
        line.backgroundColor = [UIColor lightGrayColor];
        [self.menuBgView addSubview:line];
    }
}

#pragma mark - Setter方法 菜单的标题
- (void)setMenuTitles:(NSArray *)menuTitles{
    _menuTitles = menuTitles;
    
    if (menuTitles.count) {
        
        for (UIView * subView in self.menuBgView.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                [subView removeFromSuperview];
            }
        }
        /**创建Btn*/
        CGFloat btn_Y = 0.5;
        CGFloat btn_Width = self.menuSize.width/menuTitles.count;
        CGFloat btn_Height = self.menuSize.height - 1.0;
        CGFloat btn_Img_Width_Height = 5.0f;
        
        CGFloat font = 0;
        if ([UIScreen mainScreen].bounds.size.width < 375.0f) {
            font = 11.0f;
        } else {
            font = 13.0f;
        }
        
        for (int i = 0; i < menuTitles.count; i ++) {
            CGFloat btn_X = btn_Width * i;
            UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            menuBtn.frame = CGRectMake(btn_X, btn_Y, btn_Width, btn_Height);
            menuBtn.tag = kMenuBtnTempTag + i;
            menuBtn.selected = NO;
            menuBtn.titleLabel.font = [UIFont systemFontOfSize:font];
            [menuBtn setTitle:menuTitles[i] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [menuBtn setTitleColor:kNavigationBarBg forState:UIControlStateSelected];
            [menuBtn setImage:[UIImage imageNamed:@"home_menu_down"] forState:UIControlStateNormal];
            [menuBtn setImage:[UIImage imageNamed:@"home_menu_up"] forState:UIControlStateSelected];
            menuBtn.adjustsImageWhenHighlighted = NO;
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake((btn_Height - btn_Img_Width_Height)/2, btn_Width - 15, (btn_Height - btn_Img_Width_Height)/2, 5);
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchDown];
            [self.menuBgView addSubview:menuBtn];
        }
    }
}


#pragma mark - 菜单按钮的点击事件

- (void)menuBtnAction:(UIButton *)button{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kSetTableViewContentInsetNSNotification" object:nil];
    
    NSInteger btnIndex = button.tag - kMenuBtnTempTag;
    button.selected = YES;
    
    NSString * btnTitle = [button titleForState:UIControlStateNormal];
    /******************************************************************************/
    /**遮罩视图相关*/
    for (UIView * subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[MenuDetailView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat kMaskMargin = self.menuSize.height + 64;
    CGSize maskViewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kMaskMargin);
    MenuDetailView * maskView = [MenuDetailView MenuDetailViewWithSize:maskViewSize];
    maskView.frame = CGRectMake(0, kMaskMargin,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kMaskMargin);
    maskView.delegate = self;
    maskView.menuIndex = btnIndex;
    //    maskView.singleIndexPath = self.singleTableIndexPath;
    
    if ([self.delegate respondsToSelector:@selector(MenuItemTypeForRowsAtMenuBtnIndex:)]) {
        if ([self.delegate MenuItemTypeForRowsAtMenuBtnIndex:btnIndex] == MenuItemTypeSingle) {
            maskView.menuType = MenuDropTypeSingleCol;
            maskView.menuBtnTitle = btnTitle;
        } else {
            maskView.leftTabIndex = self.leftTabIndex;
            maskView.seletedLeftString = self.leftSelectedString;
            maskView.menuBtnTitle = btnTitle;
            maskView.menuType = MenuDropTypeTwoCol;
        }
    } else {
        maskView.menuType = MenuDropTypeSingleCol;
        maskView.menuBtnTitle = btnTitle;
    }
    
    if ([self.delegate respondsToSelector:@selector(MenuDataSourceAtMenuBtnIndex:)]) {
        NSArray * dataArray = [self.delegate MenuDataSourceAtMenuBtnIndex:btnIndex];
        maskView.dataArray = dataArray;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    /******************************************************************************/
    if (btnIndex != self.tempSelectedBtnIndex) {
        UIButton * tempBtn = (UIButton *)[self.menuBgView viewWithTag:self.tempSelectedBtnIndex+kMenuBtnTempTag];
        tempBtn.selected = NO;
        self.tempSelectedBtnIndex = btnIndex;
        button.selected = YES;
        [maskView changeMainViewWithAnimateClickTheSameBtn:NO];
        
    } else {
        NSLog(@"在此点击了相同的按钮");
        [maskView changeMainViewWithAnimateClickTheSameBtn:self.isExpend];
    }
}


#pragma mark - MenuDetailViewDelegate 改变menuBtn的选中状态
/************************MenuDetailViewDelegate代理部分****************************/
- (void)changeMenuBtnSelectedStatus{
    for (UIView * subView in self.menuBgView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)subView;
            if (btn.selected) {
                btn.selected = NO;
            }
        }
    }
}

#pragma mark - 单个表格点击的回调
- (void)selectedMenuItemWitnMenuIndex:(NSInteger)menuIndex dataModel:(MenuDataModel *)model indexPath:(NSIndexPath *)indexPath{
    NSLog(@"\nmenuIndex == %zd\n model == %@\n indexPath == %@\n",menuIndex,model,indexPath);
    
    NSInteger hasSelectedBtnTag = menuIndex + kMenuBtnTempTag;
    UIButton * hasSelectedBtn = (UIButton*)[self viewWithTag:hasSelectedBtnTag];
    
    /**选中的Item*/
    NSString * menuItem = model.title;
    
    [hasSelectedBtn setTitle:menuItem forState:UIControlStateNormal];
    self.singleTableIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(MenuDidSelectedItemWithMenuBtnIndex:menuItem: leftMenuItemString:)]) {
        [self.delegate MenuDidSelectedItemWithMenuBtnIndex:menuIndex menuItem:menuItem leftMenuItemString:@"Just exist singleTable"];
    }
}

/**
 当有两个表格的时候的回调,且此方法必须实现
 
 @param menuIndex      menuBtn的索引
 @param leftDataModel  左边数据源的模型
 @param leftIndexPath  左边Table的索引
 @param rightDataModel 右边数据源的模型
 @param rightIndexPath 右边数据源的索引
 */
- (void)selectedLeftTableWithMenuIndex:(NSInteger)menuIndex leftDataModel:(MenuDataModel *)leftDataModel leftTableIndexPath:(NSIndexPath *)leftIndexPath rightDataModel:(MenuRightDataModel *)rightDataModel rightDataIndexPath:(NSIndexPath *)rightIndexPath{
    NSLog(@"\nmenuIndex === %zd\n  leftSelectedModel == %@\n  leftTableIndexPath == %@ \n rightTableData == %@ \n  rightTableIndexPath == %@\n",menuIndex,leftDataModel,leftIndexPath,rightDataModel,rightIndexPath);
    
    NSInteger hasSelectedBtnTag = menuIndex + kMenuBtnTempTag;
    UIButton * hasSelectedBtn = (UIButton*)[self viewWithTag:hasSelectedBtnTag];
    /**选中的Item*/
    NSString * menuItem = rightDataModel.title;
    
    [hasSelectedBtn setTitle:menuItem forState:UIControlStateNormal];

    self.leftTabIndex = leftIndexPath.row;
    self.leftSelectedString = leftDataModel.title;
    
    
    if ([self.delegate respondsToSelector:@selector(MenuDidSelectedItemWithMenuBtnIndex:menuItem: leftMenuItemString:)]) {
        [self.delegate MenuDidSelectedItemWithMenuBtnIndex:menuIndex menuItem:menuItem leftMenuItemString:self.leftSelectedString];
    }
    
}

- (void)menuViewExpendStatus:(BOOL)isExpend{
    self.isExpend = isExpend;
}
/************************MenuDetailViewDelegate代理部分结束****************************/
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
