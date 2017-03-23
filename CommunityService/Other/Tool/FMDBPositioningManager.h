//
//  FMDBPositioningManager.h
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FMDatabase;

@interface FMDBPositioningManager : NSObject{
    
    FMDatabase *_fmdb;
}

+ (FMDBPositioningManager *)sharadManager;

// 插入某条数据
-(void)insertKeywordWithDic:(NSDictionary*)keywordDic uid:(NSString*)uid tableName:(NSString*)tableName;

// 查询所有数据
-(NSMutableArray*)queryKeywordList:(NSString*)uid tableName:(NSString*)tableName;

// 清空所有数据
-(BOOL)deleteKeywordList:(NSString*)uid tableName:(NSString*)tableName;

// 判断是否存在
-(BOOL)inExistKeyword:(NSString*)keyword uid:(NSString*)uid tableName:(NSString*)tableName;

@end
