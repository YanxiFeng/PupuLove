//
//  BBSCommentCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/11/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicCommentModel.h"

@interface BBSCommentCell : UITableViewCell
@property (nonatomic, strong) TopicCommentModel *commentModel;
+ (BBSCommentCell *)initCellWithTableView:(UITableView *)tableView;
@end
