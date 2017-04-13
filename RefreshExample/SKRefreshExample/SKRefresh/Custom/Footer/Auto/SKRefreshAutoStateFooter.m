//
//  SKRefreshAutoStateFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshAutoStateFooter.h"
@interface SKRefreshAutoStateFooter ()
{
    /*显示刷新状态的label*/
    __weak UILabel *_stateLabel;
}
/*所有状态对应的文字*/
@property (strong,nonatomic)NSMutableDictionary *stateTitle;

@end
@implementation SKRefreshAutoStateFooter
#pragma mark---懒加载
- (NSMutableDictionary *)stateTitle
{
    if (!_stateTitle) {
        
        _stateTitle =[NSMutableDictionary dictionary];
    }
    return _stateTitle;
}
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel=[UILabel sk_label]];
        
    }
    NSLog(@"_stateLabel.frame  =%@",NSStringFromCGRect(_stateLabel.frame));
    NSLog(@"_stateLabel.bounds  =%@",NSStringFromCGRect(_stateLabel.bounds));

    return _stateLabel;
}
#pragma mark---公共方法
- (void)setTitle:(NSString *)title forState:(SKRefreshState)state
{
    if (title==nil) {
        return;
    }
    self.stateTitle[@(state)] = title;
    self.stateLabel.text = self.stateTitle[@(self.state)];
}
#pragma mark---私有方法
- (void)stateLabelClick
{
    if (self.state ==SKRefreshStateNormal) {
        [self beginRefreshing];
    }
}
#pragma mark---重写父类的方法
- (void)prepare
{
    [super prepare];
    
    //初始化间距
    self.labelLeftInset = SKRefreshLabelLeftInset;
    
    //初始化文字
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshAutoFooterNormalText] forState:SKRefreshStateNormal];
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshAutoFooterRefreshingText] forState:SKRefreshStateRefreshing];
    
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshAutoFooterNoMoreDataText] forState:SKRefreshStateNoMoreData];
    
    //监听label
    self.stateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stateLabelClick)];
    [self.stateLabel addGestureRecognizer:tap];
}
- (void)placeSubviews
{
    [super placeSubviews];
    if (self.stateLabel.constraints.count) {
        return;
    }
    //状态标签
    self.stateLabel.frame = self.bounds;
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    if (self.isRefreshingTitleHidden&&state == SKRefreshStateRefreshing) {
        self.stateLabel.text  =nil;
    }
    else
    {
        self.stateLabel.text = self.stateTitle[@(state)];
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





































































































































































































































































