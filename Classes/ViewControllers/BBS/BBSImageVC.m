//
//  BBSImageVC.m
//  LeCao
//
//  Created by Mr. Feng on 3/6/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSImageVC.h"
#import "PublishBBSViewController.h"

@interface BBSImageVC ()

@end

@implementation BBSImageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = YES;
    self.view.backgroundColor = Backgroud_color;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
    [self.view addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    view.backgroundColor = [UIColor blackColor];
    imageView.frame = view.bounds;
    imageView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UIView *toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, SCREEN_WIDTH, 44)];
    toolsView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    toolsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolsView];
    
    UIImageView *toolsline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, toolsView.bounds.size.width, 0.5)];
    toolsline.backgroundColor = RGB(50, 50, 50);
    [toolsView addSubview:toolsline];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 0, 50, 44);
    [cancelBtn setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"nav_backon.png"] forState:UIControlStateHighlighted];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [toolsView addSubview:cancelBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(toolsView.frame.size.width - 50 - 10, 0, 50, 44);
    [deleteBtn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    deleteBtn.titleLabel.font = PPFONT(14);
    [deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [toolsView addSubview:deleteBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteImage{
    if ([self.imageSourceVC isKindOfClass:[PublishBBSViewController class]]) {
        PublishBBSViewController *vc = (PublishBBSViewController*)self.imageSourceVC;
        [vc.imageArray removeObject:_image];
        [vc reSetToolsView];
    }
    [self back];
}


@end
