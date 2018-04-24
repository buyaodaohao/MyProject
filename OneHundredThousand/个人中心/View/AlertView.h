//
//  AlertView.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ZKKAlertViewDelegate <NSObject>

-(void)ZKKAlertViewDelegateSelectStyle:(NSString *)stryle;

@end


@interface AlertView : UIView

@property(assign,nonatomic)BOOL  isTiXian;
+ (instancetype)nibFromXib;

@property (assign, nonatomic) id<ZKKAlertViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *topTextF;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTextFTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTextFHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;//240-54

@end
