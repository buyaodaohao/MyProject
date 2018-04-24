
//
//  VideoAlertView.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2018/1/3.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import "VideoAlertView.h"

@implementation VideoAlertView

+ (instancetype)nibFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self creatAlertView];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatAlertView];
    }
    return self;
}
-(void)creatAlertView{
    self.backgroundColor = RGB_Alpha(0, 0, 0, 0.8);

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
- (IBAction)kowBtClick:(id)sender {
    [self removeFromSuperview];
}

@end
