//
//  BBSViewController.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSTableViewCell.h"
#import "PublishBBSViewController.h"
#import "BBSTopicModel.h"
#import "PPAccountTool.h"
#import "LoginViewController.h"
#import "BBSTopicDetailVC.h"

@interface BBSViewController ()<UITableViewDataSource,UITableViewDelegate,PublishBBSVCDelegate,BBSTopicDetailVCDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *publishBtn;
@end

@implementation BBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"情书";
    [self.view addSubview:self.tableView];
    self.dataSource = [NSMutableArray array];
    UIBarButtonItem *publishBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.publishBtn];
    self.navigationItem.rightBarButtonItem = publishBtnItem;
    
    [self getDataList];
}

/** 请求数据 */
- (void)getDataList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    AVQuery *query = [AVQuery queryWithClassName:_BBS];
    [query orderByDescending:@"updatedAt"];
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
        BBSTopicModel *userInfo = [BBSTopicModel getBBSTopicWithAVObject:obj];
        [self.dataSource addObject:userInfo];
    }
}

- (void)showPublishBBSViewController
{
    if ([PPAccountTool isLogin]) {
        PublishBBSViewController *vc = [[PublishBBSViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark --PublishBBSVCDelegate\BBSTopicDetailVCDelegate
- (void)publishBBSVCDelegateReloadBBS
{
    [self.dataSource removeAllObjects];
    [self getDataList];
}

- (void)topicDetailVCDelegateDeleteObject:(NSString *)objectId
{
    [self.dataSource removeAllObjects];
    [self getDataList];
}

#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSTableViewCell *cell = [BBSTableViewCell initTableViewCellWithTableView:tableView];
    cell.topicModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSTopicDetailVC *vc = [[BBSTopicDetailVC alloc] init];
    vc.topicModel = self.dataSource[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 100;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishBtn.frame = CGRectMake(0, 0, 40, 40);
        [_publishBtn setImage:[[UIImage imageNamed:@"comment_write"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_publishBtn addTarget:self action:@selector(showPublishBBSViewController) forControlEvents:UIControlEventTouchUpInside];
        _publishBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    }
    return _publishBtn;
}

@end
