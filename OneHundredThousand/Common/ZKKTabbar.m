
//
//  ZKKTabbar.m
//  OneHundredThousand
//
//  Created by ZhuKK on 2017/12/22.
//  Copyright © 2017年 ZhuKK. All rights reserved.
//

#import "ZKKTabbar.h"


@interface ZKKTabbar()
@property(strong,nonatomic)UIButton *  publishButton;
@end


@implementation ZKKTabbar

- (nonnull instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 44, 44)];
        self.publishButton.ZKK_centerX = APP_Width/2;
        
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"ic_vip_play"] forState:UIControlStateNormal];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"ic_vip_play"] forState:UIControlStateHighlighted];
        [self addSubview:self.publishButton];
        [self.publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)publishClick
{
    NSLog(@"publishClick");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 原来的2个
    CGFloat width = self.ZKK_width / 3;
    int index = 0;
    for (UIControl *control in self.subviews) {
        
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
        
        control.ZKK_width = width;
        control.ZKK_x = index > 0 ? width * (index + 1) : width * index;
        index++;
    }
}
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.publishButton];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.publishButton pointInside:newP withEvent:event]) {
            return self.publishButton;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
