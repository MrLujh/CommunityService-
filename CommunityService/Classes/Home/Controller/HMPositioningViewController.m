//
//  HMPositioningViewController.m
//  CommunityService
//
//  Created by lujh on 2017/1/3.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "HMPositioningViewController.h"
#import "CommonUtility.h"
#import "HMPositioningVCSearchTableViewCell.h"
#import "HMPositioningModel.h"
#import "HMPositioningVCHistoryTableViewCell.h"
#import "SGInfoAlert.h"
#import "FMDBPositioningManager.h"
#define TipPlaceHolder @"名称"
#define BusLinePaddingEdge 20d

@interface HMPositioningViewController ()<AMapLocationManagerDelegate, AMapSearchDelegate, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>

// 搜索框背景view
@property(nonatomic,strong)UIView *searchBackView;
// 高德地图
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,strong)AMapSearchAPI *amapSearchAPI;
// 模糊搜索tableview
@property(nonatomic,strong)UITableView *searchTableView;
// 模糊搜索数组
@property(nonatomic,strong)NSMutableArray *searchArray;
// 定位信息
@property(nonatomic,strong)NSMutableDictionary *locDic;
// 搜索记录tableview
@property(nonatomic,strong)UITableView *searchHistoryTableView;
// 搜索记录数组
@property(nonatomic,strong)NSMutableArray *searchHistoryArray;
// 搜索UISearchBar
@property(nonatomic,strong)UISearchBar *searchBar;
// 搜索关键词
@property(nonatomic,copy)NSString *searchKeyWord;

@end

@implementation HMPositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化变量
    [self ininVar];
    
    // 初始化导航栏
    [self setupNavigationbarBack];
    
    // 初始化UI界面
    [self seupSubViews];
    
    // 加载本地搜索记录
    [self loadKeyword];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

#pragma mark -初始化变量

- (void)ininVar {
    
    self.title = @"切换地址";
    self.view.backgroundColor = [UIColor whiteColor];

    self.searchArray = [[NSMutableArray alloc]init];
    
    self.searchHistoryArray = [[NSMutableArray alloc]init];
    
    self.locDic = [[NSMutableDictionary alloc]init];

    //高德定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    //AMapSearchAPI
    self.amapSearchAPI = [[AMapSearchAPI alloc] init];
    self.amapSearchAPI.delegate = self;
}

#pragma mark -初始化导航栏

- (void)setupNavigationbarBack {
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, 12, 21);
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceItem.width = -7;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftButtonItem];
    
}

#pragma mark -初始化UI界面

- (void)seupSubViews {
    
    // 搜索框背景view
    _searchBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KUIScreenWidth, 50)];
    _searchBackView.backgroundColor = kTabbarSelectColor;
    [self.view addSubview:_searchBackView];
    
    // 系统搜索框
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10,KUIScreenWidth,30)];
    self.searchBar.delegate = self;
    self.searchBar.backgroundImage = [UIImage imageNamed:@"nav_bar_ios7"];
    self.searchBar.placeholder = @"请输入地址";
    [self.searchBackView addSubview:self.searchBar];
    
    // 定位当前位置背景view
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, _searchBackView.bottom, KUIScreenWidth, 60);
    headerView.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:headerView];
    
    UIView *locationBackView = [[UIView alloc] init];
    locationBackView.frame = CGRectMake(0, 10, KUIScreenWidth, 40);
    locationBackView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:locationBackView];
    
    UIButton *locationBtn = [[UIButton alloc] init];
    CGFloat locationW = KUIScreenWidth;
    CGFloat locationH = 50;
    locationBtn.frame = CGRectMake((locationBackView.width -locationW)/2, (locationBackView.height - locationH)/2, locationW, locationH);
    [locationBtn setImage:[UIImage imageNamed:@"location_refresh_currentLocation"] forState:UIControlStateNormal];
    [locationBtn setTitle:@"定位当前位置" forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [locationBackView addSubview:locationBtn];
    [locationBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    
    // 搜索记录tableview
    self.searchHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 +60, KUIScreenWidth, KUIScreenHeight - kNavigationBar - kStateBar - 50 - 60) style:UITableViewStylePlain];
    self.searchHistoryTableView.dataSource = self;
    self.searchHistoryTableView.delegate = self;
    self.searchHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.searchHistoryTableView];
    
    // 模糊搜索tableview
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, locationBackView.bottom, KUIScreenWidth, KUIScreenHeight - kNavigationBar - kStateBar - 30) style:UITableViewStylePlain];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    [self.view addSubview:self.searchTableView];
    self.searchTableView.hidden = YES;
    
}

