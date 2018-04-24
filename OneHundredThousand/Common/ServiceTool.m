//
//  ServiceTool.m
//  JiaoBao
//
//  Created by FaTuZhiNengZhuKK on 2017/8/21.
//  Copyright © 2017年 ZKK. All rights reserved.
//

#import "ServiceTool.h"
#import "BaseService.h"
#import "UIView+Toast.h"

@implementation ServiceTool

+(void)postBaseWithUrl:(NSString *)url Params:(NSDictionary*)params ShowHUD:(BOOL)showHUD  success:(SuccessBlock)success fail:(FailBlock)fail{
    
    [BaseService postWithUrl:url params:params success:^(id response) {
        
        success(response);
     
    } fail:^(NSError *error) {
        if (fail) {
            Show_Toast(@"请连接网络后重新开启APP", 1.3)
            NSLog(@"--errorerrorerror----%@",error);
            if (fail) {
                fail(error);
            }
        }
    } showHUD:showHUD];
    
}
+(void)getBaseWithUrl:(NSString *)url Params:(NSDictionary*)params ShowHUD:(BOOL)showHUD  success:(SuccessBlock)success fail:(FailBlock)fail{
    
    [BaseService getWithUrl:url params:params success:^(id response) {
        success(response);
    } fail:^(NSError *error) {
        Show_Toast(@"请连接网络后重新开启APP", 1.3)
        NSLog(@"--errorerrorerror----%@",error);

        if (fail) {
            fail(error);
        }
        
    } showHUD:showHUD];
}
@end
