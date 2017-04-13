//
//  SKRefreshBackFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshBackFooter.h"
@interface SKRefreshBackFooter ()
@property (assign,nonatomic)NSInteger lastRefreshCount;
@property (assign,nonatomic)CGFloat lastBottomDelta;
@end
@implementation SKRefreshBackFooter
#pragma mark---初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentSizeDidChange:nil];
}
#pragma mark ---实现父类的方法
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    //如果正在刷新，直接返回
    
    if (self.state==SKRefreshStateRefreshing) {
        return;
    }
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    //当前的contentOffset
    //FIXME:这里self.scrollView.sk_offsetY之前写成self.scrollView.sk_offsetX 默默鄙视自己10分钟
    CGFloat currentOffsetY = self.scrollView.sk_offsetY;
    //尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    //如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) {
        return;
    }
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY)/self.sk_h;
    
    //如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state ==SKRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        //普通 和即将刷新 的临界点
        CGFloat normal2PullingOffsetY = happenOffsetY +self.sk_h;
        
        if (self.state == SKRefreshStateNormal&&currentOffsetY >normal2PullingOffsetY) {
            //转为即将刷新状态
            self.state = SKRefreshStatePulling;
        }
        else if (self.state==SKRefreshStatePulling&&currentOffsetY<=normal2PullingOffsetY)
        {
         //转为普通状态
            self.state = SKRefreshStateNormal;
        }
    }
    //即将刷新&&手松开
    else if (self.state==SKRefreshStatePulling)
    {
        //开始刷新
        [self beginRefreshing];
        
    }
    else if(pullingPercent < 1)
    {
        self.pullingPercent = pullingPercent;
    }
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    //内容的高度
    CGFloat contentHeight = self.scrollView.sk_contentH+self.ignoredScrollViewContentInsetBottom;
    
    //表格的高度
    CGFloat scrollHeight = self.scrollView.sk_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom +self.ignoredScrollViewContentInsetBottom;
    
    //设置位置好尺寸
    self.sk_y = MAX(contentHeight, scrollHeight);
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    
    //根据状态来设置属性
    if (state ==SKRefreshStateNoMoreData||state==SKRefreshStateNormal) {
        //刷新完毕
        if (SKRefreshStateRefreshing==oldState) {
            //FIXME:?????
            [UIView animateWithDuration:SKRefreshSlowAnimationDuration animations:^{
                self.scrollView.sk_insetB -= self.lastBottomDelta;
                //自动调整透明度
                if (self.isAutomaticallyChangeAlpha) {
                    self.alpha = 0.0;
                }
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
        CGFloat deltaH = [self heightForContentBreakView];
        
        //刚刷新完毕
        if (SKRefreshStateRefreshing ==oldState&&deltaH >0&&self.scrollView.sk_totalDataCount!=self.lastRefreshCount) {
            self.scrollView.sk_offsetY = self.scrollView.sk_offsetY;
        }
    }
    else if (state==SKRefreshStateRefreshing)
    {
        //记录刷新前的数量
        self.lastRefreshCount =self.scrollView.sk_totalDataCount;
        
        [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.sk_h +self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH <0) {//如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom -self.scrollView.sk_insetB;
            self.scrollView.sk_insetB = bottom;
            self.scrollView.sk_offsetY = [self happenOffsetY]+self.sk_h;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}
- (void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        self.state = SKRefreshStateNormal;
    });
}
- (void)endRefreshingWithNoMoreData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = SKRefreshStateNoMoreData;
    });
}
#pragma mark--私有方法
#pragma mark---获得scrollView的内容 超出view的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.sk_h - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
    
}

#pragma mark  刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH >0)
    {
        return deltaH - self.scrollViewOriginalInset.top;
    }
    else{
        return -self.scrollViewOriginalInset.top;
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



























































































































































































































