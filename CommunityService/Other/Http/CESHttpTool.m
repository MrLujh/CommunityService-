//
//  CESHttpTool.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//
//测试
#define SERVICE_INNER         @"http://139.217.11.18:81/O2OV2_test/user/index.php?" //测试


#import "CESHttpTool.h"
#import "NSDictionary+Json.h"

@implementation CESHttpTool

+ (void)requestWithURL:(NSString*)urlStr
                params:(NSMutableDictionary*)params
            httpMethod:(NSString*)httpMethod
         completeBlock:(RequestFinishBlock)sucessBlock
           failedBlock:(RequestFailureBlock)failedBlock{
    
    urlStr = [@"http://139.217.11.18:81/O2OV2_test/user/index.php?" stringByAppendingString:urlStr];
    //Get 请求处理
    NSComparisonResult compareRet0 = [httpMethod caseInsensitiveCompare:@"GET"];
    if (compareRet0 == NSOrderedSame) {
        
        NSMutableString *paramsString = [NSMutableString string];
        
        NSMutableArray *allKeys = [NSMutableArray arrayWithArray:[params allKeys]];
        
        [paramsString appendString:@"&"];
        
        for (int i = 0; i < allKeys.count; i++) {
            
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            [paramsString appendFormat:@"%@=%@",key,value];
            
            if (i < allKeys.count - 1) {
                [paramsString appendString:@"&"];
            }
        }
        
        if (paramsString.length > 0) {
            urlStr = [urlStr stringByAppendingFormat:@"%@",paramsString];
        }
        
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"1 get-url:%@",urlStr);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager.securityPolicy setAllowInvalidCertificates:YES];
        
        //        manager.requestSerializer.timeoutInterval = 10.f;
        
        __weak AFHTTPRequestOperationManager *weakManager = manager;
        
        [weakManager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *html = operation.responseString;
            
            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            
            
            
            if (sucessBlock != nil) {
                sucessBlock(dict);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failedBlock != nil) {
                failedBlock(error);
            }
            
        }];
        
    }
    
    //------------------------
    NSComparisonResult compareRet1 = [httpMethod caseInsensitiveCompare:@"POST"];
    
    if (compareRet1 == NSOrderedSame) {
        
        NSArray *allKeys = [params allKeys];
        for (NSString *key  in allKeys) {
            
            id value = [params objectForKey:key];
            
            value = [value toJsonString];
            
            [params setObject:value forKey:key];
        }
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager.securityPolicy setAllowInvalidCertificates:YES];
        
        __weak AFHTTPRequestOperationManager *weakManager = manager;
        
        [weakManager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *html = operation.responseString;
            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            
            if (sucessBlock != nil) {
                sucessBlock(dict);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failedBlock != nil) {
                failedBlock(error);
            }
            
        }];
        
    }
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSString  *urlStr = [SERVICE_INNER stringByAppendingFormat:@"%@&",URLString];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //增加一种类型，text/html类型
    NSSet *set = mgr.responseSerializer.acceptableContentTypes;
    NSMutableSet *acceptSet = [NSMutableSet setWithSet:set];
    [acceptSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = acceptSet;
    mgr.requestSerializer.timeoutInterval = 30;
    
    [mgr GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString  *urlStr = [SERVICE_INNER stringByAppendingFormat:@"%@&",URLString];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //增加一种类型，text/html类型
    NSSet *set = mgr.responseSerializer.acceptableContentTypes;
    NSMutableSet *acceptSet = [NSMutableSet setWithSet:set];
    [acceptSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = acceptSet;
    mgr.requestSerializer.timeoutInterval = 30;
    
    [mgr POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];

}
@end
