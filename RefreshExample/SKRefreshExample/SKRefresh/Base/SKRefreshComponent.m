//
//  SKRefreshComponent.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshComponent.h"
#import "SKRefreshConst.h"
@interface SKRefreshComponent ()
@property (strong,nonatomic)UIPanGestureRecognizer *pan;
@end
@implementation SKRefreshComponent
static inline void SKLog(SEL _cmd){
    
    NSLog(@" SKRefreshComponent 方法名：%@",NSStringFromSelector(_cmd));
    
};
#pragma mark--初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        NSLog(@"%@",NSStringFromSelector(_cmd));

        [self prepare];
        //默认是普通状态
        self.state = SKRefreshStateNormal;
        
    }
    return self;
}
- (void)prepare
{
 //基本属性
    self.autoresizingMask  =UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor blackColor];
    
}
- (void)layoutSubviews{
    
    [self placeSubviews];
    
    [super layoutSubviews];
}
- (void)placeSubviews{}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    //调用一下父类的方法，主要的作用是做初始化的工作
    [super willMoveToSuperview: newSuperview];
    SKLog(_cmd);
    //如果不是UIScrollView不做任何事情
    //TODO:这里之前少写了一个! 2017年4月8号
    if(newSuperview&&![newSuperview isKindOfClass:[UIScrollView class]])return;
    
    //旧的父控件移除监听
    [self removeObservers];
    if (newSuperview) {//新的父控件
        //设置宽度
        self.sk_w = newSuperview.sk_w;
        //设置位置
        self.sk_x = 0;
        //记录UIScrollView
        _scrollView  =(UIScrollView *)newSuperview;
        //设置永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        //记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        NSLog(@"_scrollViewOriginalInset =%@",NSStringFromUIEdgeInsets(_scrollViewOriginalInset));
        //添加监听
        [self addObservers];
        
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.state == SKRefreshStateWillRefresh) {
        //预防view还没显示出来就调用了beginRefreshing
        self.state = SKRefreshStateRefreshing;
    }
}

#pragma mark--KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:SKRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:SKRefreshKeyPathContentSize options:options context:nil];

    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:SKRefreshKeyPathPanState options:options context:nil];
}
#pragma mark--移除监听
- (void)removeObservers{
    
    [self.superview removeObserver:self forKeyPath:SKRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:SKRefreshKeyPathContentSize];
    [self.pan removeObserver:self forKeyPath:SKRefreshKeyPathPanState];
    self.pan = nil;

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //遇到这些情况就直接返回
    if (!self.userInteractionEnabled) {
        return;
    }
    //这个就算看不见也需要处理
    if ([keyPath isEqualToString:SKRefreshKeyPathContentSize])
    {
        [self scrollViewContentSizeDidChange:change];
    }
    //看不见
    if (self.hidden) {
        return;
    }
    if ([keyPath isEqualToString:SKRefreshKeyPathContentOffset])
    {
        
        [self scrollViewContentOffsetDidChange:change];
    }
    else if ([keyPath isEqualToString:SKRefreshKeyPathPanState])
    {
        [self scrollViewPanStateDidChange:change];
    }
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}
#pragma mark---公共方法
#pragma mark----设置回调对象和回调方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    self.refreshingTarget = target;
    self.refreshingAction =action;
}
- (void)setState:(SKRefreshState)state
{
    _state = state;
    //加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self setNeedsLayout];
    
    });
}
#pragma mark---进入刷新状态
- (void)beginRefreshing{
    
    [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
    
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    //只要正在刷新，就完全显示
    if (self.window) {
        self.state = SKRefreshStateRefreshing;
    }else{
        //预防在刷新中时，调用本方法使得head inset回置失败
        if (self.state!=SKRefreshStateRefreshing) {
            
            self.state = SKRefreshStateWillRefresh;
            //刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
            /*
             个人认为
             这个时候不用去画图，因为图形已经画好了，
             fix:hsk,2017年4月9号
             先去通过Core Animation setNeedsDisplay 获得View
             之后才有willMoveToSuperview
                   didMoveToSuperview
                   willMoveToWindow
                   didMoveToWindow
                   layoutSubviews
             */
//            [self setNeedsLayout];
        }
    }
}
- (void)beginRefreshingWithCompletionBlock:(void (^)())completionBlock
{
    self.beginRefreshingCompletionBlock = completionBlock;
    
    [self beginRefreshing];
}
#pragma mark---结束刷新状态
- (void)endRefreshing
{
    self.state = SKRefreshStateNormal;
}

- (void)endRefreshingWithCompletionBlock:(void (^)())completionBlock
{
    self.endRefreshingCompletionBlock = completionBlock;
    
    [self endRefreshing];
}
#pragma mark---是否正在刷新
- (BOOL)isRefreshing
{
    return self.state ==SKRefreshStateRefreshing||self.state==SKRefreshStateWillRefresh;
}
#pragma mark--自动切换透明度
- (void)setAutoChangeAlpha:(BOOL)autoChangeAlpha{
    
    self.automaticallyChangeAlpha = autoChangeAlpha;
}

- (BOOL)isAutoChangeAlpha
{
    return self.isAutomaticallyChangeAlpha;
}
- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha
{
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    if (self.isRefreshing) {
        return;
    }
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    }else{
        self.alpha = 1.0;
    }
}
#pragma mark---根据拖拽进度设置透明度

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    NSLog(@"透明度=%lf",pullingPercent);
    _pullingPercent  = pullingPercent;
    if (self.isRefreshing) {
        return;
    }
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha  =pullingPercent;
    }
}
#pragma mark---内部方法
- (void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            
            SKRefreshMsgSend(SKRefreshMsgTarget(self.refreshingTarget),self.refreshingAction,self);
        }
        if (self.beginRefreshingCompletionBlock) {
            
            self.beginRefreshingCompletionBlock();
        }
    });
}


