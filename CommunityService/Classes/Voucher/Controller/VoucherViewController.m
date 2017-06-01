//
//  VoucherViewController.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "VoucherViewController.h"

@interface VoucherViewController ()

@end

@implementation VoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    
    [parms setObject:@"325799" forKey:@"uid"];
    [parms setObject:@"zw91" forKey:@"username"];
    [parms setObject:@"25871" forKey:@"reid"];
    [parms setObject:@"7038116" forKey:@"shopsid"];
    [parms setObject:@"卢" forKey:@"linkman"];
    [parms setObject:@"百佳利社区1265" forKey:@"address"];
    [parms setObject:@""forKey:@"code"];
    //添加经纬度,是持续定位的经纬度
    [parms setObject:@"116.306711" forKey:@"longitude"];
    [parms setObject:@"40.036659" forKey:@"latitude"];
    [parms setObject:@"13733180662" forKey:@"phone"];
    [parms setObject:@"C291504B-4BA5-4557-84B3-6541E5BD6014" forKey:@"imei"];
    
    [parms setObject:@"3" forKey:@"payment"];
    [parms setObject:@"1" forKey:@"distri"];
    
    [parms setObject:@"" forKey:@"content"];
    [parms setObject:@"2" forKey:@"is_shop_discount"];
    [parms setObject:@"0.000000" forKey:@"freight_total_price"];
    [parms setObject:@"1.000000" forKey:@"total"];
    [parms setObject:@"1.000000" forKey:@"goods_total_price"];
    [parms setObject:@[@{@"intype": @"1",@"title":@""}] forKey:@"invoice"];
    NSMutableArray *goodsArr = [[NSMutableArray alloc]init];
    [goodsArr addObject:@{@"goodsid": @"5189549",
                          @"name": @"首尔5日炫动之旅",
                          @"price": @"1",
                          @"num": @"1",
                          @"is_special":@"2",
                          @"special_num":@"1",
                          @"special_price":@"1"}];
    [parms setObject:goodsArr forKey:@"detail"];
    
    
    
    [CESHttpTool requestWithURL:@"m=ApiImeiOrder&a=addorder_v3" params:[NSMutableDictionary dictionaryWithDictionary:@{@"parm": parms}] httpMethod:@"POST" completeBlock:^(id result) {
        
        NSLog(@"=========%@",result);
        
    } failedBlock:^(id result) {
        
        
    }];
    
    
   
}

@end
