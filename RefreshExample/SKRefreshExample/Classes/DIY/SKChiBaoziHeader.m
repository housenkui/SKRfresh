//
//  SKChiBaoziHeader.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/9.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKChiBaoziHeader.h"

@implementation SKChiBaoziHeader
#pragma mark---重写方法
#pragma mark---基本设置
- (void)prepare
{
    [super prepare];
    
    //设置普通状态的动画图片
    NSMutableArray *normalImages = [NSMutableArray array];
    
    for (NSUInteger i = 1 ; i<=60; i++) {
        NSString *name = [NSString stringWithFormat:@"dropdown_anim__000%zd",i];
        UIImage *image = [UIImage imageNamed:name];
        [normalImages addObject:image];
    }
    [self setImages:normalImages forState:SKRefreshStateNormal];
    
    //设置即将刷新状态的动画图片 (一松开就会刷新的状态)
    NSMutableArray *refreshingImages  = [NSMutableArray array];
    for (NSUInteger i = 1 ; i<=3; i++) {
        //FIXME:之前这里多写了一个_
        NSString *name = [NSString stringWithFormat:@"dropdown_loading_0%zd",i];
        UIImage *image = [UIImage imageNamed:name];
        
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:SKRefreshStatePulling];
    
    //设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:SKRefreshStateRefreshing];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end






















































