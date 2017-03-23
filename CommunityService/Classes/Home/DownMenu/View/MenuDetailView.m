//
//  MenuDetailView.m
//  tableView悬浮
//
//  QQ:287929070
//  Created by lujh on 16/4/19.
//  Copyright © 2016年 lujh. All rights reserved.
//  QQ:287929070
//
#import "MenuDetailView.h"
#import "MenuDataModel.h"
#import "MJExtension.h"
#import "MenuRightDataModel.h"

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

static CGFloat const kMenuItemVeiwHeiht = 44.0f;

@interface MenuDetailView () <UITableViewDelegate,UITableViewDataSource>
/**本界面的尺寸*/
@property (nonatomic,assign)CGSize menuViewSize;
/**承载具体的筛选界面的View*/
@property (nonatomic,strong) UIView * mainView;
/**只有一个表格时*/
@property (nonatomic,strong) UITableView * singleTableView;
/**数据源 */
@property (nonatomic,strong) NSMutableArray * dataSource;
/**<#condition#>*/
@property (nonatomic,strong) UITableView * leftTableView;
/**<#condition#>*/
@property (nonatomic,strong) UITableView * rightTableView;
/**右边Table的详细的总数据源*/
@property (nonatomic,strong) NSMutableArray * rightDataSource;
/**右边所有类目的数据源*/
//@property (nonatomic,strong) NSMutableArray * rightTableTotolCategoryArray;
/**左边的Table的索引*/
@property (nonatomic,strong) NSIndexPath * leftIndexPath;

@end

@implementation MenuDetailView
+ (instancetype)MenuDetailViewWithSize:(CGSize)size{
    MenuDetailView * maskView = [[[NSBundle mainBundle] loadNibNamed:@"MenuDetailView" owner:nil options:nil]lastObject];
    maskView.width = size.width;
    maskView.height = size.height;
    maskView.menuViewSize = size;
    return maskView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = RGBA(0, 0, 0, 0.3);
    [self configMainView];
}

#pragma mark - 创建主要的承载筛选界面的View
- (void)configMainView{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.mainView = view;
    [self addSubview:view];
    
    
}

- (void)setMenuType:(MenuDropType)menuType{
    _menuType = menuType;
    if (menuType == MenuDropTypeSingleCol) {
        [self configSingleTableView];
    } else {
        [self configCoupleTableVeiw];
    }
}

#pragma mark - 创建singleTableView
- (void)configSingleTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = kMenuItemVeiwHeiht;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.mainView addSubview:tableView];
    self.singleTableView = tableView;
}

