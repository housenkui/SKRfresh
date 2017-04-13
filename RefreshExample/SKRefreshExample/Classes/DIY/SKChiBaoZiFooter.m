//
//  SKChiBaoZiFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/10.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKChiBaoZiFooter.h"

@implementation SKChiBaoZiFooter
#pragma mark---重写方法
#pragma mark---基本设置

- (void)prepare
{
    [super prepare];
    
    //设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1 ; i<=3; i++) {
        NSString *name = [NSString stringWithFormat:@"dropdown_loading_0%zu",i];
        UIImage *image = [UIImage imageNamed:name];
        [refreshingImages addObject:image];
        
    }
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































