//
//  HomeViewController.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//
#define TableViewSectionHeaderHeight 636

#import "HomeViewController.h"
#import "HMPositioningViewController.h"
#import "CESNavigationController.h"
#import "MenuDownView.h"
#import "ServiceNormalCell.h"
#import "ServiceOnePicCell.h"
#import "ServiceLeftPicCell.h"
#import "ServicePicTwoTitleCell.h"
#import "HeaderCollectionViewCell.h"
#import "HeaderReusableView.h"
#import "FooterReusableView.h"
#import "CollectionViewLayout.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,RefreshLocationDelegate,MenuDropViewDelegate,SDCycleScrollViewDelegate, CollectionViewLayoutDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化tableView
    [self setupTableView];
    
    // 初始化轮播图
    [self setupBanerScrollview];
    
    // 初始化UICollectionView
    [self setupUICollectionView];
    
    // 初始化navigationBar
    [self setupNavigationBar];
    
    
    // 设置tableview的偏移量通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContenInset) name:@"kSetTableViewContentInsetNSNotification" object:nil];
    
}

#pragma mark -设置tableview的偏移量通知

- (void)setTableViewContenInset {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    

}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark -初始化tableView

- (void)setupTableView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, KUIScreenWidth, KUIScreenHeight -49);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    // tableView头视图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KUIScreenWidth, TableViewSectionHeaderHeight)];
    _headerView.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = _headerView;
}

#pragma mark -初始化轮播图

- (void)setupBanerScrollview {

    NSArray *imageNames = @[@"1",
                            @"2",
                            @"3",
                            @"4",
                            @"4",
                            @"5",
                            @"6",
                            @"7"
                            ];
    
    // 本地加载 --- 创建不带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KUIScreenWidth, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    [_headerView addSubview:self.cycleScrollView];
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;

}

#pragma mark -初始化UICollectionView

- (void)setupUICollectionView {
    
    CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, KUIScreenWidth, 456) collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [_headerView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[HeaderCollectionViewCell class] forCellWithReuseIdentifier:@"HeaderCollectionViewCell"];
    [self.collectionView registerClass:[ServiceNormalCell class] forCellWithReuseIdentifier:@"ServiceNormalCell"];
    [self.collectionView registerClass:[ServiceOnePicCell class] forCellWithReuseIdentifier:@"ServiceOnePicCell"];
    [self.collectionView registerClass:[ServicePicTwoTitleCell class] forCellWithReuseIdentifier:@"ServicePicTwoTitleCell"];
    [self.collectionView registerClass:[ServiceLeftPicCell class] forCellWithReuseIdentifier:@"ServiceLeftPicCell"];
    
    
    [self.collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeaderReusableView"];
    [self.collectionView registerClass:[FooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ServiceFooterReusableView"];
}

#pragma mark -初始化navigationBar

- (void)setupNavigationBar {
    
    // 导航栏背景view
    _navigationBackView = [[UIView alloc] init];
    _navigationBackView.frame = CGRectMake(0, 0, KUIScreenWidth, 64);
    [self.view addSubview:_navigationBackView];
    
    //左侧搜索按钮
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 17, 30, 30)];
    
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
    
    [_searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBackView addSubview:_searchButton];
    
    //定位view
    _locationView = [[UIView alloc] initWithFrame:CGRectMake(-(KUIScreenWidth-45), 17, KUIScreenWidth-80, 30)];
    _locationView.layer.cornerRadius = 15;
    _locationView.layer.masksToBounds = YES;
    _locationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] size:_locationView.size]];
    [_navigationBackView addSubview:_locationView];
    
    //定位lable
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(-(KUIScreenWidth-45), 17, KUIScreenWidth-80, 30)];
    _locationLabel.layer.cornerRadius = 15;
    _locationLabel.layer.masksToBounds = YES;
    _locationLabel.text = [NSString stringWithFormat:@"%@",[CESGetUserMessage getLocationAddress]];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.font = Theme_Font_16;
    [_navigationBackView addSubview:_locationLabel];
    
    
    UITapGestureRecognizer *locationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationTapClick)];
    [_locationView addGestureRecognizer:locationTap];
    
    
    //右侧按钮
    _emailButton = [[UIButton alloc] initWithFrame:CGRectMake(KUIScreenWidth-45, 17, 30, 30)];
    [_emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
    [_navigationBackView addSubview:_emailButton];
    
}