#pragma mark - 创建两个联动的TableView
- (void)configCoupleTableVeiw{
    /**左边的TableView*/
    UITableView * leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.rowHeight = kMenuItemVeiwHeiht;
    [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell_left"];
    [self.mainView addSubview:leftTableView];
    self.leftTableView = leftTableView;
    /**右边的tableVeiw*/
    UITableView * rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = kMenuItemVeiwHeiht;
    [rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell_right"];
    [self.mainView addSubview:rightTableView];
    self.rightTableView = rightTableView;
}

#pragma mark - setter方法处理数据源
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (self.dataSource.count) {
        [self.dataSource removeAllObjects];
    }
    if (self.rightDataSource.count) {
        [self.rightDataSource removeAllObjects];
    }
    /**只有一个table的时候*/
    if (self.menuType == MenuDropTypeSingleCol) {
        for (int i = 0; i < dataArray.count; i++) {
            MenuDataModel * model = [[MenuDataModel alloc] init];
            model.title = dataArray[i];
            model.isSelectedItem = NO;
            if ([model.title isEqualToString:self.menuBtnTitle]) {
                model.isSelectedItem = YES;
            }
            [self.dataSource addObject:model];
        }
        [self.singleTableView reloadData];
    }
    /**两个视图的时候*/
    else {
        for (NSDictionary * dict in dataArray) {
            MenuDataModel * model = [[MenuDataModel alloc] init];
            model.title = [dict.allKeys lastObject];
            model.rightTableData = [dict.allValues lastObject];
            
            model.isSelectedItem = NO;
            
            if ([model.title isEqualToString:self.seletedLeftString]) {
                model.isSelectedItem = YES;
            }
            
            [self.dataSource addObject:model];
        }
        /**默认先取 [self.dataSource  的第一个 元素里的   value 作为第二表格的数据源*/
        MenuDataModel * model = (MenuDataModel*)self.dataSource[self.leftTabIndex];
        for (int i = 0; i < model.rightTableData.count; i++) {
            MenuRightDataModel * rightDataModel = [[MenuRightDataModel alloc] init];
            rightDataModel.title = model.rightTableData[i];
            rightDataModel.isSelectedItem = NO;
            if ([rightDataModel.title isEqualToString:self.menuBtnTitle]) {
                rightDataModel.isSelectedItem = YES;
            }
            [self.rightDataSource addObject:rightDataModel];
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.singleTableView || tableView == self.leftTableView) {
        return self.dataSource.count;
    } else {
        return self.rightDataSource.count;
    }
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.menuType == MenuDropTypeSingleCol) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if (self.dataSource.count) {
            MenuDataModel * model = self.dataSource[indexPath.row];
            cell.textLabel.text = model.title;
            UIColor * color = model.isSelectedItem ? kNavigationBarBg : [UIColor blackColor];
            cell.textLabel.textColor = color;
        }
        return cell;
    } else if (tableView == self.leftTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_left" forIndexPath:indexPath];
        if (self.dataSource.count) {
            MenuDataModel * model = self.dataSource[indexPath.row];
            cell.textLabel.text = model.title;
            UIColor * color = model.isSelectedItem ? kNavigationBarBg : [UIColor blackColor];
            cell.textLabel.textColor = color;
        }
        return cell;
    } else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_right" forIndexPath:indexPath];
        if (self.rightDataSource.count) {
            MenuRightDataModel * rightModel = self.rightDataSource[indexPath.row];
            UIColor * color = rightModel.isSelectedItem ? kNavigationBarBg : [UIColor blackColor];
            cell.textLabel.text = rightModel.title;
            cell.textLabel.textColor = color;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.menuType == MenuDropTypeSingleCol) {
        /**处理单个表格*/
        if ([self.delegate respondsToSelector:@selector(selectedMenuItemWitnMenuIndex:dataModel:indexPath:)]) {
            MenuDataModel * model = self.dataSource[indexPath.row];
            [self.delegate selectedMenuItemWitnMenuIndex:self.menuIndex dataModel:model indexPath:indexPath];
        }
        /**消失视图*/
        [self JKchangeMenuViewBtnsStatus];
        [self JKHandleIsExpendMenuView];
        [self removeFromSuperview];
    } else {
        /**处理多个表格*/
        if (tableView == self.leftTableView) {
            for (MenuDataModel * model in self.dataSource) {
                if (model.isSelectedItem == YES) {
                    model.isSelectedItem = NO;
                }
            }
            MenuDataModel * model = self.dataSource[indexPath.row];
            model.isSelectedItem = YES;
            [self.rightDataSource removeAllObjects];
            for (int i = 0; i < model.rightTableData.count; i++) {
                MenuRightDataModel * rightDataModel = [[MenuRightDataModel alloc] init];
                rightDataModel.title = model.rightTableData[i];
                rightDataModel.isSelectedItem = NO;
                [self.rightDataSource addObject:rightDataModel];
            }
            /**记住左边的table 的索引*/
            self.leftIndexPath = indexPath;
            [self.rightTableView reloadData];
            [self.leftTableView reloadData];
        } else if (tableView == self.rightTableView) {
            NSLog(@" -----  self.leftTableIndex == %zd",self.leftIndexPath.row);
            
            MenuDataModel * lastSelectedModel = self.dataSource[self.leftIndexPath.row];
            MenuRightDataModel * rightTableDataModel = self.rightDataSource[indexPath.row];
            if ([self.delegate respondsToSelector:@selector(selectedLeftTableWithMenuIndex: leftDataModel: leftTableIndexPath: rightDataModel: rightDataIndexPath:)]) {
                [self.delegate selectedLeftTableWithMenuIndex:self.menuIndex leftDataModel:lastSelectedModel leftTableIndexPath:self.leftIndexPath rightDataModel:rightTableDataModel rightDataIndexPath:indexPath];
            }
            
            /**消失视图*/
            [self JKchangeMenuViewBtnsStatus];
            [self JKHandleIsExpendMenuView];
            [self removeFromSuperview];
        }
    }
}

