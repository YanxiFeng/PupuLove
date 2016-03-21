//
//  MBProgressHUD+Show.h
//  LeCao
//
//  Created by Mr. Feng on 3/5/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Show)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
