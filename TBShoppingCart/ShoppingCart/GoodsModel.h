//
//  GoodsModel.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *originalprice;
@property(nonatomic,copy)NSString *shopcount;
@property(nonatomic,assign)BOOL isSelectCell;

@end
