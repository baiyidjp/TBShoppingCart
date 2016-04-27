//
//  ShoppingCartModel.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject

@property(nonatomic,copy)NSString *shopname;
@property(nonatomic,strong)NSArray *goodslist;
@property(nonatomic,assign)BOOL isSelectHeader;

@end
