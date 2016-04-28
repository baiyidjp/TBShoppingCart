//
//  ShoppingCartHeaderView.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ShoppingCartHeaderView.h"
#import "UIView+XL.h"
#import "ShoppingCartModel.h"

@interface ShoppingCartHeaderView ()

@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,copy)selectBlock selectBlock;
@property(nonatomic,strong)NSString *name;

@end

@implementation ShoppingCartHeaderView
{
    NSInteger _selectCount;
}

+ (instancetype)creatHeaderViewWithFrame:(CGRect)frame name:(NSString *)name selectBlock:(selectBlock)selectBlock{

    return [[ShoppingCartHeaderView alloc]initWithFrame:frame name:name selectBlock:selectBlock];
}

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name selectBlock:(selectBlock)selectBlock{

    self = [super init];
    
    if (self) {
        self.frame = frame;
        self.name = name;
        self.selectBlock = selectBlock;
        self.backgroundColor = [UIColor whiteColor];
        [self configViews];
    }
    return self;
}

- (void)configViews{

    self.selectButton = [[UIButton alloc]init];
    self.selectButton.x = 10;
    self.selectButton.size = CGSizeMake(20, 20);
    self.selectButton.y = self.height/2-self.selectButton.height/2;
    
    [self.selectButton setImage:[UIImage imageNamed:@"weixuanze"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"yixuanze"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.selectButton];
    
    self.nameLable = [[UILabel alloc]init];
    self.nameLable.x = CGRectGetMaxX(self.selectButton.frame)+10;
    self.nameLable.text = self.name;
    [self.nameLable sizeToFit];
    self.nameLable.y = self.height/2-self.nameLable.height/2;
    self.nameLable.font = [UIFont systemFontOfSize:15];
    self.nameLable.textColor = [UIColor purpleColor];
    
    [self addSubview:self.nameLable];
    
}

- (void)selectButton:(UIButton *)button{

    button.selected = !button.selected;
    if (button.selected) {
        _selectCount = 1;
    }else{
        _selectCount = -1;
    }
    if (self.selectBlock) {
        self.selectBlock(button.selected,_selectCount);
    }
}

- (void)setModel:(ShoppingCartModel *)model{

    _model = model;
    
    self.selectButton.selected = model.isSelectHeader;
}


@end
