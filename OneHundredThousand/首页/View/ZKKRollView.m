

#import "ZKKRollView.h"
#import "UIView+Frame.h"

#define BASE_WIDTH  self.bounds.size.width
#define BASE_HEIGHT  self.bounds.size.height
@interface ZKKRollView ()



@property(strong,nonatomic)UILabel * leftLabel;
@property(strong,nonatomic)UILabel * rightLabel;

@property (strong, nonatomic) NSTimer * timer;

@property (assign, nonatomic)NSTimeInterval timerInterval;//定时器间隔时间

@property(assign,nonatomic)CGFloat  contentWidth;

@property(strong,nonatomic)NSString * topContentStr;
@property(strong,nonatomic)NSString * bottomContentStr;

@property(assign,nonatomic)BOOL  isLeftMove;


@end
@implementation ZKKRollView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self creatRollView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self creatRollView];
    }
    return self;
}
- (void)creatRollView{
    self.backgroundColor =[UIColor clearColor];
    self.contentWidth = BASE_WIDTH;
    self.isLeftMove = YES;
    self.clipsToBounds = YES;
}
-(void)setContentArrays:(NSMutableArray *)contentArrays{
    _contentArrays = contentArrays;
    NSInteger contentNumber = contentArrays.count;
    self.topContentStr = contentArrays[0];
    self.contentWidth = MAX(([self getWidthWithText:self.topContentStr Font:15] + 100), BASE_WIDTH);
    if (contentNumber == 2) {
        self.bottomContentStr = contentArrays[1];
        self.contentWidth = MAX(self.contentWidth, ([self getWidthWithText:self.bottomContentStr Font:15] + 100));
    }
    if (contentNumber == 1) {
        self.leftLabel.text = self.topContentStr;
        self.rightLabel.text = self.topContentStr;
    }else{
        self.leftLabel.text = [NSString stringWithFormat:@"%@\n%@",self.topContentStr,self.bottomContentStr];
        self.rightLabel.text = [NSString stringWithFormat:@"%@\n%@",self.topContentStr,self.bottomContentStr];
    }
    
}

#pragma mark--开启定时器
- (void)startPlayWithTimeInterval:(NSTimeInterval)secondTimer{
    
    self.timerInterval = secondTimer;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:secondTimer target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
- (void)stopTimer{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)timerAction{
    
    self.leftLabel.ZKK_x  -= 0.3;
    self.rightLabel.ZKK_x  -= 0.3;
    
    if (self.leftLabel.ZKK_x <= -self.contentWidth) {
        self.leftLabel.ZKK_x = self.contentWidth;
    }
    if (self.rightLabel.ZKK_x <= -self.contentWidth) {
      self.rightLabel.ZKK_x = self.contentWidth;
    }
}

- (void)timerDelay:(NSTimeInterval)secondTimer
{
    if (_timer == nil) {
        return;
    }
    //从当前时间开始，若时间后继
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:secondTimer]; [self.timer setFireDate:startDate];
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentWidth, BASE_HEIGHT)];
        _leftLabel.numberOfLines = 0;
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:_leftLabel];
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentWidth, 0, self.contentWidth, BASE_HEIGHT)];
        _rightLabel.numberOfLines = 0;
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}
#pragma mark -根据字符串返回字符串的宽度
-(CGFloat)getWidthWithText:(NSString *)text Font:(CGFloat)font{
    
    NSDictionary *attrDic = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:attrDic context:nil];
    
    return textRect.size.width;
}
@end
