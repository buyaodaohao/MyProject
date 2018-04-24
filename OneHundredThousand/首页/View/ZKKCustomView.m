//
//  ZKKCustomView.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/28.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "ZKKCustomView.h"

@implementation ZKKCustomView

+ (instancetype)nibFromXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self creatCustomView];
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatCustomView];
    }
    return self;
}
-(void)creatCustomView{
  
    self.backgroundColor = Gray_View_COLOR;
    self.layer.cornerRadius = 8.f;
    self.clipsToBounds = YES;
    self.bgView.clipsToBounds = YES;
    self.bgView.layer.cornerRadius = 3.f;
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textColor = Gray_Text_COLOR;
    
    
}
- (IBAction)btClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(ZKKCustomViewDelegateSelectWithButtonText:)]) {
        [_delegate ZKKCustomViewDelegateSelectWithButtonText:self.titleLabel.text];
    }
    
}

@end
