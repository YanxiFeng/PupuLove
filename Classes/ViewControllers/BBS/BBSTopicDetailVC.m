//
//  BBSTopicDetailVC.m
//  LeCao
//
//  Created by Mr. Feng on 3/8/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSTopicDetailVC.h"
#import "BBSTopicModel.h"
#import "BBSTopicDetailCell.h"
#import "BBSCommentVC.h"
#import "LoginViewController.h"

@interface BBSTopicDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger numOfRows;
@property (nonatomic, strong) UIButton *deleBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@end

@implementation BBSTopicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"正文";
    [self dealWithTopicModel];
    [self.view addSubview:self.tableView];
    [self setRightBarItem];
}

#pragma mark --method
- (void)dealWithTopicModel
{
    //icon content title pic
    _numOfRows = 2;
    if (_topicModel.image.length>0) {
        _numOfRows ++;
    }
}
- (void)setRightBarItem
{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleBtn];
    UIBarButtonItem *commentBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.commentBtn];
    self.navigationItem.rightBarButtonItems = @[rightBarItem,commentBarItem];
    UserInfoModel *md = [PPAccountTool getAccount];
    if ([md.username isEqualToString:_topicModel.username]) {
        
    }else{
        [self.deleBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    }
}
- (void)deleteBtnPressed:(UIButton *)btn
{
    UserInfoModel *md = [PPAccountTool getAccount];
    if ([md.username isEqualToString:_topicModel.username]) {
        
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:@"确定删除这条帖子吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [al show];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"复制帖子内容", nil];
        [sheet showInView:self.view];
    }
}
- (void)commentBtnPressed:(UIButton *)btn
{
    if ([PPAccountTool isLogin]) {
        
        BBSCommentVC *vc = [[BBSCommentVC alloc] init];
        vc.topicModel = _topicModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark --delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        AVQuery *query = [AVQuery queryWithClassName:_BBS];
        [query whereKey:@"objectId" equalTo:_topicModel.objectId];
        [query deleteAllInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(topicDetailVCDelegateDeleteObject:)]) {
                [self.delegate topicDetailVCDelegateDeleteObject:_topicModel.objectId];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [MBProgressHUD showSuccess:@"谢谢举报！我们将尽快处理。"];
    }else if (buttonIndex == 1){
        [self copyItem];
    }
}
- (void)copyItem
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.topicModel.content;
}
#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSTopicDetailCell *cell = [BBSTopicDetailCell initTableViewCellWithTableView:tableView index:indexPath.row];
    cell.topicModel = _topicModel;
    return cell;
}

#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 50;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UIButton *)deleBtn
{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_deleBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _deleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    }
    return _deleBtn;
}
- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_commentBtn setImage:[UIImage imageNamed:@"love_review"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _commentBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
    }
    return _commentBtn;
}
@end
