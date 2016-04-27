//
//  ShoppingCartModel.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "ShoppingCartModel.h"
#import "MJExtension.h"
#import "GoodsModel.h"

@implementation ShoppingCartModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"goodslist":[GoodsModel class]};
}

@end
