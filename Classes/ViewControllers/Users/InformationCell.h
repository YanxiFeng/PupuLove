//
//  InformationCell.h
//  LeCao
//
//  Created by Mr. Feng on 3/4/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iconLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeholdLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@end
