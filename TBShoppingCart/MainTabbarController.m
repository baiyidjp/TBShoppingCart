//
//  MainTabbarController.m
//  TBShoppingCart
//
//  Created by tztddong on 16/4/27.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "MainTabbarController.h"
#import "HomeCtrl.h"
#import "Myctrl.h"
#import "ShoppingCartCtrl.h"

@interface MainTabbarController ()

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *iconArray;
@property(nonatomic,strong)NSArray *ctrlArray;

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configChildCtrl];
}

- (NSArray *)titleArray{

    if (!_titleArray) {
        _titleArray = [[NSArray alloc]init];
        _titleArray = @[@"首页",@"购物车",@"我的"];
    }
    return _titleArray;
}

- (NSArray *)iconArray{

    if (!_iconArray) {
        _iconArray = [[NSArray alloc]init];
        _iconArray = @[@"shoye",@"gouwuche",@"wode"];
    }
    return _iconArray;
}

- (NSArray *)ctrlArray{

    if (!_ctrlArray) {
        _ctrlArray = [[NSArray alloc]init];
        HomeCtrl *ctrl1 = [[HomeCtrl alloc]init];
        ShoppingCartCtrl *ctrl2 = [[ShoppingCartCtrl alloc]init];
        Myctrl *ctrl3 = [[Myctrl alloc]init];
        _ctrlArray = @[ctrl1,ctrl2,ctrl3];
    }
    return _ctrlArray;

}
- (void)configChildCtrl{

    for (int i = 0; i < self.titleArray.count; i++) {
        
        [self creatChildCtrlWithTitle:self.titleArray[i] icon:self.iconArray[i] ctrl:self.ctrlArray[i]];
    }
    
}

- (void)creatChildCtrlWithTitle:(NSString *)title icon:(NSString *)iconName ctrl:(UIViewController *)ctrl{
    
    ctrl.title = title;
    ctrl.tabBarItem.title = title;
    ctrl.tabBarItem.image = [UIImage imageNamed:iconName];
    
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:ctrl];
    [self addChildViewController:navCtrl];
    
}



@end
