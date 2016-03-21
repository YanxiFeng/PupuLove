//
//  BBSTableViewCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSTopicModel.h"

@interface BBSTableViewCell : UITableViewCell
+ (BBSTableViewCell *)initTableViewCellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) BBSTopicModel *topicModel;
@end