#pragma mark -加载本地搜索

- (void)loadKeyword{
    
    NSString *uid = [CESGetUserMessage getCurrentUnionId];
    
    NSMutableArray *arr = [[FMDBPositioningManager sharadManager] queryKeywordList:uid tableName:LocationWordTable];
    
    [self.searchHistoryArray addObjectsFromArray:arr];
    
    [self.searchHistoryTableView reloadData];
}

#pragma mark -UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"111111");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"111111");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSLog(@"textDidChange");
    
    if ([@"" isEqualToString:searchText]) {
        
        self.searchTableView.hidden = YES;
        
    }else{
        
        
        [self inputSearch:searchText];
    }
}

#pragma mark -定位到当前位置按钮点击事件
/*
 *  定位当前位置
 */
-(void)locationBtnClick:(UIButton*)btn{
    
    if([CLLocationManager locationServicesEnabled] == FALSE){
        //未定位
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请开启定位:设置 > 隐私 > 位置 > 定位服务,应用要使用当前的定位信息。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请开启定位:设置 > 隐私 > 位置 > 定位服务下社区e服务应用,应用要使用当前的定位信息。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
    [self.locationManager startUpdatingLocation];
    
    //置为“NO”
    [CESGetUserMessage saveIsSelect:@"NO"];
}

#pragma mark -AMapLocationManager delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    
    DLog(@"定位失败：%@",error);
    
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    if (location != nil) {
        
        [self.locationManager stopUpdatingLocation];
        
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSLog(@"latitude == %@",latitude);
        
        if ([kHomeViewController isEqualToString:self.isFrom]) {
            
            [CESGetUserMessage saveCurrentLongitude:longitude];
            
            [CESGetUserMessage saveCurrentLatitude:latitude];
            
        }else if([kCardShopListViewController isEqualToString:self.isFrom]){
            
            
            [self.locDic setObject:longitude forKey:@"longitude"];
            
            [self.locDic setObject:latitude forKey:@"latitude"];
            
        }
        
        self.amapSearchAPI = [[AMapSearchAPI alloc] init];
        self.amapSearchAPI.delegate = self;
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        CGFloat lat = location.coordinate.latitude;
        CGFloat lon = location.coordinate.longitude;
        
        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:lat longitude:lon];
        
        regeo.location = point;
        regeo.radius = 1000;
        regeo.requireExtension = YES;
        
        //发起逆地理编码
        [self.amapSearchAPI AMapReGoecodeSearch: regeo];
        
    }
    
}

#pragma mark -AMapSearchDelegate

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        DLog(@"LocationViewController onReGeocodeSearchDone :%@",response.regeocode);
        
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        
        AMapReGeocode *regeocode = response.regeocode;
        
        NSString *district = regeocode.addressComponent.district;
        
        NSString *township = regeocode.addressComponent.township;
        
        NSString *neighborhood = regeocode.addressComponent.neighborhood;
        
        NSString *address = [NSString stringWithFormat:@"%@%@%@",district,township,neighborhood];
        
        NSLog(@"%@",address);
        
        if ([kHomeViewController isEqualToString:self.isFrom]) {
            
            [self.refreshLocationDelegate refreshLocation:address];
            
        }else if([kCardShopListViewController isEqualToString:self.isFrom]){
            
            
            [self.locDic setObject:address forKey:@"address"];
            
            self.refreshLocation(self.locDic);
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
}

