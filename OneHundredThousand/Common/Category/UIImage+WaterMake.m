//
//  UIImage+WaterMake.m
//  DemoTest
//
//  Created by FaTuZhiNengZhuKK on 17/3/16.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "UIImage+WaterMake.h"

@implementation UIImage (WaterMake)


- (UIImage *)waterMarkImageText:(NSString *)text WithRect:(CGRect)rect{

    //1.获取上下文
    UIGraphicsBeginImageContext(self.size);
    //2.绘制图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.绘制水印文字
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    style.alignment = NSTextAlignmentRight;
    //文字的属性
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:23],
                          
                          NSParagraphStyleAttributeName:style,
                          
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          
                          };
    
    //将文字绘制上去
    [text drawInRect:rect withAttributes:dic];
    //4.获取绘制到得图片
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();

    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    return watermarkImage;
    
}

- (UIImage *)addImageLogo:(UIImage *)logoImage WithRect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [logoImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

//2.加图片
- (UIImage *)addImageLogo:(UIImage *)logoImage WithLogoRect:(CGRect)rect{
    
    //get image width and height
    int w = self.size.width;
    int h = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    CGContextDrawImage(context, rect, logoImage.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

@end
