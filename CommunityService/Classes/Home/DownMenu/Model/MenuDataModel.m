//
//  MenuDataModel.m
//  tableView悬浮
//
//  Created by lujh on 2017/2/27.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MenuDataModel.h"
#import "MenuRightDataModel.h"

@implementation MenuDataModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"rightTableData" : [MenuRightDataModel class]};
}

@end
