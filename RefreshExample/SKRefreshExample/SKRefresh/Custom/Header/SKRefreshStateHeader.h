//
//  SKRefreshStateHeader.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshHeader.h"

@interface SKRefreshStateHeader : SKRefreshHeader
#pragma mark--刷新时间相关
/*利用这个Block 来决定显示的更新时间文字*/
@property (copy,nonatomic)NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);

/*显示上一次刷新时间的lable */
@property (weak,nonatomic,readonly)UILabel *lastUpdatedTimeLabel;

#pragma mark---状态相关
/*文字距离圈圈、箭头的距离*/
@property (assign,nonatomic)CGFloat labelLeftInset;
/*显示刷新状态的label*/
@property (weak,nonatomic,readonly)UILabel *stateLabel;
/*设置state状态下的文字*/
- (void)setTitle:(NSString *)title forState:(SKRefreshState )state;
@end

































