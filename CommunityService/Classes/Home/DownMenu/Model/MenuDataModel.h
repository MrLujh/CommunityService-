//
//  MenuDataModel.h
//  tableView悬浮
//
//  Created by lujh on 2017/2/27.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuDataModel : NSObject
/**每一个筛选条目的Item*/
@property (nonatomic,copy) NSString * title;

/**Item是否被选中*/
@property (nonatomic,assign) BOOL isSelectedItem;

/*********************只有当有两个表格的时候才会用到该属性**********************/
/**盛放右边的数据源的数组*/
@property (nonatomic,strong) NSArray * rightTableData;
@end
