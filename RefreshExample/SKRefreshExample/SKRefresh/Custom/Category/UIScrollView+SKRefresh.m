//
//  UIScrollView+SKRefresh.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "UIScrollView+SKRefresh.h"
#import "SKRefreshHeader.h"
#import "SKRefreshFooter.h"
#import <objc/runtime.h>
@implementation NSObject (SKRefresh)
+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}
@end
@implementation UIScrollView (SKRefresh)
#pragma mark--header
static const char SKRefreshHeaderKey = '\0';
- (void)setSk_header:(SKRefreshHeader *)sk_header
{
    NSLog(@"sk_header = %@",sk_header);
    //frame = (0 0; 0 54)
    NSLog(@"self.sk_header = %p",self.sk_header);

//FIXME:？？？？？
/*
 
 在UIScrollView上面添加 SKRefreshHeader
 */
    if (sk_header!=self.sk_header) {
        //删除旧的，添加新的
        [self.sk_header removeFromSuperview];
        
        /* insertSubview方法会调用SKRefreshComponent里面的willMoveToSuperview，方法
         
         设置sk_header的宽度
         
         
         */
        [self insertSubview:sk_header atIndex:0];
        /*这里的self 指的是SKExampleViewController里面的tableView
         在tableView上添加一个view(sk_header)
         另外一点比较神奇的地方，tableView又作为sk_header的成员属性
         将自己添加在自己的成员属性上面，第一次见，难道这就是SKRefreshComponentscrollView设置成weak的原因？？
         */
        NSLog(@" self =%@",self);
        NSLog(@"sk_header = %@",sk_header);


        
        //存储新的
        [self willChangeValueForKey:@"sk_header"];//KVO
        //http://blog.csdn.net/kesalin/article/details/8194240#reply
        objc_setAssociatedObject(self, &SKRefreshHeaderKey, sk_header, OBJC_ASSOCIATION_ASSIGN);

        [self didChangeValueForKey:@"sk_header"];
        
        /*
         手动实现键值观察 因为在setter方法里面，只能这样做吗？
         */
        /*这里会调用layoutSubviews方法*/
    }
}

- (SKRefreshHeader *)sk_header
{
    return objc_getAssociatedObject(self, &SKRefreshHeaderKey);
}
#pragma mark--过期header
- (void)setHeader:(SKRefreshHeader *)header
{
    self.sk_header = header;
}
- (SKRefreshHeader *)header
{
    return self.sk_header;
}
#pragma mark---footer
static const char SKRefreshFooterKey = '\0';
- (void)setSk_footer:(SKRefreshFooter *)sk_footer
{
    if (sk_footer != self.sk_footer) {
        //删除旧的，添加新的
        [self.sk_footer removeFromSuperview];
        [self insertSubview:sk_footer atIndex:0];
        
        //存储新的
        [self willChangeValueForKey:@"sk_footer"];//KVO
        objc_setAssociatedObject(self, &SKRefreshFooterKey, sk_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"sk_footer"];//KVO
    }
}
- (SKRefreshFooter *)sk_footer
{
    return objc_getAssociatedObject(self, &SKRefreshFooterKey);
}
#pragma mark---过期footer
- (void)setFooter:(SKRefreshFooter *)footer
{
    self.sk_footer = footer;
}
- (SKRefreshFooter *)footer
{
    return self.sk_footer;
}
#pragma mark---other

- (NSInteger)sk_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for(NSInteger section = 0;section < tableView.numberOfSections;section++){
            
            totalCount +=[tableView numberOfRowsInSection:section];
        }
    }
    else if ([self isKindOfClass:[UICollectionView class]])
    {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for(NSInteger section = 0;section <collectionView.numberOfSections;section++ ){
            totalCount+= [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}
static const char SKRefreshReloadDataBlockKey ='\0';
- (void)setSk_reloadDataBlock:(void (^)(NSInteger))sk_reloadDataBlock
{
    [self willChangeValueForKey:@"sk_reloadDataBlock"];//KVO
    objc_setAssociatedObject(self, &SKRefreshReloadDataBlockKey, sk_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"sk_reloadDataBlock"];//KVO
}
- (void (^)(NSInteger))sk_reloadDataBlock
{
    return objc_getAssociatedObject(self, &SKRefreshReloadDataBlockKey);
}
//FIXME:????????
- (void)executeReloadDataBlock
{
    !self.sk_reloadDataBlock? : self.sk_reloadDataBlock(self.sk_totalDataCount);
}
@end

@implementation UITableView (SKRefresh)

+(void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(sk_reloadData)];
}
- (void)sk_reloadData
{
    [self sk_reloadData];
    [self executeReloadDataBlock];
    //FIXME:这个方法是干什么用的？？
    
}
@end
@implementation UICollectionView (SKRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(sk_reloadData)];
}
- (void)sk_reloadData
{
    [self sk_reloadData];
    [self executeReloadDataBlock];
}
@end




