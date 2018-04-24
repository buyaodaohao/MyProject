//
//  PersonOtherCell.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/25.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonOtherCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeftWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageRightWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLabelRight;



@property(strong,nonatomic)NSIndexPath * currentIndex;

@property(assign,nonatomic)BOOL  isDaiLiViewController;

@end
