//
//  LoginViewController.h
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPAccountTool.h"

@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewControllerDelegateSucceed;

@end

@interface LoginViewController : UIViewController
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;
@end
