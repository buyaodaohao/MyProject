//
//  JiHuoVIPVC.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JiHuoVIPVCDelegate <NSObject>
-(void)JiHuoVIPVCDelegateWithPaySuccess;

@end

@interface JiHuoVIPVC : BaseViewController
@property (assign, nonatomic) id<JiHuoVIPVCDelegate> delegate;

@end
