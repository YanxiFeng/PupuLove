//
//  IndividualCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/4/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "IndividualCell.h"

@interface IndividualCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolLbl;
@property (weak, nonatomic) IBOutlet UILabel *signLbl;

@property (weak, nonatomic) IBOutlet UIImageView *itemImgeV;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation IndividualCell

- (void)awakeFromNib {
    // Initialization code
}

+ (IndividualCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index
{
    NSString *ID = [NSString stringWithFormat:@"IndividualCell_%ld",(long)index];
    IndividualCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *objects = [bundle loadNibNamed:@"IndividualCell" owner:nil options:nil];
        cell =  objects[index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setUserModel:(UserInfoModel *)userModel
{
    _userModel = userModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.icon] placeholderImage:[UIImage imageNamed:placehold_icon]];
    NSString *sexImg = [userModel.sex isEqualToString:@"男"]?@"boy":@"girl";
    self.sexImageView.image = [UIImage imageNamed:sexImg];
    self.nicknameLbl.text = userModel.nickname;
    self.schoolLbl.text = [NSString stringWithFormat:@"%@岁 %@",[NSString ageWithBirth:userModel.birthday],[NSString getAstroWithBirth:userModel.birthday]];
    self.signLbl.text = userModel.sign;
}

- (void)setItem:(NSString *)item
{
    _item = item;
    if ([item isEqualToString:@"兴趣爱好"]) {
        self.itemImgeV.image = [UIImage imageNamed:@"love_hobby"];
        self.contentLbl.text = [NSString stringWithFormat:@"兴趣爱好：%@",_userModel.interests];
    }else if ([item isEqualToString:@"学校"]){
        self.itemImgeV.image = [UIImage imageNamed:@"love_university"];
        self.contentLbl.text = [NSString stringWithFormat:@"学校：%@",_userModel.school];
    }else if ([item isEqualToString:@"家乡"]){
        self.itemImgeV.image = [UIImage imageNamed:@"love_home"];
        self.contentLbl.text = [NSString stringWithFormat:@"家乡：%@",_userModel.home];
    }else{
        self.itemImgeV.image = [UIImage imageNamed:@"love_phone"];
        self.contentLbl.text = [NSString stringWithFormat:@"联系方式：%@",_userModel.contacts];
    }
}

@end