#pragma mark -UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(tableView == self.tableView && section == 0){
        return 44;
    }else{
        return 0;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(tableView == self.tableView && section == 0){
        
        
        CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
        CGSize size = CGSizeMake(deviceWidth, 44.0f);
        MenuDownView * menuView = [MenuDownView MenuDropViewWithSize:size];
        menuView.menuTitles = @[@"全部",@"附近",@"智能排序"];
        menuView.delegate = self;
        return menuView;
        
    }else {
        
        return nil;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第几%lu行",indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CATransform3D rotation;
    
    
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    cell.layer.transform = rotation;
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    //    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 1;
        
    }else {
        
        return 3;
        
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCollectionViewCell" forIndexPath:indexPath];
        
        return cell;
    }
    
    switch (indexPath.section) {
        
        case 1:
            if (indexPath.item == 0) {
                ServicePicTwoTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServicePicTwoTitleCell" forIndexPath:indexPath];
                return cell;
            } else {
                ServiceLeftPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceLeftPicCell" forIndexPath:indexPath];
                return cell;
            }
            break;
            
        default:
            return [UICollectionViewCell new];
            break;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ServiceHeaderReusableView" forIndexPath:indexPath];
        headerView.imgView.image = [UIImage imageNamed:@"ser_b1"];
        return headerView;
    } else {
        FooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ServiceFooterReusableView" forIndexPath:indexPath];
        return footerView;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    NSInteger section = indexPath.section;
    
    NSLog(@"section =%lu  row =%lu",section ,row);
    
}


#pragma mark -CollectionViewLayoutDelegate

-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    return 15;
}

-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 0;
        
    }else {
        
        return 50;
    }
    
}

#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat tableViewoffsetY = scrollView.contentOffset.y;
    
    UIColor * color = [UIColor whiteColor];
    CGFloat alpha = MIN(1, tableViewoffsetY/136);
    
    self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:alpha];
    
    if (tableViewoffsetY > 0) {
        
        [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    }else {
    
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if (tableViewoffsetY < 125){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _navigationBackView.backgroundColor = [UIColor clearColor];
            
            self.searchButton.hidden = NO;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
            
            self.locationView.frame = CGRectMake(-(KUIScreenWidth-60), 17, KUIScreenWidth-80, 30);
            
            if (self.locationStr.length > 0) {
                
            self.locationView.frame = CGRectMake(-(KUIScreenWidth-60), 17, self.locationSize.width +10, 30);
            }
            
            self.locationLabel.frame = self.locationView.frame;
            self.emailButton.alpha = 1-alpha;
            self.searchButton.alpha = 1-alpha;
            
            
        }];
    } else if (tableViewoffsetY >= 125){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _navigationBackView.backgroundColor = kNavigationBarBg;
            self.locationView.frame = CGRectMake((KUIScreenWidth - 200 )/2, 17, 200, 30);
            
            if (self.locationStr.length > 0) {
                
                self.locationView.frame = CGRectMake((KUIScreenWidth - self.locationSize.width )/2, 17, self.locationSize.width+10, 30);
            }
            
            self.locationLabel.frame = self.locationView.frame;
            self.searchButton.hidden = YES;
            self.emailButton.alpha = 1;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_red"] forState:UIControlStateNormal];
        }];
    }
}

#pragma mark -MenuDropViewDelegate

- (NSInteger)numOfColInMenuView{
    
    return 3;
}

- (NSArray *)MenuDataSourceAtMenuBtnIndex:(NSInteger)menuBtnIndex{
    
    if (menuBtnIndex == 0) {
        return @[@"全部",@"餐饮美食",@"商超便利",@"家政维修",@"宠物生活",@"汽车服务",@"休闲娱乐",@"亲子教育",@"美容美发",@"丽人"];
    } else if (menuBtnIndex == 1) {
        return @[@"附近",@"1km",@"3km",@"5km",@"10km"];
    } else if (menuBtnIndex == 2) {
        return @[@"智能排序",@"距离最近"];
    } else  {
        return nil;
    }
}

#pragma mark -选中的Item

- (void)MenuDidSelectedItemWithMenuBtnIndex:(NSInteger)menuBtnIndex menuItem:(NSString *)menuString leftMenuItemString:(NSString *)leftItemString{
    
    NSString * selectedString = [NSString stringWithFormat:@"\n输出如下:\n menuBtnIndex == %zd  \n menuString == %@  \n leftItemString == %@",menuBtnIndex,menuString,leftItemString];
}

#pragma mark -是单个TableView还是多个

- (MenuItemType)MenuItemTypeForRowsAtMenuBtnIndex:(NSInteger)menuBtnIndex{
    
//    if (menuBtnIndex == 0) {
//        
//        return MenuItemTypeCouple;
//        
//    } else {
//        
//        return MenuItemTypeSingle;
//        
//    }
    
    return MenuItemTypeSingle;
}

#pragma mark -RefreshLocationDelegate
/**
 *  标题栏上重新展示地址
 *
 *  @param location  地址
 *
 */
-(void)refreshLocation:(NSString *)location{
    
    self.locationStr = location;
    
    CGSize size = [Tool calculteTheSizeWithContent:location rect:CGSizeMake(KUIScreenWidth - 30 *2 - 40, 25) font:KHomePageTitleFont];
    self.locationSize = size;
    
    self.locationView.frame = CGRectMake((KUIScreenWidth - size.width -10 )/2, 30, size.width +10, 30);
    
    self.locationLabel.frame = self.locationView.frame;
    
    self.locationLabel.text = location;
    
}


- (void)locationTapClick {
    
    HMPositioningViewController *hmpositionVC = [[HMPositioningViewController alloc] init];
    
    CESNavigationController *nav = [[CESNavigationController alloc] initWithRootViewController:hmpositionVC];
    hmpositionVC.refreshLocationDelegate = self;
    hmpositionVC.isFrom = kHomeViewController;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark -SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);

}

@end
