//
//  SKRefreshStateHeader.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshStateHeader.h"
@interface SKRefreshStateHeader ()
{
    //显示上一次刷新时间的label
    __weak UILabel *_lastUpdatedTimeLabel;
    /**显示刷新状态的label*/
    __weak UILabel *_stateLabel;
    
}
//所有状态对应的文字
@property (strong,nonatomic)NSMutableDictionary *stateTitles;
@end
@implementation SKRefreshStateHeader

#pragma mark--懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        
        [self addSubview:_stateLabel = [UILabel sk_label]];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel
{
    if (!_lastUpdatedTimeLabel) {
        
        [self addSubview:_lastUpdatedTimeLabel = [UILabel sk_label]];
    }
    return _lastUpdatedTimeLabel;
}
#pragma mark--公共方法
- (void)setTitle:(NSString *)title forState:(SKRefreshState)state
{
    if (title ==nil) {
        return;
    }
//FIXME:??????
    NSLog(@"title = %@",title);
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
    
    NSLog(@"self.stateLabel.text = %@",self.stateLabel.text);
}
#pragma mark--日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API.
-(NSCalendar *)currentCalendar
{
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}
#pragma mark---key的处理
//TODO:之前这里Last 写出last导致刷新看不到时间
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    //如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) {
        return;
    }
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults]objectForKey:lastUpdatedTimeKey];
    NSLog(@"lastUpdatedTime =%@",lastUpdatedTime);
    //如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        NSLog(@"self.lastUpdatedTimeLabel.text  =%@",self.lastUpdatedTimeLabel.text);

    }
    if (lastUpdatedTime) {
        //1.获得年月日
        NSCalendar *calendar  =[self currentCalendar];
        NSUInteger unitFlags  =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|kCFCalendarUnitMinute;
        NSDateComponents *cmp1 =  [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 =  [calendar components:unitFlags fromDate:[NSDate date]];
        
        //2.格式化日期
        NSDateFormatter *formatter   = [[NSDateFormatter alloc]init];
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) {//今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        }
        else if ([cmp1 year] ==[cmp2 year])//今年
        {
            formatter.dateFormat = @"MM-dd HH:mm";
        }
        else{
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time  =[formatter stringFromDate:lastUpdatedTime];
        
        //3.显示日期
        self.lastUpdatedTimeLabel.text =[NSString stringWithFormat:@"%@%@%@",[NSBundle sk_localizedStringForKey:SKRefreshHeaderLastTimeText],isToday?[NSBundle sk_localizedStringForKey:SKRefreshHeaderDateTodayText]:@"",time];
    }
    else{
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",[NSBundle sk_localizedStringForKey:SKRefreshHeaderLastTimeText],[NSBundle sk_localizedStringForKey:SKRefreshHeaderNoneLastDateText]];
    }
}
#pragma mark---覆盖父类的方法
- (void)prepare
{
    [super prepare];
    //初始化间距
    self.labelLeftInset = SKRefreshLabelLeftInset;
    
    //初始化文字
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshHeaderNormalText] forState:SKRefreshStateNormal];
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshHeaderPullingText] forState:SKRefreshStatePulling];
    [self setTitle:[NSBundle sk_localizedStringForKey:SKRefreshHeaderRefreshingText] forState:SKRefreshStateRefreshing];
}
- (void)placeSubviews
{
    [super placeSubviews];
    if (self.stateLabel.hidden) {
        return;
    }
    
    //FIXME:?????
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count ==0;
    if (self.lastUpdatedTimeLabel.hidden) {
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.frame = self.bounds;   //状态
        }
    }else{
        CGFloat stateLabelH = self.sk_h*0.5;//状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.sk_x = 0;
            self.stateLabel.sk_y = 0;
            self.stateLabel.sk_w = self.sk_w;
            self.stateLabel.sk_h = stateLabelH;
        }
        //更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.sk_x = 0;
            self.lastUpdatedTimeLabel.sk_y = stateLabelH;
            self.lastUpdatedTimeLabel.sk_w = self.sk_w;
            self.lastUpdatedTimeLabel.sk_h = self.sk_h - self.lastUpdatedTimeLabel.sk_y;
        }
    }
}
- (void)setState:(SKRefreshState)state
{
    SKRefreshCheckState
    //设置状态文字
    self.stateLabel.text =self.stateTitles[@(state)];
    //重新设置key(重新显示时间)
  //FIXME:???????????
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end




























































