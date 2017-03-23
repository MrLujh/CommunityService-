//
//  MenuDownView.h
//  tableView悬浮
//
//  QQ:287929070
//  Created by lujh on 16/4/19.
//  Copyright © 2016年 lujh. All rights reserved.
//  QQ:287929070
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuItemType) {
    MenuItemTypeSingle = 0,          /**一个tableView*/
    MenuItemTypeCouple              /**两个TableVeiw*/
};

@protocol MenuDropViewDelegate <NSObject>

@required
/**
 一共有几个Btn

 @return Btn的个数
 */
- (NSInteger)numOfColInMenuView;

@optional
/**
 获取Single点击的Item

 @param menuBtnIndex meunBtn 的索引
 @param menuString  点击的ItemString
 */
- (void)MenuDidSelectedItemWithMenuBtnIndex:(NSInteger)menuBtnIndex menuItem:(NSString*)menuString leftMenuItemString:(NSString *)leftItemString;
@required
/**
 每一列的数据源

 @param menuBtnIndex MenuBtn的索引

 @return 每一列的数据源
 */
- (NSArray*)MenuDataSourceAtMenuBtnIndex:(NSInteger)menuBtnIndex;

@optional

/**
 注意：如果实现此方法 且 对应的menuBtnIndex  的MenuItemType为MenuItemTypeCouple  其数据格式必须为@[@{@"Jackie == 0" : @[@"Jackie == 0 --- 1",
                            @"Jackie == 0 --- 2",
                            @"Jackie == 0 --- 3",
                            @"Jackie == 0 --- 4"]}];否则该工具不可使用

 @param menuBtnIndex 点击的第几个btnIndex

 @return MenuView的类型
 */
- (MenuItemType)MenuItemTypeForRowsAtMenuBtnIndex:(NSInteger)menuBtnIndex;

@end

@interface MenuDownView : UIView

/**
 创建菜单视图的构造方法

 @param size 菜单视图的大小尺寸

 @return MenuDropView
 */
+ (instancetype)MenuDropViewWithSize:(CGSize)size;

/**菜单的主标题*/
@property (nonatomic,strong) NSArray * menuTitles;

@property (nonatomic,weak)id <MenuDropViewDelegate> delegate;

/**
 刷新数据 ： 下一阶段完善
 */
//- (void)reloadData;

@end
