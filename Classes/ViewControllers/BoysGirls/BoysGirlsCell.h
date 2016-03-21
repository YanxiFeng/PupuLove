//
//  BoysGirlsCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoysGirlsCell : UITableViewCell
+ (BoysGirlsCell *)initTableViewCellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UserInfoModel *userInfo;
@end
