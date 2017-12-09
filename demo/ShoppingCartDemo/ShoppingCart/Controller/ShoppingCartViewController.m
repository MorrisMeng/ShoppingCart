//
//  ShoppingCartViewController.m
//  ShoppingCartDemo
//
//  Created by dry on 2017/12/3.
//  Copyright © 2017年 MorrisMeng. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartCell.h"
#import "ShoopingCartBottomView.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartSectionHeaderView.h"

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    
    [self setUpUI];
    
    [self initData];
}
- (void)setUpUI
{
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:[self setUpBottomView]];
}
//网络请求数据(这里使用本地模拟数据)
- (void)initData {
    [ShoppingCartModel requestDataWithSucess:^(NSArray<__kindof ShoppingCartGoods *> *result) {
        
        NSLog(@"result:%@",result);
        [self result:result];

    } failure:^{
        
    }];
}
- (void)result:(NSArray *)result {
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:result];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShoppingCart *shopCart = self.dataSource[section];
    return shopCart.goods.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellID = @"ShoppingCartViewController_cell";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ShoppingCart *shoppingCart = self.dataSource[indexPath.section];
    ShoppingCartGoods *goodsModel = shoppingCart.goods[indexPath.row];
    [cell setInfo:goodsModel];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
//设置自定义的sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifier = @"ShoppingCartViewController_cell_header";
    ShoppingCartSectionHeaderView *hearderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!hearderView) {
        hearderView = [[ShoppingCartSectionHeaderView alloc] initWithReuseIdentifier:identifier];
    }
    ShoppingCart *shopCart = self.dataSource[section];
    [hearderView setInfo:shopCart];
    
    return hearderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}
//设置自定义的sectionFooter,去除sectionFooter
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (ShoopingCartBottomView *)setUpBottomView {
    ShoopingCartBottomView *bottomView = [[ShoopingCartBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-44-kIPhoneXBottomHeight, kScreenWidth, 44)];
    return bottomView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-kIPhoneXBottomHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"dealloc");
}

@end
