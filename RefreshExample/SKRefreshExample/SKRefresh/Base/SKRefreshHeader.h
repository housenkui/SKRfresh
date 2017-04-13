//
//  SKRefreshHeader.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshComponent.h"

@interface SKRefreshHeader : SKRefreshComponent
/*创建 header*/
+ (instancetype)headerWithRefreshingBlock:(SKRefreshComponentRefeshingBlock) refreshingBlock;
/* 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL )action;

/*这个key用了存储上一次下拉刷新成功的时间*/
@property (copy,nonatomic)NSString *lastUpdatedTimeKey;
/*上一次下拉刷新成功的时间*/
@property (strong,nonatomic,readonly)NSData *lastUpdatedTime;
/*忽略多少scrollView的contentInset 的top*/
@property (assign,nonatomic)CGFloat ignoredScrollViewContentInsetTop;
@end













































