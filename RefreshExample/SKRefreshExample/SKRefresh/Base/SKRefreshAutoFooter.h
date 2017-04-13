//
//  SKRefreshAutoFooter.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshFooter.h"

@interface SKRefreshAutoFooter : SKRefreshFooter
/*是否自动刷新（默认为YES）*/
@property (assign,nonatomic,getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/*当底部控件出现多少时，就自动刷新(默认为1.0),也就是底部控件完全出现时，才会自动刷新*/
@property (assign,nonatomic)CGFloat appearencePercentTriggerAutoRefresh SKRefreshDeprecated("请使用triggerAutomaticallyRefreshPercent");
/*当底部控件出现多少时就自动刷新(默认为1.0),也就是底部控件完全出现时，才会自动刷新*/
@property (assign,nonatomic)CGFloat triggerAutomaticallyRefreshPercent;
/*
 trigger 触发
 
 */
@end






































