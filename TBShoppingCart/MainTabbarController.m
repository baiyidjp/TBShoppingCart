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

    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        
        [self creatChildCtrlWithTitle:self.titleArray[i] icon:self.iconArray[i] ctrl:self.ctrlArray[i] tag:i];
    }
    
}

- (void)creatChildCtrlWithTitle:(NSString *)title icon:(NSString *)iconName ctrl:(UIViewController *)ctrl tag:(NSInteger)tag{
    
    ctrl.title = title;
    ctrl.tabBarItem.title = title;
    ctrl.tabBarItem.image = [UIImage imageNamed:iconName];
    ctrl.tabBarItem.tag = tag;
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:ctrl];
    [self addChildViewController:navCtrl];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [[tabbarbuttonArray[index] layer] addAnimation:shakeAnimation forKey:nil];
    
//    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.08;
//    pulse.repeatCount= 1;
//    pulse.autoreverses= YES;
//    pulse.fromValue= [NSNumber numberWithFloat:0.7];
//    pulse.toValue= [NSNumber numberWithFloat:1.3];
//    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

@end
