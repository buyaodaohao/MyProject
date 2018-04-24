//
//  VideoAlertView.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2018/1/3.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (instancetype)nibFromXib;

@end
