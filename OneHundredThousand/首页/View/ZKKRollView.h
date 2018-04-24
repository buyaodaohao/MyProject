

#import <UIKit/UIKit.h>

@interface ZKKRollView : UIView

@property (strong, nonatomic) NSMutableArray * contentArrays;


- (void)startPlayWithTimeInterval:(NSTimeInterval)secondTimer;//定时器开始播放，当视图即将出现的时候记得调用
- (void)stopTimer;//当视图将要消失的时候记得调用

@end
