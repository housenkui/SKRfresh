//
//  NSBundle+SKRefresh.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import "NSBundle+SKRefresh.h"
#import "SKRefreshComponent.h"
@implementation NSBundle (SKRefresh)
+ (instancetype)sk_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle ==nil) {
        //这里不使用mainBundle是为了适配pod 1.0和0.x
        //FIXME:这里的资源是直接拿过来用的
        NSString *path  = [[NSBundle bundleForClass:[SKRefreshComponent class]]pathForResource:@"SKRefresh" ofType:@"bundle"];
        refreshBundle = [NSBundle bundleWithPath:path];
    }
    
    return refreshBundle;
}
+ (UIImage *)sk_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage ==nil) {
        NSString *path = [[self  sk_refreshBundle]pathForResource:@"arrow@2x" ofType:@"png"];
        
        arrowImage  =[[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        //Rendering 透视图
    }
    
    return arrowImage;
}
+ (NSString *)sk_localizedStringForKey:(NSString *)key
{
    return [self sk_localizedStringForKey:key value:nil];
}
+(NSString *)sk_localizedStringForKey:(NSString *)key value:(NSString *)value
{
//    NSLog(@"国际化");

    static NSBundle *bundle =nil;
    if (bundle ==nil) {
        //iOS获取的语言字符串比较不稳定 目前框架只处理en,zh-Hans、zh-Hant 三种情况、其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        }
        else if ([language hasPrefix:@"zh"])
        {
            if ([language rangeOfString:@"Hans"].location!=NSNotFound) {
                
                language = @"zh-Hans";//简体中文
            }
            else{
                language = @"zh-Hant";//繁体中文
            }
        }
        else{
            language  =@"en";
        }
        
        NSString *path = [[self  sk_refreshBundle]pathForResource:language ofType:@"lproj"];

        bundle = [NSBundle bundleWithPath:path];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    
    NSString *string = [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
//    NSLog(@"string  =%@",string);
    return string;
}
@end











































