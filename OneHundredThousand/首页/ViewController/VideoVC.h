//
//  VideoVC.h
//  TestVideo
//
//  Created by ZhuKK on 2017/12/21.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoVCDelegate <NSObject>
-(void)VideoVCDelegateSelectBackBotton;

@end

@interface VideoVC : UIViewController

@property(strong,nonatomic)NSString * urlStr;
@property(strong,nonatomic)NSString * titleStr;
@property(strong,nonatomic)NSMutableArray * videoArrays;
@property(strong,nonatomic)NSString * onlyVideoUrl;
@property (assign, nonatomic) id<VideoVCDelegate> delegate;

@end
