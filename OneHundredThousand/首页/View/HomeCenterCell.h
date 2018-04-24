//
//  HomeCenterCell.h
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCenterCellDelegate <NSObject>

-(void)homeCenterCellDelegateBtClickWithText:(NSString *)buttonText;

@end

@interface HomeCenterCell : UITableViewCell

@property (assign, nonatomic) id<HomeCenterCellDelegate> delegate;


@end
