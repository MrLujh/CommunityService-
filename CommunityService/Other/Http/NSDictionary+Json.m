//
//  NSDictionary+Json.m
//  PocketShop
//
//  Created by zhuhao on 14-4-10.
//  Copyright (c) 2014年 jkrm. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

-(NSString*)toJsonString{
    
    NSError *error;
    //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。如果这个选项是没有设置,最紧凑的可能生成JSON表示。
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