#pragma mark---添加了一些方法，方便调试
- (void)removeFromSuperview{
    
    [super removeFromSuperview];
    SKLog(_cmd);
    
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index{
    [super insertSubview:view atIndex:index];
    SKLog(_cmd);
    
}
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2{
    
    [super exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    SKLog(_cmd);
    
}

- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    SKLog(_cmd);
    
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview{
    
    [super insertSubview:view belowSubview:siblingSubview];
    SKLog(_cmd);
    
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview{
    [super insertSubview:view aboveSubview:siblingSubview];
    SKLog(_cmd);
    
}

- (void)bringSubviewToFront:(UIView *)view{
    [super bringSubviewToFront:view];
    SKLog(_cmd);
    
}
- (void)sendSubviewToBack:(UIView *)view{
    [super sendSubviewToBack:view];
    SKLog(_cmd);
    
}

- (void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    SKLog(_cmd);
    
}
- (void)willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    SKLog(_cmd);
    
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    SKLog(_cmd);
    
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    SKLog(_cmd);
    
}
- (void)didMoveToWindow{
    [super didMoveToWindow];
    SKLog(_cmd);
    
}

- (BOOL)isDescendantOfView:(UIView *)view{
    SKLog(_cmd);
    
    return  [super isDescendantOfView:view];
}// returns YES for self.
- (nullable __kindof UIView *)viewWithTag:(NSInteger)tag{
    
    SKLog(_cmd);
    
    return [super viewWithTag:tag];
}// recursive search. includes self

// Allows you to perform layout before the drawing cycle happens. -layoutIfNeeded forces layout early
- (void)setNeedsLayout{
    
    [super setNeedsLayout];
    SKLog(_cmd);
    
}
- (void)layoutIfNeeded{
    [super layoutIfNeeded];
    SKLog(_cmd);
    
}

@end

@implementation UILabel (SKRefresh)

+(instancetype)sk_label
{
    UILabel *label = [[self alloc]init];
    label.font = SKRefreshLabelFont;
    label.textColor = SKRefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor  =[UIColor clearColor];
    return label;
}
- (CGFloat)sk_textWidth
{
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    if (self.text.length >0) {
#if defined (__IPHONE_OS_VERSION_MAX_ALLOWED) &&__IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
#else
        stringWidth = [self.text sizeWithFont:self.font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    return stringWidth;
}
@end
