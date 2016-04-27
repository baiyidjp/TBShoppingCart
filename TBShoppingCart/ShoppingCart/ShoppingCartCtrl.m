//
//  ShoppingCartCtrl.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ShoppingCartCtrl.h"
#import "MJExtension.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartHeaderView.h"
#import "ShoppingCartCell.h"
#import "GoodsModel.h"
#import "UIView+XL.h"
#import "GoodsModelFrame.h"

@interface ShoppingCartCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArrayF;

@end

@implementation ShoppingCartCtrl
{
    UITableView *_shopTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = [NSString stringWithFormat:@"购物车(%zd)",self.dataArray.count];
    
    [self configView];
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shoppingList" ofType:@"plist"]];
        _dataArray = [ShoppingCartModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"shoppinglist"]];
    }
    return _dataArray;
}

- (void)configView{
    
    _shopTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;
    _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _shopTableView.tableFooterView = [[UIView alloc]init];
    [_shopTableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:@"shopcell"];
    [self.view addSubview:_shopTableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    return model.goodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShoppingCartCell *cell = [ShoppingCartCell cellWithTableView:tableView];
    ShoppingCartModel *model = self.dataArray[indexPath.section];
    GoodsModel *goodModel = model.goodslist[indexPath.row];
    GoodsModelFrame *goodModelFrmae = [[GoodsModelFrame alloc]init];
    goodModelFrmae.goodsModel = goodModel;
    cell.goodModelFrmae = goodModelFrmae;
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    ShoppingCartHeaderView *headerView = [ShoppingCartHeaderView creatHeaderViewWithFrame:CGRectMake(0, 0, self.view.width, 30) name:model.shopname selectBlock:^{
        
    }];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

@end
