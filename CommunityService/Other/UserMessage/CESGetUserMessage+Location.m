//
//  CESGetUserMessage+Location.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESGetUserMessage+Location.h"

@implementation CESGetUserMessage (Location)

/**
 *  GPS定位
 *
 */

+ (NSString *) getCurrentGPSCID{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kGPSCID];
}

+ (void) saveCurrentGPSCID:(NSString*)gpsId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kGPSCID];
    
    [userDefaults setObject:gpsId forKey:kGPSCID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) getCurrentGPSCName{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kGPSCName];
}

+ (void) saveCurrentGPSCName:(NSString*)gpsname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kGPSCName];
    
    [userDefaults setObject:gpsname forKey:kGPSCName];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 *  社区
 */

+ (NSString *) getCommID {
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalCommID];
}

+ (NSString *) getCommLocalName{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalCommName];
}
+ (NSString *) getCommLocalLevel {
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalCommLevel];
}

+ (void)saveLocalCommName:(NSString*)commname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalCommName];
    
    [userDefaults setObject:commname forKey:kLocalCommName];
    
    [userDefaults synchronize];
}

+ (void)saveLocalCommId:(NSString*)commid{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalCommID];
    
    [userDefaults setObject:commid forKey:kLocalCommID];
    
    [userDefaults synchronize];
}

+ (void)saveLocalCommLevel:(NSString*)level{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalCommLevel];
    
    [userDefaults setObject:level forKey:kLocalCommLevel];
    
    [userDefaults synchronize];
}


//选择的
+ (NSString *) getSelectCID{
    
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kSelectCommID];
    
}

+ (void) saveSelectCID:(NSString*)cId{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kSelectCommID];
    
    [userDefaults setObject:cId forKey:kSelectCommID];
    
    [userDefaults synchronize];
    
}

+ (NSString *) getSelectCName{
    
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kSelectCommName];
    
}

+ (void) saveSelctCName:(NSString*)selectCName{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kSelectCommName];
    
    [userDefaults setObject:selectCName forKey:kSelectCommName];
    
    [userDefaults synchronize];
    
}

+ (NSString *) getSelectCLevel{
    
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kSelectCommLevel];
    
}

+ (void) saveSelectCLevel:(NSString*)selectCLevel{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kSelectCommLevel];
    
    [userDefaults setObject:selectCLevel forKey:kSelectCommLevel];
    
    [userDefaults synchronize];
}

+ (void)saveSelectFlag:(NSString*)selectFlag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kSelectFlag];
    
    [userDefaults setObject:selectFlag forKey:kSelectFlag];
    
    [userDefaults synchronize];
    
}
+ (NSString *)getSelectFlag{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *selectFlag = [userDefaults objectForKey:kSelectFlag];
    
    return selectFlag;
}


+ (NSString *) getCurrentLongitude{
    
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentLongitude];
    
}//经度

+ (void)saveCurrentLongitude:(NSString*)lon{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kCurrentLongitude];
    
    [userDefaults setObject:lon forKey:kCurrentLongitude];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) getCurrentLatitude{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentLatitude];
}//纬度

+ (void)saveCurrentLatitude:(NSString*)lat{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kCurrentLatitude];
    
    [userDefaults setObject:lat forKey:kCurrentLatitude];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *) getFinalPID{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:kLocalFinalPID];
}
+ (void) saveFinalPID:(NSString*)pid{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kLocalFinalPID];
    
    [userDefaults setObject:pid forKey:kLocalFinalPID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//保存持续定位的经纬度
+(void)saveContinuousLocation:(NSMutableDictionary*)locationDic{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:kConntinuousLocation];
    
    [userDefaults setObject:locationDic forKey:kConntinuousLocation];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(NSMutableDictionary*)getContinuousLocation{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =  [userDefaults objectForKey:kConntinuousLocation];
    
    return dic;
    
}
@end
