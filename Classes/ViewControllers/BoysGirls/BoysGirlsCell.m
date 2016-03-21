//
//  BoysGirlsCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BoysGirlsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BoysGirlsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolLbl;
@property (weak, nonatomic) IBOutlet UILabel *signLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgV;

@end

@implementation BoysGirlsCell

- (void)awakeFromNib {
    // Initialization code
}

+ (BoysGirlsCell *)initTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BoysGirlsCell";
    BoysGirlsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *objects = [bundle loadNibNamed:@"BoysGirlsCell" owner:nil options:nil];
        cell =  objects[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setUserInfo:(UserInfoModel *)userInfo
{
    _userInfo = userInfo;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.icon] placeholderImage:[UIImage imageNamed:@"placehold_icon"]];
    self.nicknameLbl.text = userInfo.nickname;
    self.schoolLbl.text = [NSString stringWithFormat:@"%@岁 %@",[NSString ageWithBirth:userInfo.birthday],userInfo.school];
    self.signLbl.text = userInfo.sign;
    NSString *sexImg = [userInfo.sex isEqualToString:@"男"]?@"boy":@"girl";
    self.sexImgV.image = [UIImage imageNamed:sexImg];
}

@end
