//
//  SKRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshNormalHeader.h"
#import "NSBundle+SKRefresh.h"
@interface SKRefreshNormalHeader ()
{
    __weak UIImageView *_arrowView;
}
@property (weak,nonatomic)UIActivityIndicatorView *loadView;
@end
@implementation SKRefreshNormalHeader

#pragma mark--懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc]initWithImage:[NSBundle sk_arrowImage]];
        [self addSubview:_arrowView =arrowView];
    }
    return _arrowView;
}
- (UIActivityIndicatorView *)loadView
{
    if (!_loadView) {
        UIActivityIndicatorView *loadView  =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadView.hidesWhenStopped = YES;
        [self addSubview:_loadView =loadView];
    }
    return _loadView;
}
#pragma mark---公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.loadView = nil;
    [self setNeedsLayout];
}
#pragma mark--重写父类的方法
- (void)prepare{
    [super prepare];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}
- (void)placeSubviews
{
    [super placeSubviews];
    //箭头 的中心点
    CGFloat arrowCenterX = self.sk_w *0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.sk_textWidth;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.sk_textWidth;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth/2 +self.labelLeftInset;
    }
    CGFloat arrowCenterY = self.sk_h * 0.5;
    CGPoint arrowCenter  = CGPointMake(arrowCenterX, arrowCenterY);
    
    //箭头
    if (self.arrowView.constraints.count ==0) {
        self.arrowView.sk_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    //圈圈
    if (self.loadView.constraints.count ==0) {
        self.loadView.center = arrowCenter;
    }
    self.arrowView.tintColor = self.stateLabel.textColor;
    
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    //根据状态做事情
    if(state ==SKRefreshStateNormal){
        
        if (oldState ==SKRefreshStateRefreshing) {
            
            self.arrowView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:SKRefreshSlowAnimationDuration animations:^{
                
                self.loadView.alpha = 0.0;
            } completion:^(BOOL finished) {
                //如果执行完动画发现不是Normal状态，就直接返回，进入其他状态
                if (self.state != SKRefreshStateNormal) {
                    return ;
                }
                self.loadView.alpha = 1.0;
                [self.loadView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        }else{
            [self.loadView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    else if (state ==SKRefreshStatePulling)
    {
        [self.loadView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.00001 - M_PI);
        }];//FIXME:???????
    }
    else if (state ==SKRefreshStateRefreshing){
        self.loadView.alpha  = 1.0;//防止refreshing-->normal的动画完毕动作没有被执行
        [self.loadView startAnimating];
        self.arrowView.hidden = YES;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end







































































