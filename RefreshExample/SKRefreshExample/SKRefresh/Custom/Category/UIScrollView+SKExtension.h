//
//  UIScrollView+SKExtension.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SKExtension)
@property (assign,nonatomic)CGFloat sk_insetT;
@property (assign,nonatomic)CGFloat sk_insetB;
@property (assign,nonatomic)CGFloat sk_insetL;
@property (assign,nonatomic)CGFloat sk_insetR;

@property (assign,nonatomic)CGFloat sk_offsetX;
@property (assign,nonatomic)CGFloat sk_offsetY;

@property (assign,nonatomic)CGFloat sk_contentW;

@property (assign,nonatomic)CGFloat sk_contentH;



@end
