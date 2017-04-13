//
//  SKRefreshBackStateFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshBackStateFooter.h"
@interface SKRefreshBackStateFooter()
{
    /*显示刷新状态的label*/
    __weak UILabel *_stateLabel;
}
/*所有状态对应的文字*/
@property (nonatomic,strong)NSMutableDictionary *stateTitles;
@end
@implementation SKRefreshBackStateFooter
#pragma mark---懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        
        _stateTitles =[NSMutableDictionary dictionary];
    }
    return _stateTitles;
}
- (UILabel*)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel sk_label]];
    }
    return _stateLabel;
}
#pragma mark---公共方法
- (void)setTitle:(NSString *)title forState:(SKRefreshState)state
{
    if (title==nil) {
        return;
    }
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}
- (NSString *)titleForState:(SKRefreshState)state
{
    return self.stateTitles[@(state)];
}

#pragma mark---重写父类的方法
- (void)prepare
{
    [super prepare];
    
    //初始化间距
    self.labelLeftInset = SKRefreshLabelLeftInset;
    
    //初始化文字
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshBackFooterNormalText] forState:SKRefreshStateNormal];
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshBackFooterPullingText] forState:SKRefreshStatePulling];
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshBackFooterRefreshingText] forState:SKRefreshStateRefreshing];

    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshBackFooterNoMoreDataText] forState:SKRefreshStateNoMoreData];


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
    
    //设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



















































