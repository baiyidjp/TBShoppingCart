//
//  ShoppingCartCell.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "UIView+XL.h"
#import "GoodsModel.h"
#import "GoodsModelFrame.h"

static NSString *reuseID = @"ShoppingCartCell";

@interface ShoppingCartCell ()

@property(nonatomic,copy)selectCellBlock selectBlock;

@end

@implementation ShoppingCartCell
{
    UIView *_backgroundView;//整个cell的背景的View
    UIImageView *_iconImageView;//商品图片
    UILabel *_nameLabel;//商品名字label
    UILabel *_descLabel;//商品属性的label
    UILabel *_priceLabel;//价格的label
    UILabel *_oripriceLabel;//价格的label
    UIView *_lineView;
    UILabel *_shopCountLabel;//个数
    UIButton *_selectButton;
    NSInteger _selectCount;
}
+ (ShoppingCartCell *)cellWithTableView:(UITableView *)tableView selectBlock:(selectCellBlock)selectBlock{
    
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID selectBlock:selectBlock];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier selectBlock:(selectCellBlock)selectBlock{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectBlock = selectBlock;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor grayColor];
    
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.backgroundColor = [UIColor redColor];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setFont:[UIFont systemFontOfSize:12]];
    [_nameLabel setNumberOfLines:0];
    
    _descLabel = [[UILabel alloc]init];
    [_descLabel setFont:[UIFont systemFontOfSize:11]];
    [_descLabel setNumberOfLines:0];
    
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel setFont:[UIFont systemFontOfSize:13]];
    
    _oripriceLabel = [[UILabel alloc]init];
    [_oripriceLabel setFont:[UIFont systemFontOfSize:11]];
    
    _lineView = [[UIView alloc]init];
    
    _shopCountLabel = [[UILabel alloc]init];
    [_shopCountLabel setFont:[UIFont systemFontOfSize:11]];
    
    _selectButton = [[UIButton alloc]init];
    [_selectButton setImage:[UIImage imageNamed:@"weixuanze"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"yixuanze"] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_oripriceLabel addSubview:_lineView];
    [_backgroundView addSubview:_iconImageView];
    [_backgroundView addSubview:_nameLabel];
    [_backgroundView addSubview:_priceLabel];
    [_backgroundView addSubview:_oripriceLabel];
    [_backgroundView addSubview:_descLabel];
    [_backgroundView addSubview:_shopCountLabel];
    [_backgroundView addSubview:_selectButton];
    [self.contentView addSubview:_backgroundView];
}

- (void)selectButton:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (button.selected) {
        _selectCount = 1;
    }else{
        _selectCount = -1;
    }
    if (self.selectBlock) {
        self.selectBlock(button.selected ,_selectCount,self.cellIndexPath);
    }
}

- (void)setGoodModelFrmae:(GoodsModelFrame *)goodModelFrmae{

    _goodModelFrmae = goodModelFrmae;
    
    _backgroundView.frame = goodModelFrmae.backgroundViewFrame;
    _backgroundView.backgroundColor = [UIColor colorWithRed:0.8891 green:0.8891 blue:0.8891 alpha:1.0];
    _iconImageView.frame = goodModelFrmae.shopIconFrame;
    
    _nameLabel.frame = goodModelFrmae.nameLabelFrame;
    _nameLabel.text = goodModelFrmae.goodsModel.name;
    
    _descLabel.frame = goodModelFrmae.descLabelFrame;
    _descLabel.text = goodModelFrmae.goodsModel.desc;
    _descLabel.textColor = [UIColor colorWithRed:0.4377 green:0.4377 blue:0.4377 alpha:1.0];
    
    _priceLabel.frame = goodModelFrmae.priceLabelFrame;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",goodModelFrmae.goodsModel.price];
    _priceLabel.textColor = [UIColor redColor];
    
    _oripriceLabel.frame = goodModelFrmae.originalPriceFrame;
    _oripriceLabel.text = [NSString stringWithFormat:@"￥%@",goodModelFrmae.goodsModel.originalprice];
    _oripriceLabel.textColor = [UIColor colorWithRed:0.4377 green:0.4377 blue:0.4377 alpha:1.0];
    
    _lineView.frame = goodModelFrmae.lineViewFrame;
    _lineView.backgroundColor =[UIColor colorWithRed:0.4377 green:0.4377 blue:0.4377 alpha:1.0];

    _shopCountLabel.frame = goodModelFrmae.shopCountLabelFrame;
    _shopCountLabel.text = [NSString stringWithFormat:@"x%@",goodModelFrmae.goodsModel.shopcount];
    
    _selectButton.frame = goodModelFrmae.selectBtnFrame;
    _selectButton.selected = goodModelFrmae.goodsModel.isSelectCell;
    
}








@end
