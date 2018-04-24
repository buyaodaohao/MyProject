//
//  UIImage+WaterMake.h
//  DemoTest
//
//  Created by FaTuZhiNengZhuKK on 17/3/16.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterMake)


/**
 添加水印文字

 @param text 文字内容
 @param rect 添加文字的位置，以图片左上角为原点
 */
- (UIImage *)waterMarkImageText:(NSString *)text WithRect:(CGRect)rect;

/**
 方法一：添加水印图片

 @param logoImage 水印图片
 @param rect 添加图片的位置，以图片左上角为原点
 */
- (UIImage *)addImageLogo:(UIImage *)logoImage WithRect:(CGRect)rect;

/**
 方法二：添加水印图片

 @param logoImage 水印图片
 @param rect 添加图片的位置，以图片左上角为原点
 */
- (UIImage *)addImageLogo:(UIImage *)logoImage WithLogoRect:(CGRect)rect;

@end
