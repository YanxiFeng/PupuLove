//
//  PPTabBarController.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "PPTabBarController.h"
#import "PPNavigationController.h"
#import "BoysGirlsViewController.h"
#import "BBSViewController.h"
#import "UsersViewController.h"

@interface PPTabBarController ()

@end

@implementation PPTabBarController

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBar.backgroundImage = [UIImage imageWithColor:RGBA(244, 244, 244, .95) andSize:CGSizeMake(1, 44)];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Theme_Color, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(150, 150, 150), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    PPNavigationController *boyGirlNav = [self viewControllerWithClass:[[BoysGirlsViewController alloc] init] title:@"扑扑" image:@"tabbar_pu" selectedImage:@"tabbar_pu_selected"];
    PPNavigationController *bbsNav = [self viewControllerWithClass:[[BBSViewController alloc] init] title:@"情书" image:@"tabbar_lo" selectedImage:@"tabbar_lo_selected"];
    PPNavigationController *userNav = [self viewControllerWithClass:[[UsersViewController alloc] init] title:@"我的" image:@"tabbar_me" selectedImage:@"tabbar_me_selected"];
    
    [self setViewControllers:[NSArray arrayWithObjects:
                              boyGirlNav,
                              bbsNav,
                              userNav,
                              nil]];
    
    //[ICAdViewManager showAdViewFrom:self.view];
}

#pragma mark tabBar 相关



#pragma mark - support method
- (PPNavigationController *)viewControllerWithClass:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    PPNavigationController *nav = [[PPNavigationController alloc] initWithRootViewController:vc];
    
    return nav;
}

@end
