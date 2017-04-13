//
//  SKTableViewController.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/9.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKTableViewController.h"
#import "UIView+SKExtension.h"
#import "UIViewController+SKExample.h"
#import "SKRefresh.h"
#import "SKTestViewController.h"

#import "BSBacktraceLogger.h"

//自定义header
#import "SKChiBaoziHeader.h"
#import "SKDIYHeader.h"

//自定义footer
#import "SKChiBaoZiFooter.h"
#import "SKChiBaoZiFooter2.h"
#import "SKDIYAutoFooter.h"
#import "SKDIYBackFooter.h"



static const CGFloat SKDuration = 2.0;
/*
 随机数据
 */
#define SKRandomData [NSString stringWithFormat:@"随机数据---%d",arc4random_uniform(1000000)]
@interface SKTableViewController ()
/*用来显示的假数据*/
@property (strong,nonatomic)NSMutableArray *data;
@end

@implementation SKTableViewController
#pragma mark--演示的代码
#pragma mark---UITableView + 下拉刷新 默认

- (void)example01
{
    
    __weak __typeof(self) weakSelf = self;
    //设置回调 (一旦进入刷新状态就会调用这个refreshBlock)
    self.tableView.sk_header = [SKRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadNewData];
    }];
    //马上进入刷新状态
    [self.tableView.sk_header beginRefreshing];
    
    
}
#pragma mark---UITabeleView +下拉刷新 动画图片
- (void)example02
{
    //设置回调(一旦进入刷新状态，就调用target的action,也就是调用self的 loadNewData方法)
    self.tableView.sk_header = [SKChiBaoziHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //马上进入刷新状态
    [self.tableView.sk_header beginRefreshing];
}
#pragma mark---下拉刷新、隐藏时间
- (void)example03
{
    //设置回调
    SKRefreshNormalHeader *header =[SKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //设置自动切换透明度
    header.automaticallyChangeAlpha = YES;
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden  =YES;
    //立马进入刷新状态
    [header beginRefreshing];
    //设置header
    self.tableView.sk_header = header;
    //FIXME:我去，还可以这样写啊
}
#pragma mark---下拉刷新  隐藏状态和时间
- (void)example04
{
    SKChiBaoziHeader *header =[SKChiBaoziHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //隐藏状态
    header.stateLabel.hidden = YES;
    
    [header beginRefreshing];
    
    //设置header
    self.tableView.sk_header = header;
}
#pragma mark---下拉刷新 自定义文字

- (void)example05
{
    SKRefreshNormalHeader *header =[SKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //设置文字
    [header setTitle:@"Pull down to refresh" forState:SKRefreshStateNormal];
    [header setTitle:@"Release to refresh" forState:SKRefreshStatePulling];
    [header setTitle:@"Load ..." forState:SKRefreshStateRefreshing];
    
    //设置字体
    header.stateLabel.font =[UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    //设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor =[UIColor blueColor];
    
    //马上进入刷新状态
    [header beginRefreshing];
    
    //设置刷新控件
    self.tableView.sk_header = header;
}
#pragma mark----下拉刷新 自定义刷新控件
- (void)example06
{
    self.tableView.sk_header = [SKDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.sk_header beginRefreshing];
}
#pragma mark---上拉刷新 默认
- (void)example11
{
//    [self example01];
    __weak __typeof(self) weakSelf = self;
    
    //设置回调(一旦进入刷新状态就会调用这个refreshingBlock)
    self.tableView.sk_footer = [SKRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
#pragma mark----上拉刷新 动画图片
- (void)example12
{
    self.tableView.sk_footer  =[SKChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark-----隐藏刷新状态的文字
- (void)example13
{
    SKChiBaoZiFooter *footer = [SKChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    
    //设置footer
    self.tableView.sk_footer = footer;
}
#pragma mark----上拉刷新 全部加载完毕
- (void)example14
{
    self.tableView.sk_footer = [SKRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    //其他
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(reset)];
}
- (void)reset
{
    [self.tableView.sk_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.sk_footer resetNoMoreData];
}
#pragma mark----上拉刷新 禁止自动加载
- (void)example15
{
    SKRefreshAutoNormalFooter *footer  =[SKRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //禁止自动加载
    footer.automaticallyRefresh = NO;
    
    //设置footer
    self.tableView.sk_footer = footer;
}
#pragma mark---上拉刷新 自定义文字
- (void)example16
{
    SKRefreshAutoNormalFooter *footer = [SKRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //设置文字
    [footer setTitle:@"Click or drap up to refresh" forState:SKRefreshStateNormal];
    [footer setTitle:@"Loading more ..." forState:SKRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:SKRefreshStateNoMoreData];
    
    //设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    //设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    //设置footer
    self.tableView.sk_footer = footer;
}
#pragma mark---上拉刷新 加载后隐藏
- (void)example17
{
    self.tableView.sk_footer= [SKRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
}
#pragma mark---上拉刷新 自动回弹的上拉01
- (void)example18
{
    self.tableView.sk_footer = [SKRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    //忽略掉底部的inset
    self.tableView.sk_footer.ignoredScrollViewContentInsetBottom  =30;
}
#pragma mark ---自动回弹的上拉02
- (void)example19
{
    self.tableView.sk_footer = [SKChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    self.tableView.sk_footer.automaticallyChangeAlpha = YES;
}
#pragma mark---上拉刷新 自定义刷新控件(自动刷新)
- (void)example20
{
    self.tableView.sk_footer = [SKDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark-----上拉刷新 自定义刷新控件(自动回弹)
- (void)example21
{
    self.tableView.sk_footer = [SKDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark---数据处理相关
#pragma mark---下拉刷新数据
- (void)loadNewData
{
    //1.添加假的数据
    for (int i = 0 ; i<5; i++) {
        
        [self.data insertObject:SKRandomData atIndex:0];
        
    }
    //2.模拟2秒后刷新表格UI(真实开发中，可以移除这段GCD代码)
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [tableView reloadData];
        
        //拿到当前的下拉刷新控件，结束刷新状态
 
        [tableView.sk_header endRefreshing];
    });
    //FIXME: 之前这里额sk_footer 写成了sk_header,默默鄙视自己10分钟

}
#pragma mark---上拉加载更多数据
- (void)loadMoreData
{
    //1.添加假的数据
    for (int i = 0 ; i<5; i++) {
        
        [self.data addObject:SKRandomData];
    }
    //2.模拟2秒后刷新表格UI(真实环境，要去掉这段GCD代码)
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [tableView reloadData];
        
        //拿到当前得到上拉刷新状态  结束刷新状态
        [tableView.sk_footer endRefreshing];
    });
}
#pragma mark ----加载最后一份数据
- (void)loadLastData
{
    //1.添加假的数据
    for (int i = 0 ; i<5; i++) {
        
        [self.data addObject:SKRandomData];
    }
    //2.模拟2秒后刷新表格UI
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [tableView reloadData];
        
        //拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.sk_footer endRefreshingWithNoMoreData];
    });
}
#pragma mark----只加载一次数据
- (void)loadOnceData
{
    //1.添加假的数据
    for (int i = 0 ; i<5; i++) {
        
        [self.data addObject:SKRandomData];
    }
    //2.模拟2秒后刷新表格UI
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [tableView reloadData];
        
        //隐藏当前的上拉刷新控件
        tableView.sk_footer.hidden = YES;
    });
}
#pragma mark---之前在这里少写了一个！
- (NSMutableArray *)data{
    if (!_data) {
        _data =[NSMutableArray array];
        for (int i = 0 ; i < 5; i++) {
            
            [_data addObject:SKRandomData];
        }
    }
    NSLog(@"_data =%@",_data);
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor =[UIColor whiteColor];
    //FIXME:???what is it "separatorStyle" ?
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    SKPerformSelectorLeakWarning(
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
    );
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BSLOG_MAIN  // 打印主线程调用栈， BSLOG 打印当前线程，BSLOG_ALL 打印所有线程
        // 调用 [BSBacktraceLogger bs_backtraceOfCurrentThread] 这一系列的方法可以获取字符串，然后选择上传服务器或者其他处理。
    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *text = [NSString stringWithFormat:@"%@ - %@",indexPath.row%2?@"push":@"model",self.data[indexPath.row]];
    cell.textLabel.text = text;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKTestViewController *test  =[[SKTestViewController alloc]init];
    if (indexPath.row%2) {
        [self.navigationController pushViewController:test animated:YES];
    }
    else{
        UINavigationController *nav  =[[UINavigationController alloc]initWithRootViewController:test];
        
        [self presentViewController:nav animated:YES completion:^{}];
    }
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
