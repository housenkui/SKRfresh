//
//  SKExampleViewController.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/7.
//  Copyright © 2017年 小码哥. All rights reserved.
//

#import "SKExampleViewController.h"
#import "SKExample.h"
#import "UIViewController+SKExample.h"
#import "SKTableViewController.h"
#import "SKRefresh.h"

#import "SKCollectionViewController.h"
#import "SKWebViewController.h"

static NSString *const SKExample00 = @"UITableView +下拉刷新";
static NSString *const SKExample10 = @"UITableView +上拉刷新";
static NSString *const SKExample20 = @"UICollectionView";
static NSString *const SKExample30 = @"UIWebView";

@interface SKExampleViewController ()
@property (strong,nonatomic)NSArray *examples;
@end

@implementation SKExampleViewController
- (NSArray *)examples{
    if (!_examples) {
        SKExample *exam0 = [[SKExample alloc]init];
        exam0.header  = SKExample00;
        exam0.vcClass = [SKTableViewController class];
        
        exam0.titles = @[@"默认",@"动画图片",@"隐藏时间",@"隐藏状态和时间",@"自定义文字",@"自定义刷新控件"];
        exam0.methods = @[@"example01",@"example02",@"example03",@"example04",@"example05",@"example06"];
        
        SKExample *exam1 = [[SKExample alloc]init];
        exam1.header = SKExample10;
        exam1.vcClass=[SKTableViewController class];
        exam1.titles =@[@"默认",@"上拉动画",@"隐藏刷新状态的文字",@"全部加载完毕",@"禁止自动加载",@"自定义文字",@"加载后隐藏",@"自动回弹的上拉01",@"自动回弹的上拉02",@"自定义刷新控件(自动刷新)",@"自定义刷新控件(自动回弹)"];
        exam1.methods = @[@"example11",@"example12",@"example13",@"example14",@"example15",@"example16",@"example17",@"example18",@"example19",@"example20",@"example21"];
        
        SKExample *exam2 = [[SKExample alloc]init];
        exam2.header = SKExample20;
        exam2.vcClass = [SKCollectionViewController class];
        exam2.titles = @[@"上下拉刷新"];
        exam2.methods = @[@"example21"];
        
        SKExample *exam3 = [[SKExample alloc]init];
        exam3.header = SKExample30;
        exam3.vcClass = [SKWebViewController class];
        exam3.titles = @[@"下拉刷新"];
        exam3.methods = @[@"example31"];
        
        _examples     = @[exam0,exam1,exam2,exam3];

    }
    return _examples;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // http://www.zpluz.com/thread-3504-1-1.html
    //http://www.jianshu.com/p/47240fe7539b
   
    //下拉刷新
//    self.tableView.sk_header = [SKRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        //这里延迟2秒是为了模拟网络请求
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            //恢复inset和Offset
//            [self.tableView.sk_header endRefreshing];
//        });
//    }];
//    self.tableView.sk_header.automaticallyChangeAlpha = YES;
    NSLog(@"self.tableView =%@",self.tableView);
    /*
     51行代码 先执行等于号 右边的 返回一个SKRefreshNormalHeader类型的View
     这个View的frame = (0 0; 0 54)，通过Category（UIScrollView (SKRefresh)）里的方法setSk_header在把这个View添加到self.tableView上
    
    */
    
    self.tableView.sk_header =[SKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.sk_header.automaticallyChangeAlpha = YES;

    NSLog(@"self.tableView.sk_header=%@",self.tableView.sk_header);
    //frame = (0 -54; 375 54)
    
//    [self.tableView.sk_header beginRefreshing];
    
}
- (void)loadData{
    
    //这里延迟2秒是为了模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //恢复inset和Offset
        [self.tableView.sk_header endRefreshing];
    });

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    SKExample *exam = self.examples[section];
    return exam.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    SKExample *exam  = self.examples[indexPath.section];
    cell.textLabel.text = exam.titles[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",exam.vcClass,exam.methods[indexPath.row]];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SKExample *exam = self.examples[section];
    
    return exam.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKExample *exam = self.examples[indexPath.section];
    UIViewController *vc = [[exam.vcClass alloc]init];
    //动态创建类
    vc.title = exam.titles[indexPath.row];
    [vc setValue:exam.methods[indexPath.row] forKey:@"method"];
    //动态添加方法
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
