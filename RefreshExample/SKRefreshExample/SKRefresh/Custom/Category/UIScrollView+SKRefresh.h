//
//  UIScrollView+SKRefresh.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKRefreshConst.h"
@class SKRefreshHeader,SKRefreshFooter;
@interface UIScrollView (SKRefresh)
/*下拉刷新控件*/
@property (nonatomic,strong)SKRefreshHeader *sk_header;
@property (nonatomic,strong)SKRefreshHeader *header SKRefreshDeprecated("使用sk_header");

/*上拉刷新控件*/
@property (strong,nonatomic)SKRefreshFooter *sk_footer;
@property (strong,nonatomic)SKRefreshFooter *footer SKRefreshDeprecated("使用sk_footer");
#pragma mark---other

- (NSInteger)sk_totalDataCount;
@property (copy,nonatomic) void (^sk_reloadDataBlock)(NSInteger totalDataCount);
@end


































































































































