//
//  BBSTopicDetailVC.h
//  LeCao
//
//  Created by Mr. Feng on 3/8/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PPViewController.h"
#import "BBSTopicModel.h"

@protocol BBSTopicDetailVCDelegate <NSObject>

- (void)topicDetailVCDelegateDeleteObject:(NSString *)objectId;

@end

@interface BBSTopicDetailVC : PPViewController
@property (nonatomic, strong) BBSTopicModel *topicModel;
@property (nonatomic, weak) id<BBSTopicDetailVCDelegate> delegate;
@end
