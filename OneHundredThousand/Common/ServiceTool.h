//
//  ServiceTool.h
//  JiaoBao
//
//  Created by FaTuZhiNengZhuKK on 2017/8/21.
//  Copyright © 2017年 ZKK. All rights reserved.
//

#import <Foundation/Foundation.h>


// typedef 自定义一个类型，除系统以外的类型
//定义一个Block类型
typedef void(^SuccessBlock)(id  results);
typedef void(^FailBlock)(NSError *error);

@interface ServiceTool : NSObject


/**
 
 */
+(void)postBaseWithUrl:(NSString *)url Params:(NSDictionary*)params ShowHUD:(BOOL)showHUD  success:(SuccessBlock)success fail:(FailBlock)fail;


/**
 
 */
+(void)getBaseWithUrl:(NSString *)url Params:(NSDictionary*)params ShowHUD:(BOOL)showHUD  success:(SuccessBlock)success fail:(FailBlock)fail;

@end
