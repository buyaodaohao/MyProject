//
//Created by ESJsonFormatForMac on 17/12/26.
//

#import "UserMessageModel.h"

@implementation UserMessageModel

- (instancetype)initWithUserMessageDic:(NSDictionary *)dic{
    
    //     self = [super init];
    if (self = [super init]) {
        
        self.createdTime = [dic[@"createdTime"] integerValue];
        self.lastupdatedTime = dic[@"lastupdatedTime"];
        
        
//        @property (nonatomic, assign) NSInteger createdTime;
//
//        @property (nonatomic, assign) NSInteger enable;
//
//        @property (nonatomic, copy) NSString *uid;
//
//        @property (nonatomic, assign) NSInteger vipLeft;
//
//        @property (nonatomic, assign) NSInteger giveAmount;
//
//        @property (nonatomic, assign) NSInteger give_status;
//
//        @property (nonatomic, assign) NSInteger commendLeft;
//
//        @property (nonatomic, assign) NSInteger pointsLeft;
//
//        @property (nonatomic, copy) NSString *lastupdatedTime;
//
//        @property (nonatomic, copy) NSString *commendNo;
//
//        @property (nonatomic, assign) NSInteger ifFirst;
//
//        @property (nonatomic, assign) NSInteger commend2cash;
        
    }
    
    return self;
    
}
@end

