//
//  CESGetUserMessage+Location.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//
#define kDefaultFinalID @"-1" //-14为5000米

#import "CESGetUserMessage.h"

@interface CESGetUserMessage (Location)
//社区
+ (NSString *) getCommID;
+ (NSString *) getCommLocalName;
+ (NSString *) getCommLocalLevel;

+ (void)saveLocalCommName:(NSString*)commname;
+ (void)saveLocalCommId:(NSString*)commid;
+ (void)saveLocalCommLevel:(NSString*)level;

//定位
+ (NSString *) getCurrentGPSCID;
+ (void) saveCurrentGPSCID:(NSString*)gpsId;

+ (NSString *) getCurrentGPSCName;
+ (void) saveCurrentGPSCName:(NSString*)gpsname;

//选择的
+ (NSString *) getSelectCID;
+ (void) saveSelectCID:(NSString*)cId;

+ (NSString *) getSelectCName;
+ (void) saveSelctCName:(NSString*)selectCName;

+ (NSString *) getSelectCLevel;
+ (void)saveSelectCLevel:(NSString*)selectCLevel;

+ (void)saveSelectFlag:(NSString*)selectFlag;
+ (NSString *)getSelectFlag;

//最终 pid
+ (NSString *) getFinalPID;
+ (void) saveFinalPID:(NSString*)pid;

//定位得到的经纬度
+ (NSString *) getCurrentLongitude; //经度
+ (void)saveCurrentLongitude:(NSString*)lon;

+ (NSString *) getCurrentLatitude; //纬度
+ (void)saveCurrentLatitude:(NSString*)lat;

//保存持续定位的经纬度
+(void)saveContinuousLocation:(NSMutableDictionary*)locationDic;

+(NSMutableDictionary*)getContinuousLocation;

@end
