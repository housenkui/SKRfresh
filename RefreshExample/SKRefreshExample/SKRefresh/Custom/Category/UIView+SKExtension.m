//
//  UIView+SKExtension.m
//  SKProject01
//
//  Created by Code_Hou on 2017/4/6.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "UIView+SKExtension.h"

@implementation UIView (SKExtension)
- (void)setSk_x:(CGFloat)sk_x
{
    CGRect frame = self.frame;
    frame.origin.x = sk_x;
    self.frame = frame;
}
- (CGFloat)sk_x
{
    return self.frame.origin.x;
}
- (void)setSk_y:(CGFloat)sk_y
{
    
    CGRect frame = self.frame;
    frame.origin.y = sk_y;
    self.frame = frame;
}
- (CGFloat)sk_y
{
    return self.frame.origin.y;
}
- (void)setSk_w:(CGFloat)sk_w
{
    
    CGRect frame = self.frame;
    frame.size.width = sk_w;
    self.frame = frame;
}
- (CGFloat)sk_w
{
    return self.frame.size.width;
}
- (void)setSk_h:(CGFloat)sk_h
{
    
    CGRect frame = self.frame;
    frame.size.height = sk_h;
    self.frame = frame;
}
- (CGFloat)sk_h
{
    return self.frame.size.height;
}
- (void)setSk_size:(CGSize)sk_size
{
    CGRect frame = self.frame;
    frame.size   =sk_size;
    self.frame    = frame;
}
- (CGSize)sk_size{
    
    return self.frame.size;
}
- (void)setSk_origin:(CGPoint)sk_origin{
    CGRect frame = self.frame;
    frame.origin = sk_origin;
    self.frame =  frame;
}
- (CGPoint)sk_origin{
    
    return self.frame.origin;
}

#pragma mark---对bounds进行修改
- (void)setSk_bounds_x:(CGFloat)sk_x
{
    CGRect bounds = self.bounds;
    bounds.origin.x = sk_x;
    self.bounds = bounds;
}
- (CGFloat)sk_bounds_x
{
    return self.bounds.origin.x;
}
- (void)setSk_bounds_y:(CGFloat)sk_y
{
    
    CGRect bounds = self.bounds;
    bounds.origin.y = sk_y;
    self.bounds = bounds;
}
- (CGFloat)sk_bounds_y
{
    return self.bounds.origin.y;
}
- (void)setSk_bounds_w:(CGFloat)sk_w
{
    
    CGRect bounds = self.bounds;
    bounds.size.width = sk_w;
    self.bounds = bounds;
}
- (CGFloat)sk_bounds_w
{
    return self.bounds.size.width;
}
- (void)setSk_bounds_h:(CGFloat)sk_h
{
    
    CGRect bounds = self.bounds;
    bounds.size.height = sk_h;
    self.bounds = bounds;
}
- (CGFloat)sk_bounds_h
{
    return self.bounds.size.height;
}
- (void)setSk_bounds_size:(CGSize)sk_size
{
    CGRect bounds = self.bounds;
    bounds.size   =sk_size;
    self.bounds    = bounds;
}
- (CGSize)sk_bounds_size{
    
    return self.bounds.size;
}
- (void)setSk_bounds_origin:(CGPoint)sk_origin{
    CGRect bounds = self.bounds;
    bounds.origin = sk_origin;
    self.bounds =  bounds;
}
- (CGPoint)sk_bounds_origin{
    
    return self.bounds.origin;
}

@end
