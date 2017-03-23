
//
//  FMDBPositioningManager.m
//  CommunityService
//
//  Created by lujh on 2017/2/16.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "FMDBPositioningManager.h"

@implementation FMDBPositioningManager


+ (FMDBPositioningManager *)sharadManager{
    @synchronized(self){
        static FMDBPositioningManager *manager = nil;
        
        if (manager == nil) {
            
            manager = [[FMDBPositioningManager alloc]init];
        }
        
        return manager;
    }
}

- (id)init{
    @synchronized(self){
        if (self = [super init]) {
            
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",POSITIONSQLITE]];
            _fmdb = [[FMDatabase alloc]initWithPath:path];
            
            BOOL res = [_fmdb open];
            if (res == NO) {
                NSLog(@"打开失败");
            }
            
            //首页定位地址搜索关键字
            [_fmdb executeUpdate:@"create table if not exists LOCATIONKEYWORDTABLE(_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title VARCHAR(200),addtime VARCHAR(50),uid VARCHAR(20))"];
            
            if (res == NO) {
                NSLog(@"创建表失败");
            }
            [_fmdb close];
        }
        return self;
    }
}


// 插入某条数据
-(void)insertKeywordWithDic:(NSDictionary*)keywordDic uid:(NSString*)uid tableName:(NSString*)tableName{
    
    @synchronized(self){
        BOOL res = [_fmdb open];
        if (res == NO) {
            NSLog(@"insert 时open faile");
            return;
        }
        
        NSString *sql = @"insert into %@(title,addtime,uid) values(?,?,?)";
        sql = [NSString stringWithFormat:sql,tableName];
        res = [_fmdb executeUpdate:sql,keywordDic[@"title"],keywordDic[@"addtime"],uid];
        
        if (res == NO) {
            
            NSLog(@"插入失败");
            
            NSLog(@"insert faile");
        }
        [_fmdb close];
    }
    
}

// 查询所有数据
-(NSMutableArray*)queryKeywordList:(NSString*)uid tableName:(NSString*)tableName{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    BOOL res = [_fmdb open];
    if (res == NO) {
        NSLog(@"query 时 open faile");
        return arr;
    }
    
    NSMutableDictionary *msgDic = nil;
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where uid =%@ order by _id desc limit 0, 10 ",tableName,uid];
    FMResultSet *rs = [_fmdb executeQuery:sql];
    
    while ([rs next]) {
        
        msgDic = [NSMutableDictionary dictionary];
        
        [msgDic setObject:[rs stringForColumn:@"title"] forKey:@"title"];
        
        [msgDic setObject:[rs stringForColumn:@"addtime"] forKey:@"addtime"];
        
        [arr addObject:msgDic];
    }
    
    [_fmdb close];
    
    return arr;
}

// 清空所有数据
-(BOOL)deleteKeywordList:(NSString*)uid tableName:(NSString*)tableName{
    
    @synchronized(self){
        BOOL res = [_fmdb open];
        if (res == NO) {
            NSLog(@"remove good 时 open faile");
            return NO;
        }
        
        BOOL result = FALSE;
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@  where uid = %@",tableName,uid];
        
        result = [_fmdb executeUpdate:sql];
        
        [_fmdb close];
        return result;
    }
    
}

// 判断是否存在
-(BOOL)inExistKeyword:(NSString*)keyword uid:(NSString*)uid tableName:(NSString*)tableName{
    @synchronized(self){
        BOOL res = [_fmdb open];
        if (res == NO) {
            NSLog(@"remove good 时 open faile");
            return NO;
        }
        
        BOOL result = FALSE;
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@  where title='%@' and uid = %@",tableName,keyword,uid];
        
        FMResultSet *rs = [_fmdb executeQuery:sql];
        
        
        if ([rs next]) {
            result = TRUE;
            
        }
        
        [_fmdb close];
        
        return result;
    }
    
}

@end
