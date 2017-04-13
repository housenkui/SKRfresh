//
//  SKCollectionViewController.m
//  MJRefreshExample
//
//  Created by Code_Hou on 2017/4/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKCollectionViewController.h"
#import "SKTestViewController.h"
#import "UIViewController+SKExample.h"
#import "SKRefresh.h"
static const CGFloat SKDuration = 2.0;
/*
 随机色
 */
#define SKRandomColor    [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface SKCollectionViewController ()
/*存放假的数据*/
@property (strong,nonatomic)NSMutableArray *colors;
@end

@implementation SKCollectionViewController
#pragma mark---示例
#pragma mark --UICollectionView 上下拉刷新
- (void)example21
{
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    self.collectionView.sk_header = [SKRefreshNormalHeader headerWithRefreshingBlock:^{
        //增加5条假的数据
        for (int i = 0 ; i<10; i++) {
            
            [weakSelf.colors insertObject:SKRandomColor atIndex:0];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            //结束刷新
            [weakSelf.collectionView.sk_header endRefreshing];
        });
    }];
    [self.collectionView.sk_header beginRefreshing];
    
    
    //上拉刷新
    self.collectionView.sk_footer = [SKRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //添加5条假的数据
        for (int i = 0 ; i<5; i++) {
            
            [weakSelf.colors addObject:SKRandomColor];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SKDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            //结束刷新
            [weakSelf.collectionView.sk_footer endRefreshing];
        });
    }];
    
    //默认先隐藏footer
    self.collectionView.sk_footer.hidden = YES;
}
#pragma mark ---数据相关
- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors  =[NSMutableArray array];
    }
    return _colors;
}
#pragma mark---其他
/*
 初始化
 */
- (id)init{
    //UICollectionViewFlowLayout的初始化(与刷新控件无关)
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(80, 80);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing =20;
    layout.minimumLineSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
}
static NSString * const SKCollectionViewCellIdentifier = @"color";

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    SKPerformSelectorLeakWarning(
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
    );
    self.collectionView.backgroundColor =[UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SKCollectionViewCellIdentifier];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //设置尾部控件的显示和隐藏
    self.collectionView.sk_footer.hidden = self.colors.count==0;
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SKCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = self.colors[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKTestViewController *test = [[SKTestViewController alloc]init];
    if (indexPath.row%2) {
        [self.navigationController pushViewController:test animated:YES];
    }
    else
    {
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:^{}];
    }
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
































