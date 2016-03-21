//
//  IndividualCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/4/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualCell : UITableViewCell
+ (IndividualCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index;
@property (nonatomic, strong) UserInfoModel *userModel;
@property (nonatomic, copy) NSString *item;
@end
