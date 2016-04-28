//
//  ShoppingCartCell.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectCellBlock)(BOOL selected ,NSInteger selectCount ,NSIndexPath *cellIndexPath);

@class GoodsModelFrame;
@interface ShoppingCartCell : UITableViewCell

+ (ShoppingCartCell *)cellWithTableView:(UITableView *)tableView selectBlock:(selectCellBlock)selectBlock;

@property(nonatomic,strong)GoodsModelFrame *goodModelFrmae;
@property(nonatomic,strong)NSIndexPath *cellIndexPath;

@end
