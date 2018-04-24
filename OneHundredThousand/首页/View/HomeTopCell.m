//
//  HomeTopCell.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/26.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "HomeTopCell.h"
#import "ZXCycleScrollView.h"
#import "ZKKRollView.h"

@interface HomeTopCell ()<ZXCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (nonatomic,strong) ZXCycleScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *messagebgView;

@property(strong,nonatomic)ZKKRollView * rollView;
@end

@implementation HomeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}
-(void)setImageUrlArrays:(NSMutableArray *)imageUrlArrays{
    _imageUrlArrays = imageUrlArrays;
     self.scrollView.sourceDataArr = imageUrlArrays;
    
}

-(void)setMessageArrays:(NSMutableArray *)messageArrays{
    _messageArrays = messageArrays;
    self.rollView.contentArrays = messageArrays;
}
-(ZKKRollView *)rollView{
    if (!_rollView) {
        _rollView = [[ZKKRollView alloc]initWithFrame:self.messagebgView.bounds];
        [self.rollView startPlayWithTimeInterval:0.01];
        [self.messagebgView addSubview:_rollView];
    }
    return _rollView;
}
-(ZXCycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [ZXCycleScrollView  initWithFrame:CGRectMake(0, 0, APP_Width, 195) withMargnPadding:5 withImgWidth:APP_Width - 60 dataArray:nil] ;
        _scrollView.delegate = self;
        [self.topBgView addSubview:self.scrollView];
        self.scrollView.autoScroll = YES;
        self.scrollView.autoScrollTimeInterval = 5.f;
    }
    return _scrollView;
}
#pragma mark -- ZXCycleScrollViewDelegate
-(void)zxCycleScrollView:(ZXCycleScrollView *)scrollView didScrollToIndex:(NSInteger)index {
//    NSLog(@"index------%lu",index);
}
-(void)zxCycleScrollView:(ZXCycleScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"点击了----index------%lu",index);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
