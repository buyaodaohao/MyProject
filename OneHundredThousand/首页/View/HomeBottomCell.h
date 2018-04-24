//
//  HomeBottomCell.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeBottomCellDelegate <NSObject>

-(void)HomeBottomCellDelegateSelectButtonWithText:(NSString *)text;

@end


@interface HomeBottomCell : UITableViewCell

@property (assign, nonatomic) id<HomeBottomCellDelegate> delegate;

@end
