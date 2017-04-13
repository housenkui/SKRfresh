//
//  SKRefreshNormalHeader.h
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKRefreshStateHeader.h"

@interface SKRefreshNormalHeader : SKRefreshStateHeader
@property (weak,nonatomic,readonly)UIImageView *arrowView;
/*菊花的样式*/
@property (assign,nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end







































