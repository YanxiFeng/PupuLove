//
//  IndividualPageController.m
//  LeCao
//
//  Created by Mr. Feng on 3/4/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "IndividualPageController.h"
#import "IndividualCell.h"

@interface IndividualPageController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@end

@implementation IndividualPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人主页";
    [self.view addSubview:self.tableView];
    self.items = @[@"学校",@"家乡",@"兴趣爱好",@"联系方式"];
}

#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self getView];
}
- (UIView *)getView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(245, 243, 243);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndividualCell *cell;
    if (indexPath.section == 0) {
        cell = [IndividualCell initTableViewCellWithTableView:tableView index:0];
        cell.userModel = self.userModel;
    }else{
        cell = [IndividualCell initTableViewCellWithTableView:tableView index:1];
        cell.userModel = self.userModel;
        cell.item = _items[indexPath.section-1];
    }
    return cell;
}
#pragma mark --getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100;
    }
    return _tableView;
}

@end
