//
//  ZKKCustomView.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/28.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKKCustomViewDelegate <NSObject>


-(void)ZKKCustomViewDelegateSelectWithButtonText:(NSString *)text;

@end


@interface ZKKCustomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *taiBt;

+ (instancetype)nibFromXib;
@property (assign, nonatomic) id<ZKKCustomViewDelegate> delegate;

@end
