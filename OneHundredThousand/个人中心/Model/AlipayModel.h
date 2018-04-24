//
//  AlipayModel.h
//  MasterLicense
//
//  Created by FaTuZhiNengZhuKK on 16/8/8.
//  Copyright © 2016年 FangTuZhiNengZhuKK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayModel : NSObject


//@property (nonatomic, assign) float price;
//@property (nonatomic, copy) NSString *subject;
//@property (nonatomic, copy) NSString *body;
//@property (nonatomic, copy) NSString *orderId;

//@property(nonatomic, strong)NSMutableArray *productList;

+(void)payOrderPayMessage:(NSString *)message SuccessCallBack:(void (^)(NSDictionary * dic))successCallBack;

@end
