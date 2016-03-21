//
//  BBSCommentCell.m
//  LeCao
//
//  Created by Mr. Feng on 3/11/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSCommentCell.h"

@interface BBSCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation BBSCommentCell

- (void)awakeFromNib {
    // Initialization code
}

+ (BBSCommentCell *)initCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"BBSCommentCell";
    BBSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBSCommentCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setCommentModel:(TopicCommentModel *)commentModel
{
    _commentModel = commentModel;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.icon] placeholderImage:[UIImage imageNamed:placehold_icon]];
    self.nicknameLbl.text = commentModel.nickname;
    self.contentLbl.text = commentModel.content;
    self.timeLbl.text = commentModel.updatedAt;
}

@end
