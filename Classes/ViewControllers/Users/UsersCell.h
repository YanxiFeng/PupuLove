//
//  UsersCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersCell : UITableViewCell

+ (UsersCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, copy) NSString *item;
@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
@property (nonatomic, assign) BOOL isLogin;
@end