#pragma mark -UItableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchTableView) {
        
        return 44;
    }else{
        
        return 40 + 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.searchTableView){
        
        return self.searchArray.count;
    }else {
        if (self.searchHistoryArray.count > 0) {
            return self.searchHistoryArray.count + 1;
            
        }else{
            
            return self.searchHistoryArray.count;
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchTableView) {
        
        static NSString *identifier = @"HMPositioningVCSearchTableViewCell";
        
        HMPositioningVCSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
        
        if (cell == nil) {
            
            cell = [[HMPositioningVCSearchTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
        }
        
        NSInteger row = indexPath.row;
        
        HMPositioningModel *hmpositioningModel = [self.searchArray objectAtIndex:row];
        cell.hmpositioningModel = hmpositioningModel;
        cell.indexPath = indexPath;
        return cell;
        
    }else{
        
        if (indexPath.row < self.searchHistoryArray.count) {
            
            static NSString *shopCellIdentify3 = @"KeywordCellIdentify";
            
            HMPositioningVCHistoryTableViewCell  *cell3 = [tableView dequeueReusableCellWithIdentifier:shopCellIdentify3];
            if (cell3 == nil) {
                
                cell3 = [[HMPositioningVCHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:shopCellIdentify3];
                
                cell3.backgroundColor = [UIColor whiteColor];
                
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            NSMutableDictionary *dic = [self.searchHistoryArray objectAtIndex:indexPath.row];
            
            cell3.dic = dic;
            
            return cell3;
            
        }else{ //删除按钮
            
            static NSString *deleteCellIdentify = @"deleteCell";
            
            UITableViewCell  *deleteCell = [tableView dequeueReusableCellWithIdentifier:deleteCellIdentify];
            if (deleteCell == nil) {
                
                deleteCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deleteCellIdentify];
                
                UIButton *deleteBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
                
                deleteBtn.frame = CGRectMake(0, 0, KUIScreenWidth, 44-0.5);
                deleteBtn.adjustsImageWhenHighlighted = NO;
                deleteBtn.userInteractionEnabled = NO;
                [deleteBtn setImage:[UIImage imageNamed:@"shopcart_del_bg"] forState:UIControlStateNormal];
                
                [deleteBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
                [deleteBtn setTitleColor:Theme_ContentColor_M forState:UIControlStateNormal];
                deleteBtn.titleLabel.font = Theme_Font_14;

                [deleteCell.contentView addSubview:deleteBtn];
                
                UIView *line =  [[UIView alloc] initWithFrame:CGRectMake(0, 40-0.5, KUIScreenWidth, 0.5)];
                line.backgroundColor = Theme_LineColor;
                
                [deleteCell.contentView addSubview:line];
                
                deleteCell.backgroundColor = [UIColor whiteColor];
                
                deleteCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            return deleteCell;
            
        }
        
    }
    
}

#pragma mark -UItableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchBar isFirstResponder]) {
        
        [self.searchBar resignFirstResponder];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.searchTableView) {
        
        HMPositioningModel *hmpositioningModel = [self.searchArray objectAtIndex:indexPath.row];
        
        self.searchKeyWord = hmpositioningModel.name;
        
        if ((hmpositioningModel.lon <= 0 )||(hmpositioningModel.lat <= 0)) {
            
            [SGInfoAlert showInfo:@"请选择详细地址！"
                          bgColor:[[UIColor orangeColor] CGColor]
                           inView:self.view
                         vertical:0.8];
            
            return;
        }
        
        //将搜索关键字保存到本地
        [self saveKeyword];
        
        //代理传值
        NSString *longitude = [NSString stringWithFormat:@"%f",hmpositioningModel.lon];
        NSString *latitude = [NSString stringWithFormat:@"%f",hmpositioningModel.lat];
        NSString *address = [[NSString alloc]initWithFormat:@"%@",hmpositioningModel.name];
        
        if ([kHomeViewController isEqualToString:self.isFrom]) { //首页进来
            
            [CESGetUserMessage saveCurrentLongitude:longitude];
            [CESGetUserMessage saveCurrentLatitude:latitude];
            [CESGetUserMessage saveLocationAddress:address];
            
            //手动选择位置，首页刷新时不刷新位置
            [CESGetUserMessage saveIsSelect:@"YES"];
            
            [self.refreshLocationDelegate refreshLocation:address];
            
        }else if([kCardShopListViewController isEqualToString:self.isFrom]){ //卡包商铺列表
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:longitude forKey:@"longitude"];
            [dic setObject:latitude forKey:@"latitude"];
            [dic setObject:address forKey:@"address"];
            
            self.refreshLocation(dic);
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else if(tableView == self.searchHistoryTableView){
        
        if(self.searchHistoryArray.count > 0){ //有数据
            
            if(indexPath.row < self.searchHistoryArray.count){
                
                NSMutableDictionary *dic = [self.searchHistoryArray objectAtIndex:indexPath.row];
                
                NSString *title = [dic objectForKey:@"title"];
                
                self.searchBar.text = title;
                
                [self inputSearch:title];
                
                [self.searchHistoryTableView removeFromSuperview];
                self.searchHistoryTableView = nil;
                
            }else{
                
                [self deleteAllKeyword];
            }
        }
    }
}

#pragma mark -UIscrollview delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.searchBar resignFirstResponder];
    
}

#pragma mark -搜索的回调函数

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    if ([self.searchTableView superview] != nil) {
        
        self.searchTableView.hidden = NO;
        
    }else{
        
        [self.view addSubview:self.searchTableView];
    }
    
    [self.searchArray removeAllObjects];
    
    //通过AMapPlaceSearchResponse对象处理搜索结果
    
    for (AMapPOI *p in response.pois) {
        
        NSString *district = p.district;
        NSString *name = p.name;
        
        if ([district isEqualToString:name]) {
            continue;
        }
        
        
        HMPositioningModel *hmpositioningModel = [[HMPositioningModel alloc] init];
        hmpositioningModel.province = p.province;
        hmpositioningModel.city     = p.city;
        hmpositioningModel.district = p.district;
        hmpositioningModel.address  = p.address;
        hmpositioningModel.name     = p.name;
        hmpositioningModel.lat      = p.location.latitude;
        hmpositioningModel.lon      = p.location.longitude;
        
        [self.searchArray addObject:hmpositioningModel];
        
    }
    
    [self.searchTableView reloadData];
    
}

-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    if ([self.searchTableView superview] != nil) {
        
        self.searchTableView.hidden = NO;
        
    }else{
        
        [self.view addSubview:self.searchTableView];
    }
    
    [self.searchArray removeAllObjects];
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    for (AMapTip *tip in response.tips) {
        
        CGFloat lon = tip.location.longitude;
        CGFloat lat = tip.location.latitude;
        
        //过滤省市
        if ((lon <= 0) ||(lat <= 0)) {
            
            continue;
        }
        
        
        HMPositioningModel *hmpositioningModel =  [[HMPositioningModel alloc] init];
        hmpositioningModel.name = tip.name;
        hmpositioningModel.address = tip.district;
        hmpositioningModel.lat = tip.location.latitude;
        hmpositioningModel.lon = tip.location.longitude;
        
        [self.searchArray addObject:hmpositioningModel];
        
    }
    
    [self.searchTableView reloadData];
}

#pragma mark -通过输入关键字搜索
/*
 * 通过输入关键字搜索
 * keyWords  输入的关键字
 */
-(void)inputSearch:(NSString*)keyWords{
    
    //构造AMapInputTipsSearchRequest对象，设置请求参数
    
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = keyWords;
    //发起输入提示搜索
    [self.amapSearchAPI AMapInputTipsSearch: tipsRequest];
    
    
}


#pragma mark -保存关键字方法

- (void)saveKeyword{
    
    NSString *keyword = self.searchKeyWord;
    
    NSString *uid = [CESGetUserMessage getCurrentUnionId];
    
    //1.先判断是否存在
    
    BOOL isExist = [[FMDBPositioningManager sharadManager] inExistKeyword:keyword uid:uid tableName:LocationWordTable ];
    
    if (!isExist) {
        
        NSDate *senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *locationString=[dateformatter stringFromDate:senddate];
        
        NSDictionary *keyDic = [NSDictionary dictionaryWithObjectsAndKeys:keyword,@"title",locationString,@"addtime", nil];
        
        [[FMDBPositioningManager sharadManager] insertKeywordWithDic:keyDic uid:uid tableName:LocationWordTable];
    }
}

#pragma mark -清空本地存储的搜索关键字

- (void)deleteAllKeyword{
    
    NSString *uid = [CESGetUserMessage getCurrentUnionId];
    
    [[FMDBPositioningManager sharadManager] deleteKeywordList:uid tableName:LocationWordTable];
    
    [self.searchHistoryArray removeAllObjects];
    
    [self.searchHistoryTableView reloadData];
    
}

#pragma mark -导航栏返回按钮

- (void)backAction {
    
    [self.searchBar resignFirstResponder];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
