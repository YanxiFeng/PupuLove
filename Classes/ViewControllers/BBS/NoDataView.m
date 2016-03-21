//
//  NoDataView.m
//  LeCao
//
//  Created by Mr. Feng on 3/11/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
        label.font = PPFONT(14);
        label.text = @"没有更多数据";
        label.textColor = RGB(150, 150, 150);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}


@end
