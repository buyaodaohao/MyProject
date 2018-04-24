//
//  ModuleCollectionViewCell.m
//  OneHundredThousand
//
//  Created by SY-iMAC-001 on 2018/4/23.
//  Copyright © 2018年 ZhuKK. All rights reserved.
//

#import "ModuleCollectionViewCell.h"

@interface ModuleCollectionViewCell ()
@property(nonatomic,strong)UIImageView *appIconImageView;
@property(nonatomic,strong)UILabel *appNameLabel;
@end
@implementation ModuleCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
        {
        _appIconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_appIconImageView];
        
        _appNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_appNameLabel];
        }
    return self;
}
-(void)layoutSubviews
{
    _appIconImageView.frame = CGRectMake((self.frame.size.width - 120 / 3.0) * 0.5, 16, 120 / 3.0, 120 / 3.0);
        //未读数。
    _appIconImageView.image = [UIImage imageNamed:_model.module_icon];
    _appNameLabel.frame = CGRectMake(0, _appIconImageView.frame.origin.y + _appIconImageView.frame.size.height + 39.0 / 3.0, self.frame.size.width, 39.0 / 3.0);
    _appNameLabel.font = [UIFont systemFontOfSize:39.0 / 3.0];
    _appNameLabel.textAlignment = NSTextAlignmentCenter;
    _appNameLabel.textColor = [UIColor colorWithRed:(CGFloat)119 / 255 green:(CGFloat)119 / 255 blue:(CGFloat)119 / 255 alpha:1.0];
    _appNameLabel.text = _model.module_name;
}
@end
