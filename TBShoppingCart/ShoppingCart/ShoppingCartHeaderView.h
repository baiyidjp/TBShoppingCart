//
//  ShoppingCartHeaderView.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(BOOL selected);

@interface ShoppingCartHeaderView : UIView

+ (instancetype)creatHeaderViewWithFrame:(CGRect)frame name:(NSString *)name selectBlock:(selectBlock)selectBlock;

@property(nonatomic,assign)BOOL select;

@end
