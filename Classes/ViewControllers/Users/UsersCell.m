//
//  UsersCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "UsersCell.h"
#import <UIImageView+WebCache.h>

@interface UsersCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *signLbl;
@property (weak, nonatomic) IBOutlet UILabel *notLoginLbl;

@property (weak, nonatomic) IBOutlet UILabel *itemLbl;

@end

@implementation UsersCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UsersCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index
{
    NSString *ID = [NSString stringWithFormat:@"UsersCell_%ld",(long)index];
    UsersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *objects = [bundle loadNibNamed:@"UsersCell" owner:nil options:nil];
        cell =  objects[index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setUserInfo:(UserInfoModel *)userInfo
{
    _userInfo = userInfo;
    if (!_isLogin) {
        self.nicknameLbl.hidden = YES;
        self.signLbl.hidden = YES;
        self.notLoginLbl.hidden = NO;
    }else{
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.icon] placeholderImage:[UIImage imageNamed:placehold_icon]];
        self.nicknameLbl.text = userInfo.nickname;
        self.signLbl.text = [NSString stringWithFormat:@"签名：%@",userInfo.sign];
        self.notLoginLbl.hidden = YES;
    }
}

- (void)setItem:(NSString *)item
{
    _item = item;
    self.itemLbl.text = item;
}

@end
