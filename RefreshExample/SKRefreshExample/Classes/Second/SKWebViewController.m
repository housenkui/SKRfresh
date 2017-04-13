//
//  SKWebViewController.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKWebViewController.h"
#import "UIViewController+SKExample.h"
#import "SKRefresh.h"
#define SKPerformSelectorLeakWarning(Stuff) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop")
@interface SKWebViewController ()<UIWebViewDelegate>
@property (strong,nonatomic)UIWebView *webView;
@end

@implementation SKWebViewController
- (UIWebView *)webView
{
    if (!_webView) {
        _webView  = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    return _webView;
}
#pragma mark---示例
- (void)example31
{
    __weak UIWebView *webView = self.webView;
    webView.delegate = self;
    __weak UIScrollView *scrollView = self.webView.scrollView;
    
    //添加下拉刷新控件
    scrollView.sk_header = [SKRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
}
#pragma mark---webViewDeleagte
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView.scrollView.sk_header endRefreshing];
    //也可以
//    [webView.scrollView.sk_header endRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    [self.view addSubview:[self button]];
    // Do any additional setup after loading the view.
    
    //加载页面
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/housenkui"]]];
    SKPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(self.method) withObject:nil];
            );
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)button{
    
    UIButton  *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, self.view.frame.size.height-200, 100, 40);
    
    //    btn.titleLabel.text  =@"按钮";
    
    [btn setTitle:@"返回上一页" forState:UIControlStateNormal];
    
    btn.backgroundColor =[UIColor redColor];
    
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
    
}
- (void)onClick:(UIButton *)btn{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end





































