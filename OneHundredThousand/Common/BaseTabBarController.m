//
//  BaseTabBarController.m
//  JiaoBao
//
//  Created by zhukangkang on 2017/8/5.
//  Copyright © 2017年 ZKK. All rights reserved.
//

#import "BaseTabBarController.h"
#import "CustomNavigationVC.h"
#import "ZKKTabbar.h"


#import "PersonCenterVC.h"
#import "HomeVC.h"
#import "PersonCenterViewController.h"
#define APP_Store_ID @"1232101507"
#define Duration_Time 0.4

@interface BaseTabBarController ()


@end

@implementation BaseTabBarController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    // 设置全局status bar 文字颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

+(instancetype)baseTabBar{
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    return tabBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 替换tabbar
    [self setValue:[[ZKKTabbar alloc] init] forKeyPath:@"tabBar"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:self.tabBar.frame.size.height forKey:@"TABBAR_H"];
    [userDefaults synchronize];
    HomeVC * homeVC = [[HomeVC alloc] init];
    [self setupOneChildViewController:homeVC title:@"首页" image:@"ic_mainpage" selectedImage:@"ic_mainpage_sel"];
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
    [self setupOneChildViewController:personVC title:@"个人中心" image:@"ic_person2" selectedImage:@"ic_person_sel2"];
    
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    User_Default_SetObjectForKey(currentVersion, @"Location_Version")
    
    
//    dispatch_queue_t queue = dispatch_queue_create("获得版本号", DISPATCH_QUEUE_CONCURRENT);
//    Custom_Weak(queueWeak)
//    dispatch_async(queue, ^{
//        //检查APP的版本号
//        [queueWeak checkAPPVersion];
//    });
    
}
- (void)viewWillLayoutSubviews{
    
   
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(tabBarController.selectedIndex == 1){
        return NO;
    }else {
        return YES;
    }
    
}
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[CustomNavigationVC alloc] initWithRootViewController:vc]];
    
    //字体大小，颜色（未被选中时）
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Gray_Text_COLOR,NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];
    
    //字体大小，颜色（被选中时）
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Base_Color,NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];

}
#pragma mark--检测当前版本
-(void)checkAPPVersion{
    
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    User_Default_SetObjectForKey(currentVersion, @"Location_Version")
    //3从网络获取appStore版本号
//
//    NSURL * appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",APP_Store_ID]];
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithURL:appUrl  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
////        多线程
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                if (data == nil) {
//                    return;
//                }
//                NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//
//                NSArray *array = appInfoDic[@"results"];
//
//                if (array.count == 0) {
//                    return;
//                }
//                NSDictionary *dic = array[0];
//                NSString *appStoreVersion = dic[@"version"];
//
//                NSString * currentVersion = User_Default_ObjectForKey(@"Location_Version");
//                //设置版本号
//                currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//                if (currentVersion.length==2) {
//                    currentVersion  = [currentVersion stringByAppendingString:@"0"];
//                }else if (currentVersion.length==1){
//                    currentVersion  = [currentVersion stringByAppendingString:@"00"];
//                }
//                appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//                if (appStoreVersion.length==2) {
//                    appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
//                }else if (appStoreVersion.length==1){
//                    appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
//                }
//                //4当前版本号小于商店版本号,就更新
//                if([currentVersion floatValue] < [appStoreVersion floatValue]){
//                NSLog(@"版本更细");
//                //            UIAlertController * xiangCeAlertC = [UIAlertController alertControllerWithTitle:@"新版本更精彩" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                //            UIAlertAction * sheZhi = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                //                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", APP_Store_ID]];
//                //                [[UIApplication sharedApplication] openURL:url];
//                //            }];
//                //            [xiangCeAlertC addAction:sheZhi];
//                //            [self presentViewController:xiangCeAlertC animated:YES completion:nil];
//                     }
//            });
//
//    }];
//    [task resume];
    
}
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//      UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//      if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//              statusBar.backgroundColor = color;
//          }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
