
//
//  HomeBottomCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "HomeBottomCell.h"

#import "UIButton+MBHExpand.h"
@interface HomeBottomCell ()

@property(strong,nonatomic)NSMutableArray * contentArrays;

@end

@implementation HomeBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentArrays = [[NSMutableArray alloc]initWithObjects:@"腾讯视频",@"爱奇艺    ",@"优酷视频",@"乐视视频",@"芒果TV",@"PPTV    ", nil];
    NSMutableArray * imageNameArrays = [[NSMutableArray alloc]initWithObjects:@"ic_tencent",@"ic_aqy",@"ic_youku",@"ic_letv",@"hunantvlogo",@"pptv", nil];
    for (int i = 0; i<self.contentArrays.count; i++) {
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i%2*(APP_Width/2), 130*HEIGHT*(i/2), APP_Width/2, 130*HEIGHT)];
        button.tag = 1100+i;
        [button setTitle:self.contentArrays[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNameArrays[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [button addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
#pragma mark--tag:1100+i
-(void)btClick:(UIButton *)button{
   
    if ([_delegate respondsToSelector:@selector(HomeBottomCellDelegateSelectButtonWithText:)]) {
        [_delegate HomeBottomCellDelegateSelectButtonWithText:button.titleLabel.text];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
