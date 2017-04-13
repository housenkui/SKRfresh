//
//  SKTestViewController.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/10.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKTestViewController.h"

@interface SKTestViewController ()

@end

@implementation SKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试控制器";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view.
}

- (void)close
{
    if (self.presentingViewController)
    {
        
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

























