#pragma mark - 控制界面的动画显示以及视图尺寸的设计
- (void)changeMainViewWithAnimateClickTheSameBtn:(BOOL)isSame{
    if (isSame == NO) {
        self.mainView.frame = CGRectMake(0, 0, self.menuViewSize.width, 0);
        CGFloat height = 0;
        CGFloat tempHeight = self.menuViewSize.height * 2/3;
        CGFloat tableHeight = 0;
        
        if (self.menuType ==  MenuDropTypeSingleCol) {
            self.singleTableView.frame = CGRectMake(0, 0, self.menuViewSize.width, 0);
            tableHeight = kMenuItemVeiwHeiht * self.dataArray.count;
        } else {
            self.leftTableView.frame = CGRectMake(0, 0, self.menuViewSize.width * 1 / 3, 0);
            self.rightTableView.frame = CGRectMake(self.menuViewSize.width * 1 / 3, 0, self.menuViewSize.width * 2 / 3, 0);
            NSInteger tempNum = 0;
            NSInteger leftTableNum = self.dataSource.count;
            MenuDataModel * model = (MenuDataModel*)[self.dataSource firstObject];
            NSInteger rightTableNum = model.rightTableData.count;
            tempNum = MAX(leftTableNum, rightTableNum);
            tableHeight = kMenuItemVeiwHeiht * tempNum;
        }
        
        if (tableHeight< tempHeight) {
            height = tableHeight;
        } else {
            height = tempHeight;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.mainView.frame = CGRectMake(0, 0, self.menuViewSize.width, height);
            if (self.menuType == MenuDropTypeSingleCol) {
                self.singleTableView.frame = CGRectMake(0, 0, self.menuViewSize.width, height);
            } else {
                self.leftTableView.frame = CGRectMake(0, 0, self.menuViewSize.width * 1 / 3, height);
                self.rightTableView.frame = CGRectMake(self.menuViewSize.width * 1 / 3, 0, self.menuViewSize.width * 2 / 3, height);
            }
        } completion:^(BOOL finished) {
            /**动画结束时候告知MenuDrop，menuDetailView是展开的状态*/
            if ([self.delegate respondsToSelector:@selector(menuViewExpendStatus:)]) {
                BOOL isExpend = YES;
                [self.delegate menuViewExpendStatus:isExpend];
            }
        }];
    } else {
        [self JKchangeMenuViewBtnsStatus];
        [UIView animateWithDuration:0.3 animations:^{
            self.mainView.frame = CGRectMake(0, 0, self.menuViewSize.width, 0);
            if (self.menuType == MenuDropTypeSingleCol) {
                self.singleTableView.frame = CGRectMake(0, 0, self.menuViewSize.width, 0);
            } else {
                self.leftTableView.frame = CGRectMake(0, 0, self.menuViewSize.width * 1 / 3, 0);
                self.rightTableView.frame = CGRectMake(self.menuViewSize.width * 1 / 3, 0, self.menuViewSize.width * 2 / 3, 0);
            }
            self.hidden = YES;
        } completion:^(BOOL finished) {
            /**动画结束时候告知MenuDrop，menuDetailView是闭合的状态*/
            if ([self.delegate respondsToSelector:@selector(menuViewExpendStatus:)]) {
                BOOL isExpend = NO;
                [self.delegate menuViewExpendStatus:isExpend];
            }
            [self removeFromSuperview];
        }];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self JKchangeMenuViewBtnsStatus];
    [self JKHandleIsExpendMenuView];
    [self removeFromSuperview];
}

- (void)JKchangeMenuViewBtnsStatus{
    if ([self.delegate respondsToSelector:@selector(changeMenuBtnSelectedStatus)]) {
        [self.delegate changeMenuBtnSelectedStatus];
    }
}

- (void)JKHandleIsExpendMenuView{
    /**动画结束时候告知MenuDrop，menuDetailView是闭合的状态*/
    if ([self.delegate respondsToSelector:@selector(menuViewExpendStatus:)]) {
        BOOL isExpend = NO;
        [self.delegate menuViewExpendStatus:isExpend];
    }
}

- (void)dealloc{
    NSLog(@"遮罩视图被释放了");
}
#pragma mark - lazy
/**单个表格的数据源与左边Table的数据源*/
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

/**右边表格的数据源*/
- (NSMutableArray *)rightDataSource{
    if (_rightDataSource == nil) {
        _rightDataSource = [NSMutableArray new];
    }
    return _rightDataSource;
}

@end
