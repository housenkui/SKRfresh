//
//  SKRefreshAutoGitFooter.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshAutoStateFooter.h"

@interface SKRefreshAutoGitFooter : SKRefreshAutoStateFooter
@property (weak,nonatomic,readonly)UIImageView *gifView;

/*设置state 状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(SKRefreshState)state;

- (void)setImages:(NSArray *)images forState:(SKRefreshState)state;
@end







































































