//
//  UIViewController+SKExample.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import "UIViewController+SKExample.h"
#import <objc/runtime.h>
@implementation UIViewController (SKExample)
+ (void)load{
    
    Method originMethod  = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod     = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc_SK"));
    method_exchangeImplementations(originMethod, newMethod);
}
- (void)dealloc_SK{
    NSLog(@"销毁了 %@",self);
    [self dealloc_SK];
}
static char  MethodKey = '\0';

- (void)setMethod:(NSString *)method{
    
    objc_setAssociatedObject(self,&MethodKey,method,OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)method{
    
    return objc_getAssociatedObject(self, &MethodKey);
}
@end
