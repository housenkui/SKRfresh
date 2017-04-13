//
//  SKChiBaoZiFooter2.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKChiBaoZiFooter2.h"

@implementation SKChiBaoZiFooter2
#pragma mark--- 重写方法
#pragma mark--- 基本设置
- (void)prepare
{
    [super prepare];
    
    //设置普通状态的动画图片
    NSMutableArray *normalImages = [NSMutableArray array];
    for (NSUInteger i = 1 ; i <= 60; i++) {
        
        NSString *name = [NSString stringWithFormat:@"dropdown_anim__000%zd",i];
        UIImage *image = [UIImage imageNamed:name];
        [normalImages addObject:image];
    }
    [self setImages:normalImages forState:SKRefreshStateNormal];
    
    //设置即将刷新状态的动画图片 (一松开就会刷新得到状态)
    NSMutableArray *refreshImages =[NSMutableArray array];
    for (NSUInteger i = 1 ; i<=3; i++) {
        
        NSString *name = [NSString stringWithFormat:@"dropdown_loading_0%zd",i];
        UIImage *image = [UIImage imageNamed:name];
        [refreshImages addObject:image];
    }
    [self setImages:refreshImages forState:SKRefreshStatePulling];
    
    //设置正在刷新状态的动画图片
    [self setImages:refreshImages forState:SKRefreshStateRefreshing];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
































