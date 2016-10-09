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
    UIButton *_chooseBtn;
    UILabel *_priceLabel;
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
    
     _chooseBtn = [[UIButton alloc]init];
    [_chooseBtn setImage:[UIImage imageNamed:@"weixuanze"] forState:UIControlStateNormal];
    [_chooseBtn setImage:[UIImage imageNamed:@"yixuanze"] forState:UIControlStateSelected];
    _chooseBtn.x = 10;
    _chooseBtn.size = CGSizeMake(20, 20);
    _chooseBtn.y = _bottomView.height/2-20/2;
    [_chooseBtn addTarget:self action:@selector(chooseAllShop:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_chooseBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"全选";
    [label sizeToFit];
    label.x = CGRectGetMaxX(_chooseBtn.frame)+5;
    label.y = _bottomView.height/2 - label.height/2;
    label.textColor = [UIColor blackColor];
    [_bottomView addSubview:label];
    
    UIButton *redBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bottomView.width-80, 0, 80, _bottomView.height)];
    [redBtn setBackgroundColor:[UIColor redColor]];
    [redBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
    [redBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [redBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_bottomView addSubview:redBtn];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.text = @"合计:￥0.00";
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceLabel sizeToFit];
    _priceLabel.size = CGSizeMake(_priceLabel.size.width*2, _priceLabel.size.height);
    _priceLabel.x = CGRectGetMinX(redBtn.frame)-5-_priceLabel.width;
    _priceLabel.y = _bottomView.height/2-_priceLabel.height-2;
    [_bottomView addSubview:_priceLabel];
    
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
    CGFloat price = 0;
    for (ShoppingCartModel *model in self.dataArray) {
        model.isSelectHeader = button.selected;
        for (GoodsModel *goodModel in model.goodslist) {
            goodModel.isSelectCell = button.selected;
            price += [goodModel.price floatValue];
        }
    }
    [_shopTableView reloadData];
    [self changePrice:button.selected?price:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    return model.goodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShoppingCartModel *model = self.dataArray[indexPath.section];
    GoodsModel *goodModel = model.goodslist[indexPath.row];
    GoodsModelFrame *goodModelFrmae = [[GoodsModelFrame alloc]init];
    goodModelFrmae.goodsModel = goodModel;
    
    ShoppingCartCell *cell = [ShoppingCartCell cellWithTableView:tableView selectBlock:^(BOOL selected,NSIndexPath *cellIndexPath) {
        
            [self selectCellWithSelect:selected cellIndexPath:cellIndexPath];
    }];
    
    cell.goodModelFrmae = goodModelFrmae;
    cell.cellIndexPath = indexPath;
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ShoppingCartModel *model = self.dataArray[section];
    ShoppingCartHeaderView *headerView = [ShoppingCartHeaderView creatHeaderViewWithFrame:CGRectMake(0, 0, self.view.width, 30) name:model.shopname selectBlock:^(BOOL selected) {
        
            [self selectHeaderViewWithSelect:selected model:model];
        
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

#pragma mark 点击cell的按钮
- (void)selectCellWithSelect:(BOOL)selected cellIndexPath:(NSIndexPath *)cellIndexPath{
    
    NSLog(@"点击cell自定义-section-%zd row-%zd",cellIndexPath.section,cellIndexPath.row);
    
    ShoppingCartModel *model = self.dataArray[cellIndexPath.section];
    GoodsModel *goodModel = model.goodslist[cellIndexPath.row];
    
    goodModel.isSelectCell = selected;//先将自身的点击状态改变
    
    NSInteger cellSelctCount = 0;
    for (GoodsModel *cellModel in model.goodslist) {
        if (!cellModel.isSelectCell) {
            cellSelctCount++;//点击之后统计所有未点击的cell总数 若为0则全部选中
        }
    }
    if (cellSelctCount == 0) {
        model.isSelectHeader = YES;
    }else{
        model.isSelectHeader = NO;
    }
    
    NSInteger headSelectCount = 0;
    for (ShoppingCartModel *shopModel in self.dataArray) {
        if (!shopModel.isSelectHeader) {
            headSelectCount++;//直接分析点击后剩余的未被选中的 如果是0个就说明所有都被选中
        }
    }
    if (headSelectCount == 0) {
        _chooseBtn.selected = YES;
    }else{
        _chooseBtn.selected = NO;
    }
    [_shopTableView reloadData];
}

#pragma mark 点击组头的按钮
- (void)selectHeaderViewWithSelect:(BOOL)selected model:(ShoppingCartModel *)model{
 
    NSLog(@"点击头选择--%zd",selected);
    
    model.isSelectHeader = selected;
    for (GoodsModel *goodModel in model.goodslist) {
        goodModel.isSelectCell = selected;//当前组头下所有的cell的点击状态和组头保持一致
    }
    
    if (selected) {
        NSInteger headSelectCount = 0;
        for (ShoppingCartModel *shopModel in self.dataArray) {
            if (!shopModel.isSelectHeader) {
                headSelectCount++;//直接分析点击后剩余的未被选中的 如果是0个就说明所有都被选中
            }
        }
        if (headSelectCount == 0) {
            _chooseBtn.selected = selected;
        }
    }else{
        _chooseBtn.selected = selected;
    }
    
    [_shopTableView reloadData];

}

- (void)changePrice:(CGFloat)price{
    
    _priceLabel.text = [NSString stringWithFormat:@"合计:￥%.2f",price];
}

@end
