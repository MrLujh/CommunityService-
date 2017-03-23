//
//  MenuRightDataModel.h
//  tableView悬浮
//
//  Created by lujh on 2017/2/27.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuRightDataModel : NSObject
/**每一个筛选条目的Item*/
@property (nonatomic,copy) NSString * title;

/**Item是否被选中*/
@property (nonatomic,assign) BOOL isSelectedItem;

@end
