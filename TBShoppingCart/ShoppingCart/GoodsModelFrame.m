//
//  GoodsModelFrame.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "GoodsModelFrame.h"
#import "GoodsModel.h"
#import "UIView+XL.h"

#define FONTSIZE(x)  [UIFont systemFontOfSize:x]//设置字体大小
#define KWIDTH  [UIScreen mainScreen].bounds.size.width//屏幕的宽
#define KHEIGHT [UIScreen mainScreen].bounds.size.height//屏幕的高
#define KMARGIN 10//默认间距
#define NAVHEIGHT 64 //导航栏的高度
#define TEXTSIZEWITHFONT(text,font) [text sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName]]//根据文本及其字号返回size

@implementation GoodsModelFrame

- (void)setGoodsModel:(GoodsModel *)goodsModel{

    _goodsModel = goodsModel;
    
    CGFloat iconY = KMARGIN/2;
    CGFloat iconX = 40;
    self.shopIconFrame = CGRectMake(iconX, iconY, 90, 90);
    
    CGFloat nameX = CGRectGetMaxX(self.shopIconFrame)+KMARGIN;
    CGFloat nameY = KMARGIN/2;
    CGSize nameSize = [goodsModel.name boundingRectWithSize:CGSizeMake(KWIDTH-CGRectGetMaxX(self.shopIconFrame)-2*KMARGIN, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSMutableDictionary dictionaryWithObject:FONTSIZE(13) forKey:NSFontAttributeName] context:nil].size;
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    CGFloat descX = nameX;
    CGFloat descY = CGRectGetMaxY(self.nameLabelFrame)+KMARGIN/2;
    CGSize descSize = [goodsModel.desc boundingRectWithSize:CGSizeMake(KWIDTH, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSMutableDictionary dictionaryWithObject:FONTSIZE(13) forKey:NSFontAttributeName] context:nil].size;
    self.descLabelFrame = CGRectMake(descX, descY, descSize.width, descSize.height);
    
    NSString *priceText = [NSString stringWithFormat:@"￥%@",goodsModel.price];
    CGFloat priceX = nameX;
    CGSize priceSize = TEXTSIZEWITHFONT(priceText, FONTSIZE(15));
    CGFloat priceY = CGRectGetMaxY(self.shopIconFrame)-priceSize.height;
    self.priceLabelFrame = CGRectMake(priceX, priceY, priceSize.width, priceSize.height);
    
    if (goodsModel.originalprice.length) {
        
        NSString *oripriceText = [NSString stringWithFormat:@"￥%@",goodsModel.originalprice];
        CGFloat originalPriceX = CGRectGetMaxX(self.priceLabelFrame)+KMARGIN/2;
        CGSize originalPriceSize = TEXTSIZEWITHFONT(oripriceText, FONTSIZE(13));
        CGFloat originalPriceY = CGRectGetMaxY(self.shopIconFrame)-originalPriceSize.height;
        self.originalPriceFrame = CGRectMake(originalPriceX, originalPriceY, originalPriceSize.width, originalPriceSize.height);
        
        self.lineViewFrame = CGRectMake(0, originalPriceSize.height/2-1, originalPriceSize.width, 2);
    }
    
    NSString *text = [NSString stringWithFormat:@"x%@",goodsModel.shopcount];
    CGSize countSize = TEXTSIZEWITHFONT(text, FONTSIZE(13));
    CGFloat countX = KWIDTH-KMARGIN-countSize.width;
    CGFloat countY = CGRectGetMaxY(self.shopIconFrame)-countSize.height;
    self.shopCountLabelFrame = CGRectMake(countX, countY, countSize.width, countSize.height);
    
    CGFloat btnX = KMARGIN;
    CGSize btnSize = CGSizeMake(20, 20);
    CGFloat btnY = CGRectGetMidY(self.shopIconFrame)-btnSize.height/2;
    self.selectBtnFrame = CGRectMake(btnX, btnY, btnSize.width, btnSize.height);
    
    self.backgroundViewFrame = CGRectMake(0, KMARGIN/5, KWIDTH, CGRectGetMaxY(self.shopIconFrame)+KMARGIN/2);
    self.cellHeight = CGRectGetMaxY(self.backgroundViewFrame);
}

@end
