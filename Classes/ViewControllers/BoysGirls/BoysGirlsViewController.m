//
//  BoysGirlsViewController.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "BoysGirlsViewController.h"
#import "BoysGirlsCell.h"
#import "IndividualPageController.h"

@interface BoysGirlsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BoysGirlsViewController

#pragma mark --Lifesycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扑扑";
    [self.view addSubview:self.tableView];
    self.dataSource = [NSMutableArray array];
    [self getDataList];
}

#pragma mark --support-method

/** 请求数据 */
- (void)getDataList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    AVQuery *query = [AVQuery queryWithClassName:_USER];
    [query orderByAscending:@"nickname"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error == nil) {
            NSArray<AVObject *> *list = objects;
            [self dealWithAVObjects:list];
            [self.tableView reloadData];
        }
    }];
    
}

- (void)dealWithAVObjects:(NSArray *)objects
{
    for (AVObject *obj in objects) {
        UserInfoModel *userInfo = [UserInfoModel getUserInfoWithAVObject:obj];
        [self.dataSource addObject:userInfo];
    }
}

#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoysGirlsCell *cell = [BoysGirlsCell initTableViewCellWithTableView:tableView];
    cell.userInfo = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndividualPageController *vc = [[IndividualPageController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStylePlain];
        _tableView.rowHeight = 70;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
