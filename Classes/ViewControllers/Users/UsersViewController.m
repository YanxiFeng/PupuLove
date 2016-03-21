//
//  UsersViewController.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "UsersViewController.h"
#import "UsersCell.h"
#import "LoginViewController.h"
#import "UserInfoModel.h"
#import "PPAccountTool.h"
#import "SettingViewController.h"
#import "HotActivityViewController.h"
#import "FansViewController.h"
#import "InformationViewController.h"

@interface UsersViewController ()<UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate,SettingViewControllerDelegate,InformationViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemImgs;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, assign) BOOL isLogin;
@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.items = @[@[@"女神榜",@"男神榜"],@[@"热门活动"],@[@"设置"]];
    self.itemImgs = @[@[@"love_girl_list",@"love_boy_list"],@[@"love_activity"],@[@"love_setting"]];
    [self isLoginWithAccount];
    [self.view addSubview:self.tableView];
}

#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }else{
        return 55;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(240, 239, 245);
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIEdgeInsets edgeinset = UIEdgeInsetsZero;
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            edgeinset = UIEdgeInsetsMake(0, 15, 0, 0);
        }
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:edgeinset];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:edgeinset];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:edgeinset];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UsersCell *cell;
    if (indexPath.section == 0) {
        cell = [UsersCell initTableViewCellWithTableView:tableView index:0];
        cell.isLogin = _isLogin;
        cell.userInfo = self.userInfo;
    }else{
        
        cell = [UsersCell initTableViewCellWithTableView:tableView index:1];
        cell.item = self.items[indexPath.section-1][indexPath.row];
        cell.itemImg.image = [UIImage imageNamed:self.itemImgs[indexPath.section-1][indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isLogin) {
        //登录
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
        });
    }else{
        
        switch (indexPath.section) {
            case 0:
            {
                InformationViewController *vc = [[InformationViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                FansViewController *vc = [[FansViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                if (indexPath.row == 0) {
                    vc.title = @"女神榜";
                }else{
                    vc.title = @"男神榜";
                }
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                HotActivityViewController *vc = [[HotActivityViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                SettingViewController *vc = [[SettingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark --Delegate
- (void)loginViewControllerDelegateSucceed
{
    self.isLogin = YES;
    [self.tableView reloadData];
}
- (void)settingViewControllerDelegateLogout
{
    self.isLogin = NO;
    [self.tableView reloadData];
}

- (void)informationViewControllerDelegateSave
{
    [self.tableView reloadData];
}

#pragma mark --support morthod
- (void)isLoginWithAccount
{
    if (self.userInfo == nil) {
        _isLogin = NO;
    }else{
        if (self.userInfo.username == nil) {
            _isLogin = NO;
        }else{
            _isLogin = YES;
        }
    }
}

#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = RGB(240, 239, 245);
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (UserInfoModel *)userInfo
{
    _userInfo = [PPAccountTool getAccount];
    return _userInfo;
}

@end
