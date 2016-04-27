//
//  ShoppingCartCell.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsModelFrame;
@interface ShoppingCartCell : UITableViewCell

+ (ShoppingCartCell *)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)GoodsModelFrame *goodModelFrmae;

@end
