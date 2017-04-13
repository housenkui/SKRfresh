//
//  SKRefreshBackGifFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshBackGifFooter.h"
@interface SKRefreshBackGifFooter()
{
    __weak UIImageView *_gifView;
}
/*所有状态对应的动画图片*/
@property (strong,nonatomic)NSMutableDictionary *stateImages;
/*所有状态对应的动画时间*/
@property (strong,nonatomic)NSMutableDictionary *stateDuration;
@end
@implementation SKRefreshBackGifFooter
#pragma mark---懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc]init];
        [self addSubview:_gifView= gifView];
    }
    return _gifView;
}
- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        _stateImages =[NSMutableDictionary dictionary];
    }
    return _stateImages;
}
- (NSMutableDictionary *)stateDuration
{
    if (!_stateDuration) {
        _stateDuration =[NSMutableDictionary dictionary];
    }
    return _stateDuration;
}
#pragma mark---公共方法
- (void)setImages:(NSArray<UIImage *> *)images duration:(NSTimeInterval)duration forState:(SKRefreshState)state
{
    if (images ==nil) {
        return;
    }
    self.stateImages[@(state)] = images;
    self.stateDuration[@(state)] = @(duration);
    
    
    /*根据图片设置控件的高度*/
    UIImage *image = [images firstObject];
    if (image.size.height >self.sk_h) {
        
        self.sk_h = image.size.height;
    }
}
- (void)setImages:(NSArray<UIImage *> *)images forState:(SKRefreshState)state
{
    [self setImages:images duration:images.count*0.1 forState:state];
}
#pragma mark---实现父类的方法
- (void)prepare
{
    [super prepare];
    
    //初始化间距
    self.labelLeftInset = 20;
}
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    NSArray <UIImage *>*images =self.stateImages[@(SKRefreshStateNormal)];
    if (self.state!=SKRefreshStateNormal||images.count==0) {
        return;
    }
    [self.gifView stopAnimating];
    NSUInteger index = images.count *pullingPercent;
    if (index >= images.count) {
        index = images.count-1;
    }
    self.gifView.image = images[index];
}
-(void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) {
        return;
    }
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    }
    else
    {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.sk_w = self.sk_w *0.5 -self.labelLeftInset - self.stateLabel.sk_textWidth *0.5;
    }
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    //根据状态做事情
    if (state ==SKRefreshStatePulling||state==SKRefreshStateRefreshing) {
        NSArray *images =self.stateImages[@(state)];
        if (images.count==0) {
            return;
        }
        self.gifView.hidden  =NO;
        [self.gifView stopAnimating];
        if (images.count==1) {//单张图片
            self.gifView.image =[images lastObject];
        }else{//多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDuration[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    }
    else if (state==SKRefreshStateNormal)
    {
        self.gifView.hidden =NO;
    }
    else if (state ==SKRefreshStateNoMoreData)
    {
        self.gifView.hidden = YES;
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



















































