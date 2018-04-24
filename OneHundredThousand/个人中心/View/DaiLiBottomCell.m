
//
//  DaiLiBottomCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "DaiLiBottomCell.h"

@interface DaiLiBottomCell ()


@end

@implementation DaiLiBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentLabel.textColor = Gray_Text_COLOR;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
