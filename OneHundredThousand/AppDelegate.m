//
//  AppDelegate.m
//  OneHundredThousand
//
//  Created by FaTuZhiNengZhuKK on 2017/8/3.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import <UMSocialCore/UMSocialCore.h>


#import <BmobSDK/Bmob.h>

#import <AlipaySDK/AlipaySDK.h>

#define Wechat_Id @"wx058ff9dbb47058a0"//微信开发者账号的Id
#define Wechat_Secret @"92580ff3bf379dbfae5a3c676914c4b1" //微信开发者账号的Secret
#define QQ_Id @"1106486857"//QQ的ID
#define QQ_KEY @"mYnWmd6Caa28d5zJ"//QQ的Key

#define XL_Key @"1643151326"
#define XL_Secret @"b8bc9ed471127abab76e55548ae2a276"
#define XL_Url @"http://39.108.151.95:8000/"


#define UM_KEY @"5a3cb88ca40fa32d0d0002dc"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    BaseTabBarController * tabBar = [BaseTabBarController baseTabBar];
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
    
    [self creatUM];
    
    [Bmob registerWithAppKey:@"7dbcf4d732ce37e37fd7a619fdbdb663"];

    
    return YES;
}
-(void)creatUM{
   
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_KEY];
    
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wechat_Id appSecret:Wechat_Secret redirectURL:nil];
    
    /* 设置分享到QQ互联的appID
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_Id  appSecret:nil redirectURL:XL_Url];
    
    /*
     设置新浪的appKey和appSecret
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:XL_Key  appSecret:XL_Secret redirectURL:XL_Url];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Qzone)]];
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result1111111 = %@",resultDic);
                NSInteger code = [[resultDic objectForKey:@"resultStatus"] integerValue];
                if (code == 9000) {
                    //支付宝
                    Show_Toast(@"恭喜您充值VIP成功", 1.3)
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"alipay" object:@"success" userInfo:resultDic];
                }else{
                    Show_Toast(@"充值失败", 1.3)
                }
            }];
        }
        
    }
    return result;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                
                NSInteger code = [[resultDic objectForKey:@"resultStatus"] integerValue];
                NSLog(@"result2222222 = %@",resultDic);
                if (code == 9000) {
                    //支付宝
                    Show_Toast(@"恭喜您充值VIP成功", 1.3)

                    [[NSNotificationCenter defaultCenter] postNotificationName:@"alipay" object:@"success" userInfo:resultDic];
                }else{
                    
                    Show_Toast(@"充值失败", 1.3)
                }
        
        }];
        }
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
