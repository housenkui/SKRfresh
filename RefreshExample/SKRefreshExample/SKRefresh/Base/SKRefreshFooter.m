//
//  SKRefreshFooter.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshFooter.h"
@interface SKRefreshFooter ()
@end
@implementation SKRefreshFooter
#pragma mark---构造方法
+ (instancetype)footerWithRefreshingBlock:(SKRefreshComponentRefeshingBlock)refreshingBlock
{
    SKRefreshFooter *cmp = [[self alloc]init];
    
    cmp.refreshingBlock = refreshingBlock;
    
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    SKRefreshFooter *cmp = [[self alloc]init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}
#pragma mark---重写父类的方法

- (void)prepare
{
    [super prepare];
    
    //设置自己的高度
    self.sk_h = SKRefreshFooterHeight;
    
    //默认不会自动隐藏
    self.automaticallyHidden = NO;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        //监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]]||[self.scrollView isKindOfClass:[UICollectionView class]]) {
            
            [self.scrollView setSk_reloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount==0);
                }
            }];
        }
    }
}
#pragma mark---公共方法
- (void)endRefreshingWithNoMoreData
{
    self.state = SKRefreshStateNoMoreData;
}

- (void)noticeNoMoreData
{
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    self.state = SKRefreshStateNormal;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end





































