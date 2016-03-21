//
//  InformationViewController.h
//  LeCao
//
//  Created by Mr. Feng on 3/3/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PPViewController.h"

@protocol InformationViewControllerDelegate <NSObject>

- (void)informationViewControllerDelegateSave;

@end

@interface InformationViewController : PPViewController

@property (nonatomic, weak) id<InformationViewControllerDelegate> delegate;

@end
