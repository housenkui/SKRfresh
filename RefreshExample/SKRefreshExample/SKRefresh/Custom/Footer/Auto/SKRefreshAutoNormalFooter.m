//
//  SKRefreshAutoNormalFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshAutoNormalFooter.h"
@interface SKRefreshAutoNormalFooter ()
@property (weak,nonatomic)UIActivityIndicatorView *loadingView;
@end
@implementation SKRefreshAutoNormalFooter
#pragma mark---懒加载子控件
- (UIActivityIndicatorView *)loadView
{
    if (!_loadingView) {
        
        UIActivityIndicatorView *loadingView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView =  nil;
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
    if (self.loadingView.constraints.count) {
        return;
    }
    
    //圈圈
    CGFloat loadingCenterX = self.sk_w *0.5;
    if (!self.isRefreshingTitleHidden) {
        
        loadingCenterX -= self.stateLabel.sk_textWidth*0.5+self.labelLeftInset;
    }
    CGFloat loadingCenterY = self.sk_h*0.5;
    self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    
    //根据状态做事情
    if (state ==SKRefreshStateNoMoreData||state ==SKRefreshStateNormal) {
        [self.loadingView stopAnimating];
    }
    else if (state ==SKRefreshStateRefreshing)
    {
        [self.loadingView startAnimating];
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





































































































































































































































































