//
//  XHChangeSignViewController.h
//  1.基本框架搭建
//
//  Created by Mr. Feng on 11/17/14.
//  Copyright (c) 2014 YN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHChangeSignViewControllerDelegate <NSObject>

- (void)changeWithSign:(NSString *)sign indexPath:(NSIndexPath *)indexPath;

@end

@interface XHChangeSignViewController : UIViewController
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) id<XHChangeSignViewControllerDelegate> delegate;

@end
