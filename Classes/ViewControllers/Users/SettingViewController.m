//
//  SettingViewController.m
//  LeCao
//
//  Created by Mr. Feng on 3/3/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "PPAccountTool.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    [self.view addSubview:self.tableView];
    self.items = @[@"清除缓存",@"关于爱的扑扑",@"退出登录"];
}
#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self getView];
}
- (UIView *)getView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = RGB(245, 243, 243);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"settingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.items[indexPath.section];
        cell.textLabel.font = PPFONT(15);
        cell.textLabel.textColor = Content_Color;
        if (indexPath.section == 2) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [[SDImageCache sharedImageCache] clearDisk];
            [MBProgressHUD showSuccess:@"缓存清除成功"];
        }
            break;
        case 1:
        {
            AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UserInfoModel *info = [[UserInfoModel alloc] init];
            [PPAccountTool saveAccount:info];
            if ([self.delegate respondsToSelector:@selector(settingViewControllerDelegateLogout)]) {
                [self.delegate settingViewControllerDelegateLogout];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        default:
            break;
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [self getView];
    }
    return _tableView;
}

@end
