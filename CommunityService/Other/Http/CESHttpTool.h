//
//  CESHttpTool.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//
typedef  void (^RequestFinishBlock)(id data);
typedef  void (^RequestFailureBlock)(NSError *error);

#import <Foundation/Foundation.h>

@interface CESHttpTool : NSObject
/*
 * params的value进行了json格式化
 */
+ (void)requestWithURL:(NSString*)urlStr
                params:(NSMutableDictionary*)params
            httpMethod:(NSString*)httpMethod
         completeBlock:(RequestFinishBlock)sucessBlock
           failedBlock:(RequestFailureBlock)failedBlock;

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;
@end
