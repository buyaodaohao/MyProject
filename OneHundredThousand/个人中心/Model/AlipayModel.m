
//
//  AlipayModel.m
//  MasterLicense
//
//  Created by FaTuZhiNengZhuKK on 16/8/8.
//  Copyright © 2016年 FangTuZhiNengZhuKK. All rights reserved.
//

#import "AlipayModel.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AlipayModel


#pragma mark--支付宝支付
+(void)payOrderPayMessage:(NSString *)message SuccessCallBack:(void (^)(NSDictionary * dic))successCallBack
{
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"MaiSiYingShi";
//        签名内容字符串／私钥PKCS8
        [[AlipaySDK defaultService] payOrder:message fromScheme:appScheme callback:^(NSDictionary *resultDic) {

//            NSString  *str = [resultDic objectForKey:@"resultStatus"];
            
            NSLog(@"-resultDicresultDic-----%@",resultDic);

//            if (str.intValue == 9000){
////             支付宝  调用 web 端支付成功返回的结果
//                // 支付成功
//                //通过通知中心发送通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"alipay" object:@"success" userInfo:nil];
//            }else{
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayMoney" object:@"order" userInfo:nil];
//            }
            
        }];
    
}



@end
