//
//  SKDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKDIYAutoFooter.h"
@interface SKDIYAutoFooter ()
@property (weak,nonatomic)UILabel *label;
@property (weak,nonatomic)UISwitch *s;
@property (weak,nonatomic)UIActivityIndicatorView *loading;
@end
@implementation SKDIYAutoFooter
#pragma mark---重写方法
#pragma mark--在这里做一些初始化配置(比如添加子控件)
- (void)prepare
{
    [super prepare];
    
    //设置控件的高度
    self.sk_h = 50;
    
    //添加label
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font    = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //打醋的开关
    UISwitch *s = [[UISwitch alloc]init];
    [self addSubview:s];
    self.s = s;
    
    //loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}
#pragma mark--在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    self.s.center = CGPointMake(self.sk_w -20, self.sk_h-20);
    
    self.loading.center = CGPointMake(30, self.sk_h *0.5);
}
#pragma mark----监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}
#pragma mark---监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}
#pragma mark---监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}
#pragma mark---监听控件的刷新状态
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    switch (state) {
        case SKRefreshStateNormal:
            self.label.text = @"赶紧上拉亚(开关是打醋的)";
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            break;
        case SKRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中(开关是打醋的)";
            [self.loading startAnimating];
            break;
        case SKRefreshStateNoMoreData:
            self.label.text = @"木有数据了(开关是打醋的)";
            [self.s setOn:NO animated:YES];
            [self.loading stopAnimating];
            break;
        default:
            break;
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
















































