//
//  ViewController.m
//  WaterFall
//
//  Created by RSTaylor on 17/2/18.
//  Copyright © 2017年 RSTaylor. All rights reserved.
//

#import "ViewController.h"
#import "RSmodel.h"
#import "RSShopCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "RSWaterFallLayout.h"

// collectionViewCell的重用标识符
static NSString * const shopCellReuseID = @"shop";

@interface ViewController () <UICollectionViewDataSource, RSWaterFallLayoutDelegate,UICollectionViewDelegate>

/** 瀑布流view */
@property (nonatomic, weak) UICollectionView *collectionView;

/** shops */
@property (nonatomic, strong) NSMutableArray *shops;

/** 当前页码 */
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置当前页码为0
    self.currentPage = 0;
    
    // 初始化瀑布流view
    [self setupCollectionView];
    
}

- (void)setupCollectionView
{
    // 创建瀑布流layout
    RSWaterFallLayout *layout = [[RSWaterFallLayout alloc] init];
    // 设置代理
    layout.delegate = self;
    
    // 创建瀑布流view
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    // 设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RSShopCell class]) bundle:nil] forCellWithReuseIdentifier:shopCellReuseID];
    
    // 为瀑布流控件添加下拉加载和上拉加载
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求延迟
            
            // 清空数据
            [self.shops removeAllObjects];
            
            [self.shops addObjectsFromArray:[self newShops]];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            // 停止刷新
            [self.collectionView.mj_header endRefreshing];
        });
    }];
    // 第一次进入则自动加载
    [self.collectionView.mj_header beginRefreshing];
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求延迟
            
            [self.shops addObjectsFromArray:[self moreShopsWithCurrentPage:self.currentPage]];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            // 停止刷新
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - 内部方法
- (NSArray *)newShops
{
    return [RSmodel mj_objectArrayWithFilename:@"0.plist"];
}

- (NSArray *)moreShopsWithCurrentPage:(NSUInteger)currentPage
{
    // 页码的判断
    if (currentPage == 3) {
        self.currentPage = 0;
    } else {
        self.currentPage++;
    }
    
    NSString *nextPage = [NSString stringWithFormat:@"%lu.plist", (unsigned long)self.currentPage];
    
    return [RSmodel mj_objectArrayWithFilename:nextPage];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    RSShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCellReuseID forIndexPath:indexPath];
    
    // 给cell传递模型
    cell.model= self.shops[indexPath.item];
    [cell setDidSelectedBlock:^(RSmodel *model) {
        NSLog(@"是否选中%hhd,%d",model.isSelect,indexPath.item);
    }];
    
    // 返回cell
    return cell;
}

#pragma mark - <JRWaterFallLayoutDelegate>
/**
 *  返回每个item的高度
 */
- (CGFloat)waterFallLayout:(RSWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
{
    RSmodel *shop = self.shops[index];
    CGFloat shopHeight = [shop.h doubleValue];
    CGFloat shopWidth = [shop.w doubleValue];
    return shopHeight * width / shopWidth;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
