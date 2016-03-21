//
//  SettingViewController.h
//  LeCao
//
//  Created by Mr. Feng on 3/3/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PPViewController.h"

@protocol SettingViewControllerDelegate <NSObject>

- (void)settingViewControllerDelegateLogout;

@end

@interface SettingViewController : PPViewController

@property (nonatomic, weak) id<SettingViewControllerDelegate> delegate;

@end
