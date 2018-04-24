//
//  PersonOtherCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "PersonOtherCell.h"

#import "UIImageView+WebCache.h"


@interface PersonOtherCell ()

@end

@implementation PersonOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftImageV.contentMode = UIViewContentModeScaleAspectFit;

//    if (APP_Width == 320) {
        self.leftLabel.font = [UIFont systemFontOfSize:16.f];
        if (self.isDaiLiViewController) {
            self.rightLabel.font = [UIFont systemFontOfSize:14.f];
        }else{
            self.rightLabel.font = [UIFont systemFontOfSize:13.f];
        }
//    }
    
}
-(void)setIsDaiLiViewController:(BOOL)isDaiLiViewController{
    _isDaiLiViewController = isDaiLiViewController;
    
    if (!isDaiLiViewController) {
        self.imageTopHeight.constant = 29.99f;
        self.imageBottom.constant = 29.99f;
        self.imageRightWidth.constant = 0.01f;
        self.rightLabelRight.constant = 12.f;
        self.rightLabel.font = [UIFont systemFontOfSize:15.f];
        
        if (self.currentIndex.section == 0) {
            self.leftLabel.text = self.currentIndex.row == 0 ? @"我的推荐码:":@"微信UID:";

        }else if (self.currentIndex.section == 1){
            self.leftLabel.text = @"我的推荐所得:";
        }else if (self.currentIndex.section == 2){
            if (self.currentIndex.row == 0) {
                self.leftLabel.text = @"当前的迈思币兑换比例:";
            }else{
                self.imageTopHeight.constant = 10.f;
                self.imageBottom.constant = 10.f;
                self.imageRightWidth.constant = 10.01f;
                self.leftLabel.text =  self.currentIndex.row == 1 ?@"申请提现":@"发起转账";
                self.leftImageV.image = [UIImage imageNamed:self.currentIndex.row == 1 ? @"ic_cash":@"ic_transfer"];
            }
        }
    }
    
}
-(void)setCurrentIndex:(NSIndexPath *)currentIndex{
    _currentIndex = currentIndex;

    if (self.isDaiLiViewController) {
        if (currentIndex.section == 0) {
            self.imageRightWidth.constant = 5.f;
            self.imageLeftWidth.constant = 12.f;
            NSString * wxUidStr = User_Default_ObjectForKey(@"WX_Uid");
            if (wxUidStr.length == 0) {
                self.leftImageV.image = [UIImage imageNamed:@"ic_login_avator_default"];
                self.leftLabel.text = @"未登录";
            }else{
                [self.leftImageV sd_setImageWithURL:[NSURL URLWithString:User_Default_ObjectForKey(@"WX_Header_Url")] placeholderImage:[UIImage imageNamed:@"ic_login_avator_default"]];
                self.leftLabel.text = User_Default_ObjectForKey(@"WX_Name");
            }
        }else if (currentIndex.section == 1) {
            if (currentIndex.row == 0) {
                self.rightLabel.textColor = Gray_Text_COLOR;
            }
            self.leftImageV.image = [UIImage imageNamed:currentIndex.row
                                     == 0 ? @"vip_top":@"us_pro"];
            self.leftLabel.text = currentIndex.row == 0 ? @"卡密激活VIP": @"常见问题";
            self.rightLabel.text = currentIndex.row == 0 ? [NSString stringWithFormat:@"VIP剩余时长%.1f天",[User_Default_ObjectForKey(@"vipLeft") floatValue]]:@"";
        }else if (currentIndex.section == 2) {
            self.leftImageV.image = [UIImage imageNamed:@"wenhao"];
            self.leftLabel.text = @"关于我们";
            self.rightLabel.text = [NSString stringWithFormat:@"V%@",User_Default_ObjectForKey(@"Location_Version")];
        }
    }
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
