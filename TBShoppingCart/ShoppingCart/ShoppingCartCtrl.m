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
    UIView *_bottomView;
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
    
    _shopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-44) style:UITableViewStyleGrouped];
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;
    _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _shopTableView.tableFooterView = [[UIView alloc]init];
    [_shopTableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:@"shopcell"];
    [self.view addSubview:_shopTableView];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-44-49, self.view.width, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"weixuanze"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"yixuanze"] forState:UIControlStateSelected];
    btn.x = 10;
    btn.size = CGSizeMake(20, 20);
    btn.y = _bottomView.height/2-20/2;
    [btn addTarget:self action:@selector(chooseAllShop:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:btn];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"全选";
    [label sizeToFit];
    label.x = CGRectGetMaxX(btn.frame)+5;
    label.y = _bottomView.height/2 - label.height/2;
    label.textColor = [UIColor blackColor];
    [_bottomView addSubview:label];
    
    UIButton *redBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width-80, 0, 80, _bottomView.height)];
    [redBtn setBackgroundColor:[UIColor redColor]];
    [redBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
    [redBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [redBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_bottomView addSubview:redBtn];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"合计:￥0.00";
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [priceLabel sizeToFit];
    priceLabel.size = CGSizeMake(priceLabel.size.width*2, priceLabel.size.height);
    priceLabel.x = CGRectGetMinX(redBtn.frame)-5-priceLabel.width;
    priceLabel.y = _bottomView.height/2-priceLabel.height-2;
    [_bottomView addSubview:priceLabel];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.text = @"不含运费和进口税";
    [tipLabel sizeToFit];
    tipLabel.x = CGRectGetMinX(redBtn.frame)-5-tipLabel.width;
    tipLabel.y = _bottomView.height/2+2;
    [_bottomView addSubview:tipLabel];
    
    [self.view addSubview:_bottomView];
}

- (void)chooseAllShop:(UIButton *)button{

    button.selected = !button.selected;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    return model.goodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShoppingCartCell *cell = [ShoppingCartCell cellWithTableView:tableView selectBlock:^(BOOL selected) {
        NSLog(@"点击cell---%zd",selected);
    }];
    ShoppingCartModel *model = self.dataArray[indexPath.section];
    GoodsModel *goodModel = model.goodslist[indexPath.row];
    GoodsModelFrame *goodModelFrmae = [[GoodsModelFrame alloc]init];
    goodModelFrmae.goodsModel = goodModel;
    cell.goodModelFrmae = goodModelFrmae;
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    ShoppingCartHeaderView *headerView = [ShoppingCartHeaderView creatHeaderViewWithFrame:CGRectMake(0, 0, self.view.width, 30) name:model.shopname selectBlock:^(BOOL selected) {
        NSLog(@"点击头选择--%zd",selected);
        for (GoodsModel *goodModel in model.goodslist) {
            goodModel.isSelectCell = selected;
        }
        model.isSelectHeader = selected;
        [_shopTableView reloadData];
    }];
    headerView.model = model;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

@end
