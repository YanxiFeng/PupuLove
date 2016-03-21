//
//  BBSTableViewCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSTableViewCell.h"

@interface BBSTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation BBSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (BBSTableViewCell *)initTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BBSTableViewCell";
    BBSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *objects = [bundle loadNibNamed:@"BBSTableViewCell" owner:nil options:nil];
        cell =  objects[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setTopicModel:(BBSTopicModel *)topicModel
{
    _topicModel = topicModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.icon] placeholderImage:[UIImage imageNamed:placehold_icon]];
    self.nicknameLbl.text = topicModel.nickname;
    self.titleLbl.text = topicModel.title;
    self.contentLbl.text = topicModel.content;
    self.timeLbl.text = topicModel.updatedAt;
    self.schoolLbl.text = [NSString stringWithFormat:@"来自：%@",topicModel.school];
    if (topicModel.image) {
        self.picImageView.hidden = NO;
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image] placeholderImage:[UIImage imageNamed:placehold_icon]];
    }else{
        self.picImageView.hidden = YES;
    }
}

@end
