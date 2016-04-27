//
//  GoodsModelFrame.h
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GoodsModel;
@interface GoodsModelFrame : NSObject

@property(nonatomic,strong)GoodsModel *goodsModel;

@property(nonatomic,assign)CGRect selectBtnFrame;
@property(nonatomic,assign)CGRect shopIconFrame;
@property(nonatomic,assign)CGRect nameLabelFrame;
@property(nonatomic,assign)CGRect descLabelFrame;
@property(nonatomic,assign)CGRect priceLabelFrame;
@property(nonatomic,assign)CGRect originalPriceFrame;
@property(nonatomic,assign)CGRect lineViewFrame;
@property(nonatomic,assign)CGRect shopCountLabelFrame;
@property(nonatomic,assign)CGRect backgroundViewFrame;
@property(nonatomic,assign)CGFloat cellHeight;
@end
