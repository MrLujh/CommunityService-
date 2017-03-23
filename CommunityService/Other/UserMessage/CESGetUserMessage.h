//
//  CESGetUserMessage.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CESGetUserMessage : NSObject

+ (CESGetUserMessage*) sharedContext;

+ (NSString *) getUserID;// login identifier
+(void)saveUserID:(NSString*)userId;

+ (NSString *) getUserNickName;
+(void)setUserNickName:(NSString*)nickName;

+ (NSString *) getUserIdentifier ; // no login identifier
+ (void) saveUserIdentifier:(NSString*)value;


+ (NSString *) getNoLoginUserId;
+ (void) saveNoLoginUserId:(NSString*)value;


+ (NSString *) getCurrentUnionId;   // 获取最终的唯一标示 ： 无论是登录还是 无登陆


+ (NSString *) getClientid;         //
+ (void) saveClientid:(NSString*)clientid;      // 返回当前登录状况  ：登录 还是无登陆

/**
 *
 */

+ (NSString *) getCurrentShopID;
+ (void) saveCurrentShopID:(NSString*)shopId;


- (void)saveLocalUserAccountInfo:(NSDictionary*)userInfo;
- (void)removeLocalUserAccountInfo;

/**
 *  购物车
 */

+ (void)saveWillBuyShopIDinShopcart:(NSString*)shopId;
+ (NSString*)getWillBuyShopIDInShopcart;


+ (NSString *) getPayment:(NSString *)uid;
+ (void) savePayment:(NSString*)uid payment:(NSString *)payment;


/*
 保存登录用户的phone
 */
+ (NSString *) getPhone;
+(void)savePhone:(NSString*)phone;

/*
 保存本次是否定位的标示
 */

+ (NSString *) getLocationFlag;
+(void)saveLocationFlag:(NSString*)flag;

+ (void) saveLocationAddress:(NSString*)address;
+ (NSString*) getLocationAddress;

/*
 * 首页是否手动选择了地址
 */
+ (void) saveIsSelect:(NSString *)select;
+ (NSString*) getSelect;

@end
