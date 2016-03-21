//
//  PPNavigationController.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "PPNavigationController.h"

@interface PPNavigationController ()

@end

@implementation PPNavigationController


#pragma mark - view lifecycle
+ (void)initialize
{
    [self setNavTheme];
    [self setButtonTheme];
}

+ (void)setNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageWithColor:Theme_Color andSize:CGSizeMake(1, 64)] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = RGB(250, 250, 250);
    textDict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:textDict];
}

+ (void)setButtonTheme
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *normalMd = [NSMutableDictionary dictionary];
    normalMd[NSForegroundColorAttributeName] = [UIColor whiteColor];
    normalMd[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:normalMd forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    self.view.backgroundColor = RGB(240, 240, 240);
    [super viewDidLoad];
}

#pragma mark - overload method


@end
