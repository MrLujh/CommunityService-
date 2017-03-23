//
//  UIImage+CES.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CES)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 根据颜色和尺寸生成图片
 
 @param color 颜色
 @param size 输出图片大小
 @return 图片大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height;
// 等比压缩图片到targetsize
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
// 压缩图片小于length字节
- (NSData *)compressImageBelow:(NSInteger)length;
- (UIImage *)squareImage;
@end
