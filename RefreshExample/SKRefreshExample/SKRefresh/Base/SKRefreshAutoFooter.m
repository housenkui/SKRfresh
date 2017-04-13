//
//  SKRefreshAutoFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshAutoFooter.h"
@interface SKRefreshAutoFooter ()
@end
@implementation SKRefreshAutoFooter
#pragma  mark---初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {//新的父控件
        if(self.hidden ==NO){
            
            self.scrollView.sk_insetB += self.sk_h;
        }
        //设置位置
        self.sk_y = _scrollView.sk_contentH;
    }else{//被移除了
        if (self.hidden==NO) {
            self.scrollView.sk_insetB -= self.sk_h;
        }
        
    }
}
#pragma mark---过期方法
- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)appearencePercentTriggerAutoRefresh
{
    self.triggerAutomaticallyRefreshPercent = appearencePercentTriggerAutoRefresh;
}
- (CGFloat)appearencePercentTriggerAutoRefresh
{
    return self.triggerAutomaticallyRefreshPercent;
}
#pragma mark---实现父类的方法
- (void)prepare
{
    [super prepare];
    
    //默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    //设置为默认状态
    self.automaticallyRefresh = YES;
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    //设置位置
    self.sk_y = self.scrollView.sk_contentH;
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state!=SKRefreshStateNormal||!self.automaticallyRefresh||self.sk_y==0) {
        return;
    }
    if (_scrollView.sk_insetT+_scrollView.sk_contentH>_scrollView.sk_h) {//内容超过一个屏幕
        //这里的_scrollView.sk_contentH替换掉self.sk_y更为合理
        if (_scrollView.sk_offsetY >= _scrollView.sk_contentH - _scrollView.sk_h+self.sk_h*self.triggerAutomaticallyRefreshPercent+_scrollView.sk_insetB-self.sk_h) {
            //防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            //这里判断offset的Y值，大于旧的值就进入刷新状态
            if (new.y <= old.y) {
                return;
            }
            //当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    if (self.state!=SKRefreshStateNormal) {
        return;
    }
    if(_scrollView.panGestureRecognizer.state ==UIGestureRecognizerStateEnded){
        //手松开
        if (_scrollView.sk_insetT+_scrollView.sk_contentH<=_scrollView.sk_h) {
            //不够一个屏幕
            if (_scrollView.sk_offsetY >= -_scrollView.sk_insetT) {
                //向上拽
                [self beginRefreshing];
            }
        }
        else
        {
            //超出一个屏幕
            if (_scrollView.sk_offsetY >=_scrollView.sk_contentH +_scrollView.sk_insetB-_scrollView.sk_h) {
                [self beginRefreshing];
            }
        }
    }
}

- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    if (state ==SKRefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    }
    else if (state==SKRefreshStateNoMoreData||state==SKRefreshStateNormal)
    {
        if (SKRefreshStateRefreshing ==oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
}
- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden&&hidden) {
        self.state = SKRefreshStateNormal;
        
        self.scrollView.sk_insetB -=self.sk_h;
    }else if (lastHidden&&!hidden)
    {
        self.scrollView.sk_insetB += self.sk_h;
        
        //设置位置
        self.sk_y = _scrollView.sk_contentH;
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











































































































































































































