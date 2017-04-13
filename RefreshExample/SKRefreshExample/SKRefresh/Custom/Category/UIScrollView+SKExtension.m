//
//  UIScrollView+SKExtension.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import "UIScrollView+SKExtension.h"
#import <objc/runtime.h>
@implementation UIScrollView (SKExtension)

#pragma mark---top
/*
 
 UIEdgeInsets  top 与父视图顶部相对距离
 */
- (void)setSk_insetT:(CGFloat)sk_insetT
{
    
    UIEdgeInsets inset = self.contentInset;
    inset.top  = sk_insetT;
    self.contentInset = inset;
}
- (CGFloat)sk_insetT{
    
    return self.contentInset.top;
}
#pragma mark---bottom
- (void)setSk_insetB:(CGFloat)sk_insetB
{
    
    UIEdgeInsets inset = self.contentInset;
    inset.bottom  = sk_insetB;
    self.contentInset = inset;
}
- (CGFloat)sk_insetB{
    
    return self.contentInset.bottom;
}
#pragma mark---left
- (void)setSk_insetL:(CGFloat)sk_insetL
{
    
    UIEdgeInsets inset = self.contentInset;
    inset.left  = sk_insetL;
    self.contentInset = inset;
}
- (CGFloat)sk_insetL{
    
    return self.contentInset.left;
}
#pragma mark---right
- (void)setSk_insetR:(CGFloat)sk_insetR
{
    
    UIEdgeInsets inset = self.contentInset;
    inset.right  = sk_insetR;
    self.contentInset = inset;
}
- (CGFloat)sk_insetR{
    
    return self.contentInset.right;
}

#pragma mark---偏移量X
- (void)setSk_offsetX:(CGFloat)sk_offsetX{
    CGPoint offset = self.contentOffset;
    offset.x = sk_offsetX;
    self.contentOffset = offset;
}
- (CGFloat)sk_offsetX{
    
    return self.contentOffset.x;
}
#pragma mark---偏移量Y
- (void)setSk_offsetY:(CGFloat)sk_offsetY{
    CGPoint offset = self.contentOffset;
    offset.y = sk_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)sk_offsetY{
    
    return self.contentOffset.y;
}

#pragma mark----contentSize 宽
- (void)setSk_contentW:(CGFloat)sk_contentW{
    CGSize size  = self.contentSize;
    size.width = sk_contentW;
    self.contentSize = size;
}

- (CGFloat)sk_contentW{
    
    return self.contentSize.width;
}

#pragma mark---contentSize 高
- (void)setSk_contentH:(CGFloat)sk_contentH{
    
    CGSize size = self.contentSize;
    
    size.height = sk_contentH;
    
    self.contentSize = size;
}
- (CGFloat)sk_contentH{
    
    return self.contentSize.height;
}














@end
