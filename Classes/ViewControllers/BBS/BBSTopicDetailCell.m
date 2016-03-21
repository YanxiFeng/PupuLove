//
//  BBSTopicDetailCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/8/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSTopicDetailCell.h"

@interface BBSTopicDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *updateLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;

@end

@implementation BBSTopicDetailCell

- (void)awakeFromNib {
    // Initialization code
}

+ (BBSTopicDetailCell *)initTableViewCellWithTableView:(UITableView *)tableView index:(NSInteger)index
{
    NSString *ID = [NSString stringWithFormat:@"BBSTopicDetailCell_%ld",(long)index];
    BBSTopicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *objects = [bundle loadNibNamed:@"BBSTopicDetailCell" owner:nil options:nil];
        cell =  objects[index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setTopicModel:(BBSTopicModel *)topicModel
{
    _topicModel = topicModel;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_topicModel.icon] placeholderImage:[UIImage imageNamed:placehold_icon]];
    self.nicknameLbl.text = _topicModel.nickname;
    self.updateLbl.text = _topicModel.updatedAt;
    
    self.titleLbl.text = _topicModel.title;
    self.contentLbl.text = _topicModel.content;
    
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:_topicModel.image] placeholderImage:[UIImage imageNamed:placehold_icon]];

}


@end
