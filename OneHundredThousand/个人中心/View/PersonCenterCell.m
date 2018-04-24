//
//  PersonCenterCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "PersonCenterCell.h"

@implementation PersonCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if (APP_Width == 320) {
        self.cecnterLabel.font = [UIFont systemFontOfSize:16.f];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
