//
//  SKRefreshComponent.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKRefreshConst.h"
#import "UIView+SKExtension.h"
#import "UIScrollView+SKRefresh.h"
#import "UIScrollView+SKExtension.h"
#import "NSBundle+SKRefresh.h"

/*刷新控件的状态*/
typedef  NS_ENUM(NSInteger,SKRefreshState){
    /*普通闲置状态*/
    SKRefreshStateNormal = 1,
    /*松开就可以进行刷新的状态*/
    SKRefreshStatePulling,
    /*正在刷新中的状态*/
    SKRefreshStateRefreshing,
    /*即将刷新的状态*/
    SKRefreshStateWillRefresh,
    /*所有数据加载完毕，没有更多的数据了*/
    SKRefreshStateNoMoreData
};
/*进入刷新状态的回调*/
typedef void (^SKRefreshComponentRefeshingBlock)();
/*开始刷新后的回调 (进入刷新状态后的回调)*/
typedef void (^SKRefreshComponentbeginRefreshCompletionBlack)();
/*结束刷新后的回调*/
typedef void (^SKRefreshComponentEndRefreshingCompletionBlock)();

/*刷新控件的基类*/
@interface SKRefreshComponent : UIView
{
    /*记录scrollView刚开始的insert*/
    UIEdgeInsets _scrollViewOriginalInset;
    /*父控件*/
    __weak UIScrollView *_scrollView;
}
#pragma mark---刷新回调
/*正在刷新的回调*/
@property (nonatomic,copy) SKRefreshComponentRefeshingBlock refreshingBlock;

/*设置回调对象和回调方法*/
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;

/*回调对象*/
@property (weak,nonatomic) id refreshingTarget;

/*回调方法*/
@property (assign,nonatomic)SEL refreshingAction;

/*触发回调（交给子类去调用）*/

- (void)executeRefreshingCallback;

#pragma mark ---刷新状态控制
/*进入刷新状态*/
- (void)beginRefreshing;
- (void)beginRefreshingWithCompletionBlock:(void(^)())completionBlock;

/*开始刷新后的回调(进入刷新状态后的回调)*/
@property (copy,nonatomic)SKRefreshComponentbeginRefreshCompletionBlack beginRefreshingCompletionBlock;
/*结束刷新的回调*/
@property (copy,nonatomic)SKRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;

/*结束刷新状态*/
- (void)endRefreshing;
- (void)endRefreshingWithCompletionBlock:(void (^)())completionBlock;

/*是否正在刷新*/
- (BOOL)isRefreshing;

/*刷新状态  一般交给子类内部实现*/
@property (nonatomic,assign)SKRefreshState state;


#pragma mark---交给子类去访问
/* 记录scrollView刚开始的inset*/
@property (assign,nonatomic,readonly)UIEdgeInsets scrollViewOriginalInset;

/*父控件*/
@property (weak,nonatomic,readonly)UIScrollView *scrollView;

#pragma mark---交给子类们去实现
/*初始化*/
- (void)prepare  NS_REQUIRES_SUPER;
/*摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/*当scrollView的contentOffset发生改变的时候调用*/
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER ;
/*当scrollview的contentSize 发生改变的时候调用*/
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/*scrollView的拖拽状态发生改变的时候调用*/
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;


#pragma mark--其他
/*拉拽的百分比 交给子类重写*/
@property (assign,nonatomic)CGFloat pullingPercent;

/*根据拖拽比例自动切换透明度*/
@property (nonatomic,assign,getter=isAutoChangeAlpha)BOOL autoChangeAlpha SKRefreshDeprecated("请使用automaticallyChangeAlpha属性");

/*根据拖拽比例自动切换透明度*/
@property (assign,nonatomic,getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;
@end


@interface UILabel (SKRefresh)
+ (instancetype)sk_label;
- (CGFloat)sk_textWidth;
@end

