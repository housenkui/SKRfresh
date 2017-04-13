//
//  SKDIYBackFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKDIYBackFooter.h"
@interface SKDIYBackFooter ()
@property (weak,nonatomic)UILabel *label;
@property (weak,nonatomic)UISwitch *s;
@property (weak,nonatomic)UIImageView *logo;
@property (weak,nonatomic)UIActivityIndicatorView *loading;

@end
@implementation SKDIYBackFooter
#pragma mark----重写方法
#pragma mark---在这里做一些初始化配置 (比如添加子控件)
- (void)prepare
{
    [super prepare];
    //设置控件的高度
    self.sk_h = 50;
    
    //添加Label
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    
    //打醋的开关
    UISwitch *s =[[UISwitch alloc]init];
    [self addSubview:s];
    self.s = s;
    
    //logo
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImageView *logo = [[UIImageView alloc]initWithImage:image];
    logo.contentMode  =UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    //loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}
#pragma mark---在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    
    self.logo.center = CGPointMake(self.sk_w *0.5, self.sk_h +self.logo.sk_h *0.5);
    
    self.loading.center = CGPointMake(self.sk_w -30, self.sk_h*0.5);
}
#pragma mark---监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}
#pragma mark--监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}
#pragma mark---监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange: change];
}
#pragma mark---监听控件的刷新状态
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    switch (state) {
        case SKRefreshStateNormal:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"赶紧上拉亚(开关是打醋的)";
            break;
        case SKRefreshStatePulling:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text  = @"赶紧放开我吧(开关是打醋的)";
            break;
        case SKRefreshStateRefreshing:
            [self.loading startAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中(开关是打醋的)";
            break;
        case SKRefreshStateNoMoreData:
            [self.loading stopAnimating];
            self.label.text = @"木有数据了(开关是打醋的)";
            [self.s setOn:NO animated:YES];
            break;
        default:
            break;
    }
}
#pragma mark---监听拖拽比例 (控件被拖出来的比例)
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    //1.0 0.5 0.0
    //0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent*0.5;
    CGFloat green = 0.5 - 0.5*pullingPercent;
    CGFloat blue = 0.5 *pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end










































