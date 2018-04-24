//
//  AlertView.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()<UITextFieldDelegate>


@end


@implementation AlertView

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
    self.backgroundColor = RGB_Alpha(0, 0, 0, 0.5);
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.messageLabel.textColor = Gray_Text_COLOR;
    self.topTextF.delegate = self;
    self.bottomTextF.delegate = self;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    self.hidden = YES;
    
}
- (IBAction)sureBtClick:(id)sender {
    [self endEditing:YES];
    
    if (self.isTiXian) {
        
        if (self.topTextF.text.length == 0) {
            Show_Toast(@"请输入支付宝账号", 0.5)
            return;
        }
        if (self.bottomTextF.text.length == 0) {
            Show_Toast(@"请输入账户真实姓名", 0.5)
            return;
        }
    }else{
        if (self.topTextF.text.length == 0) {
            Show_Toast(@"请填写转账迈思币的数量", 0.5)
            return;
        }
        if (self.bottomTextF.text.length == 0) {
            Show_Toast(@"请填写对方推荐码", 0.5)
            return;
        }
        
    }
    
    self.hidden = YES;
//    CGFloat currentNumber =  [User_Default_ObjectForKey(@"commendLeft") floatValue];
//    if (currentNumber < [self.topTextF.text floatValue]) {
//        Show_Toast(@"请输入不大于自己的迈思币数量", 0.8)
//        return;
//    }
    NSString * styleStr = @"转账";
    if (self.isTiXian) {
        styleStr = @"提现";
    }
    if ([_delegate respondsToSelector:@selector(ZKKAlertViewDelegateSelectStyle:)]) {
        [_delegate ZKKAlertViewDelegateSelectStyle:styleStr];
    }
 
}
-(void)setIsTiXian:(BOOL)isTiXian{
    _isTiXian = isTiXian;
    self.bottomTextF.text = @"";
    self.topTextF.text = @"";
    
    if (isTiXian) {
        self.titleLabel.text = @"输入支付宝账号";
        self.topTextF.placeholder = @"请填写正确支付宝账户";
        self.bottomTextF.placeholder = @"请输入账户真实姓名";
//        self.bottomTextFTopHeight.constant = 0.01f;
//        self.bottomTextFHeight.constant = 0.01f;
//        self.bgViewHeight.constant = 240-54;
        
    }else{
        self.titleLabel.text = @"输入对方推荐码和转账数量";
        self.topTextF.placeholder = @"请填写转账迈思币的数量";
        self.bottomTextF.placeholder = @"请填写对方推荐码";
//        self.bottomTextFTopHeight.constant = 20.01f;
//        self.bottomTextFHeight.constant = 34.01f;
//        self.bgViewHeight.constant = 240;
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor yellowColor].CGColor;
    textField.layer.borderWidth = 1.0f;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderWidth = 0.0f;
    textField.layer.borderColor = Gray_View_COLOR.CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
