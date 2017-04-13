//
//  SKRefreshBackNormalFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshBackNormalFooter.h"
#import "NSBundle+SKRefresh.h"
@interface SKRefreshBackNormalFooter ()
{
    __weak UIImageView *_arrowView;
}
@property (weak,nonatomic)UIActivityIndicatorView *loadingView;
@end
@implementation SKRefreshBackNormalFooter
#pragma mark---懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        
        UIImageView *arrowView = [[UIImageView alloc]initWithImage:[NSBundle sk_arrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma mark---重写父类的方法
- (void)prepare
{
    [super prepare];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}
- (void)placeSubviews
{
    [super placeSubviews];
    
    //箭头的中心点
    CGFloat arrowCenterX = self.sk_w *0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= self.labelLeftInset +self.stateLabel.sk_textWidth * 0.5;
    }
    CGFloat arrowCenterY = self.sk_h *0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    //箭头
    if (self.arrowView.constraints.count ==0) {
        self.arrowView.sk_size  =self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    //圈圈
    if (self.loadingView.constraints.count ==0) {
        self.loadingView.center = arrowCenter;
    }
    self.arrowView.tintColor = self.stateLabel.textColor;
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    
    //根据状态做事情
    if (state ==SKRefreshStateNormal) {
        if (oldState == SKRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformMakeRotation(0.00001 - M_PI);
            [UIView animateWithDuration:SKRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        }
        else
        {
            self.arrowView.hidden = NO;
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
        }
    }
    else if(state ==SKRefreshStatePulling)
    {
        self.arrowView.hidden = NO;
        [self.loadingView stopAnimating];
        [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformIdentity;
        }];
    }
    else if (state ==SKRefreshStateRefreshing)
    {
        self.arrowView.hidden = YES;
        [self.loadingView startAnimating];
    }
    else if (state ==SKRefreshStateNoMoreData)
    {
        self.arrowView.hidden  =YES;
        [self.loadingView stopAnimating];
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


















































