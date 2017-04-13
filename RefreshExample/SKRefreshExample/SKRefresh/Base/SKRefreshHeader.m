//
//  SKRefreshHeader.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshHeader.h"
@interface SKRefreshHeader ()
//FIXME:？？？？？what is it  mean??
@property (assign,nonatomic)CGFloat insetTDelta;
@end
@implementation SKRefreshHeader
#pragma mark--构造方法
+ (instancetype)headerWithRefreshingBlock:(SKRefreshComponentRefeshingBlock)refreshingBlock
{
    /*
     init 会调用到父类的initWithFrame:并传送CGRectZero参数
     */
    NSLog(@"%@",NSStringFromSelector(_cmd));

    SKRefreshHeader *cmp =[[self alloc]init];
    
    
    cmp.refreshingBlock = refreshingBlock;
    
    return cmp;
}
+(instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    SKRefreshHeader *cmp = [[self alloc]init];
    NSLog(@"cmp1 =%@",cmp);

    [cmp setRefreshingTarget:target refreshingAction:action];
    NSLog(@"cmp2 =%@",cmp);
    return cmp;//走完这一步，
    /*
     self.tableView.sk_header =[SKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
     方法的右边走完了
     */
    
}
#pragma maek---覆盖父类的方法
- (void)prepare
{
    [super prepare];
    //设置key
    self.lastUpdatedTimeKey = SKRefreshHeaderLastUpdatedTimeKey;
    
    //设置高度
    self.sk_h = SKRefreshHeaderHeight;
    //FIXME:在这里设置高度
    
}
- (void)placeSubviews
{
    [super placeSubviews];
    //设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    //FIXME:????
    self.sk_y = -self.sk_h -self.ignoredScrollViewContentInsetTop;
    /*在这里设置Y轴*/
    NSLog(@"self.sk_y =%lf",self.sk_y);
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange: change];
    //在刷新的refreshing状态
    if (self.state == SKRefreshStateRefreshing) {
        if (self.window == nil) {
            return;
        }
        
        NSLog(@"self.scrollView.sk_offsetY =%lf",-self.scrollView.sk_offsetY);
        NSLog(@"_scrollViewOriginalInset.top =%lf",_scrollViewOriginalInset.top);
        NSLog(@"self.sk_h = %lf",self.sk_h);
        
        NSLog(@"self.frame =%@,self.bounds=%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds));
        //sectionheader停留解决
        CGFloat insetT = - self.scrollView.sk_offsetY >_scrollViewOriginalInset.top?-self.scrollView.sk_offsetY :_scrollViewOriginalInset.top;
        /*
         如果
         - self.scrollView.sk_offsetY 大于 _scrollViewOriginalInset.top
         就取-self.scrollView.sk_offsetY的值 小于或者等于就取 _scrollViewOriginalInset.top的值
         */
        
        insetT = insetT >self.sk_h + _scrollViewOriginalInset.top ?self.sk_h+_scrollViewOriginalInset.top:insetT;
        
        NSLog(@"insetT =%lf",insetT);
        self.scrollView.sk_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    //跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    //当期的contentOffset
    CGFloat offsetY = self.scrollView.sk_offsetY;
    NSLog(@"offsetY =%lf",offsetY);

    //头部控件刚好 出现的OffsetY
    CGFloat happenOffsetY = -self.scrollViewOriginalInset.top;
    
    NSLog(@"happenOffsetY =%lf",happenOffsetY);
    /*
     happenOffsetY 是一个固定的值
     */

    //如果是向上滚动到看不到头部控件直接返回
    if (offsetY > happenOffsetY) {
        return;
    }
    //普通和即将刷新的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY -self.sk_h;
    NSLog(@"normal2pullingOffsetY =%lf",normal2pullingOffsetY);
    CGFloat pullingPercent   = (happenOffsetY - offsetY)/self.sk_h;
    //FIXME:?????
    if (self.scrollView.isDragging) {//如果是正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == SKRefreshStateNormal && offsetY < normal2pullingOffsetY) {
            //转为即将刷新状态
            self.state = SKRefreshStatePulling;
        }
        else if(self.state == SKRefreshStatePulling && offsetY >= normal2pullingOffsetY )
        {
          //转为普通状态
            self.state  = SKRefreshStateNormal;
        }
    }
    else if (self.state ==SKRefreshStatePulling){//即将刷新 &&手松开
        //开始刷新
        [self beginRefreshing];
    }
    else if (pullingPercent <1 ){
        self.pullingPercent = pullingPercent;
    }
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    
    //根据状态做事情
    if (state == SKRefreshStateNormal) {
        
        if (oldState != SKRefreshStateRefreshing) {
            return;
        }
        //保存刷新时间
        NSLog(@"self.lastUpdatedTimeKey =%@",self.lastUpdatedTimeKey);
        [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //恢复inset和Offset
        [UIView animateWithDuration:SKRefreshSlowAnimationDuration animations:^{
            NSLog(@"self.insetTDelta =%lf",self.insetTDelta);
            self.scrollView.sk_insetT += self.insetTDelta;
            
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
    else if (state ==SKRefreshStateRefreshing){
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:SKRefreshFastAnimationDuration animations:^{
                //这是关键的一步，让scrollView下移动
                /*这里的ScrollView 就是SKExampleViewController里的tableView*/
                CGFloat top = self.scrollViewOriginalInset.top + self.sk_h;
                //增加滚动区域top
                self.scrollView.sk_insetT =top;
                NSLog(@"-top = %lf",top);
                //设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
                //frame没变，只是bounds在变
                NSLog(@"self.scrollView.frame= %@",NSStringFromCGRect(self.scrollView.frame));
                NSLog(@"self.scrollView.bounds= %@",NSStringFromCGRect(self.scrollView.bounds));
                
                NSLog(@"self.frame= %@",NSStringFromCGRect(self.frame));

                NSLog(@"self.bounds= %@",NSStringFromCGRect(self.bounds));


            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}
#pragma mark--公共方法
- (void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = SKRefreshStateNormal;
    });
}
- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:self.lastUpdatedTimeKey];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@ %@",self,NSStringFromSelector(_cmd));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
















































































































































































































































