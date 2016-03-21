//
//  PublishBBSViewController.h
//  LeCao
//
//  Created by Mr. Feng on 3/6/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PPViewController.h"

@protocol PublishBBSVCDelegate <NSObject>

- (void)publishBBSVCDelegateReloadBBS;

@end

@interface PublishBBSViewController : PPViewController

@property (strong, nonatomic) NSMutableArray *imageArray;

- (void)reSetToolsView;

@property (nonatomic, weak) id<PublishBBSVCDelegate> delegate;

@end
