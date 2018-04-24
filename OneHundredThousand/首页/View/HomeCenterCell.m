
//
//  HomeCenterCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "HomeCenterCell.h"
#import "UIButton+MBHExpand.h"

#import <UShareUI/UShareUI.h>

@interface HomeCenterCell ()

@property (weak, nonatomic) IBOutlet UIButton *jiaoLiuBtClick;
@property (weak, nonatomic) IBOutlet UIButton *tuiJianBtClick;
@property (weak, nonatomic) IBOutlet UIButton *fenXiangBtClick;

@end

@implementation HomeCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [_jiaoLiuBtClick layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_tuiJianBtClick layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_fenXiangBtClick layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];


}
- (IBAction)btClick:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"交流群"]) {
        [self joinGroup:nil key:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"推荐赚钱"]) {
        if ([_delegate respondsToSelector:@selector(homeCenterCellDelegateBtClickWithText:)]) {
            [_delegate homeCenterCellDelegateBtClickWithText:sender.titleLabel.text];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"分享软件"]) {
     
        BOOL shareQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
        BOOL shareWx = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
        BOOL shareXinLang = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Sinaweibo://"]];
        
        if (!shareQQ) {
            
             [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_QQ)]];
        }
        if (!shareWx) {
            [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatSession)]];
        }
        if (!shareXinLang) {
            [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_Sina)]];
        }
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            
            [Common shareTextToPlatformWithShareType:platformType ShareImage:[UIImage imageNamed:@""] ShareUrl:@"http://39.108.151.95:8000/MyApp/apk/nB-release.apk" ShareTitle:@"VIP视频免费看啦" ShareContent:@"我发现一个可以破解全网VIP视频的APP，不用充钱享会员哦！"];
        }];
        
    }
}
- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"601534206",@"13e4e3aeead1ce59c15e2923b0991e93e4e663987f4a459785cbd18e34569a7b"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
