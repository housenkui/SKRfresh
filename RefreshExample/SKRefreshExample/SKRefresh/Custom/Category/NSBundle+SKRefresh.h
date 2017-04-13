//
//  NSBundle+SKRefresh.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSBundle (SKRefresh)
+ (instancetype)sk_refreshBundle;
+ (UIImage *)sk_arrowImage;
+ (NSString *)sk_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)sk_localizedStringForKey:(NSString *)key;
@end



































