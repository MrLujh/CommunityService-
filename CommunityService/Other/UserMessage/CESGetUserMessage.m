//
//  CESGetUserMessage.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESGetUserMessage.h"

@implementation CESGetUserMessage

+(CESGetUserMessage*) sharedContext{
    
    static CESGetUserMessage  *s_intance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s_intance = [[CESGetUserMessage alloc]init];
    });
    
    return s_intance;
}

/**
 *  用户
 */

+ (NSString *) getUserID {
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalUserID];
}

+(void)saveUserID:(NSString*)userId{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kLocalUserID];
    [standerDef setObject:userId forKey:kLocalUserID];
    
    [standerDef synchronize];
    
}


+ (NSString *) getUserNickName{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalUserName];//@"144";
}

+(void)setUserNickName:(NSString*)nickName{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kLocalUserName];
    [standerDef setObject:nickName forKey:kLocalUserName];
    
    [standerDef synchronize];
}

/**
 *  无登陆 用户 old
 */

+ (NSString *) getUserIdentifier {
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    return [standerDef objectForKey:@"userIdentifier"];
}

+ (void) saveUserIdentifier:(NSString*)value {
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:@"userIdentifier"];
    [standerDef setObject:value forKey:@"userIdentifier"];
    
    [standerDef synchronize];
}

/**
 *  无登陆 用户 new
 */

+ (NSString *) getNoLoginUserId {
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    return [standerDef objectForKey:kNoLoginUserID];
}

+ (void) saveNoLoginUserId:(NSString*)value {
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kNoLoginUserID];
    [standerDef setObject:value forKey:kNoLoginUserID];
    
    [standerDef synchronize];
}




+(NSString*)getCurrentUnionId{
    
    NSString *uid = [self getUserID];
    if (uid != nil) {
        return uid;
    }else{
        //        return  [self getUserIdentifier];
        return [self getNoLoginUserId];
    }
}

/**
 *  save 账户
 */


- (void)saveLocalUserAccountInfo:(NSDictionary*)userInfo{
    
    NSInteger u  = [[userInfo objectForKey:@"user_id"] integerValue];
    
    NSString *userId = [NSString stringWithFormat:@"%ld", u];
    
    NSString *username = [userInfo objectForKey:@"nickname"];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalUserID];
    [userDefaults removeObjectForKey:kLocalUserName];
    
    
    [userDefaults setObject:userId forKey:kLocalUserID];
    [userDefaults setObject:username forKey:kLocalUserName];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)removeLocalUserAccountInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalUserID];
    //    [userDefaults removeObjectForKey:kLocalUserName];
    
    [userDefaults synchronize];
}

// shop

+ (NSString *) getCurrentShopID{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentShopID];
}

+ (void) saveCurrentShopID:(NSString*)shopId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kCurrentShopID];
    [userDefaults setObject:shopId forKey:kCurrentShopID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/**
 *  购物车
 */

+ (void)saveWillBuyShopIDinShopcart:(NSString*)shopId{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kShopcartShopId];
    [userDefaults setObject:shopId forKey:kShopcartShopId];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*)getWillBuyShopIDInShopcart{
    NSString *shopid = [[NSUserDefaults standardUserDefaults] valueForKey:kShopcartShopId];
    
    if (shopid == nil) {
        shopid = @"";
    }
    return  shopid;
}


+ (NSString *) getClientid{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    NSString *clientid = [standerDef objectForKey:@"clientid"];
    return clientid;
    
}

+ (void) saveClientid:(NSString *)clientid{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:@"clientid"];
    [standerDef setObject:clientid forKey:@"clientid"];
    
    [standerDef synchronize];
}


+ (NSString *) getPayment:(NSString *)uid{
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    NSString *payment = [standerDef objectForKey:uid];
    return payment;
    
}
+ (void) savePayment:(NSString*)uid payment:(NSString *)payment{
    
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:uid];
    [standerDef setObject:payment forKey:uid];
    
    [standerDef synchronize];
}

+ (NSString *) getPhone{
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    NSString *loginPhone = [standerDef objectForKey:kLoginPhone];
    return loginPhone;
    
}
+(void)savePhone:(NSString*)phone{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kLoginPhone];
    
    [standerDef setObject:phone forKey:kLoginPhone];
    
    [standerDef synchronize];
}

+ (NSString *) getLocationFlag{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    NSString *loginPhone = [standerDef objectForKey:kLocationFlag];
    
    return loginPhone;
    
    
}
+(void)saveLocationFlag:(NSString*)flag{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    [standerDef removeObjectForKey:kLocationFlag];
    
    [standerDef setObject:flag forKey:kLocationFlag];
    
    [standerDef synchronize];
    
}

+ (void) saveLocationAddress:(NSString*)address {
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kLocationAddress];
    [standerDef setObject:address forKey:kLocationAddress];
    
    [standerDef synchronize];
}

+ (NSString*) getLocationAddress{
    
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    NSString *address = [standerDef objectForKey:kLocationAddress];
    
    return address;
    
}

//首页是否手动选择地址 "YES"  "NO"
+ (void) saveIsSelect:(NSString *)select
{
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    [standerDef removeObjectForKey:kHasSelectLocationAddress];
    [standerDef setObject:select forKey:kHasSelectLocationAddress];
    
    [standerDef synchronize];
}

+ (NSString*) getSelect
{
    NSUserDefaults *standerDef = [NSUserDefaults standardUserDefaults];
    
    NSString *address = [standerDef objectForKey:kHasSelectLocationAddress];
    
    return address;
    
}

@end
