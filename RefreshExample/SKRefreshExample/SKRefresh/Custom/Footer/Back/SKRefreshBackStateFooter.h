//
//  SKRefreshBackStateFooter.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshBackFooter.h"

@interface SKRefreshBackStateFooter : SKRefreshBackFooter
/*文字距离圈圈、箭头的距离*/
@property (assign,nonatomic)CGFloat labelLeftInset;
/*显示刷新状态的label*/
@property (weak,nonatomic,readonly)UILabel *stateLabel;
/*设置state状态下的文字*/
- (void)setTitle:(NSString *)title forState:(SKRefreshState) state;

/*获取state状态下的title*/
- (NSString *)titleForState:(SKRefreshState)state;
@end










































