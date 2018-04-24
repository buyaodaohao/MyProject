//
//Created by ESJsonFormatForMac on 17/12/26.
//

#import <Foundation/Foundation.h>


@interface UserMessageModel : NSObject

/**
 * uid : 11  微信UID
 * vipLeft : 0 VIP剩余天数
 * pointsLeft : 0   积分剩余
 * commendLeft : 0  迈思币剩余
 * createdTime : 1511934467493 后台注册时间
 * lastupdatedTime : null
 * enable : 1
 * commendNo : null 推荐码（个人信息页）
 * ifFirst : 1  （是否为首充用户）
 * giveAmount: 50.0 （获得的系统赠送迈思币数量）
 * private double commend2cash; 当前迈思币兑换的RMB数量
 */

@property (nonatomic, assign) NSInteger createdTime;

@property (nonatomic, assign) NSInteger enable;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) NSInteger vipLeft;

@property (nonatomic, assign) NSInteger giveAmount;

@property (nonatomic, assign) NSInteger give_status;

@property (nonatomic, assign) NSInteger commendLeft;

@property (nonatomic, assign) NSInteger pointsLeft;

@property (nonatomic, copy) NSString *lastupdatedTime;

@property (nonatomic, copy) NSString *commendNo;

@property (nonatomic, assign) NSInteger ifFirst;

@property (nonatomic, assign) NSInteger commend2cash;

- (instancetype)initWithUserMessageDic:(NSDictionary *)dic;

@end
