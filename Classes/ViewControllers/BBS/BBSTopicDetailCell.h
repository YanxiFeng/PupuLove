//
//  BBSTopicDetailCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/8/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSTopicModel.h"

@interface BBSTopicDetailCell : UITableViewCell
+ (BBSTopicDetailCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index;
@property (nonatomic, strong) BBSTopicModel *topicModel;
@end
