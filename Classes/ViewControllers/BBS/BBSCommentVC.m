//
//  BBSCommentVC.m
//  LeCao
//
//  Created by Mr. Feng on 3/10/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSCommentVC.h"
#import "BBSCommentCell.h"
#import "NoDataView.h"

#define kContent @"content"
#define kTopicId @"TopicId"
#define kLike @"like"

@interface BBSCommentVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UITextField *replyTextField;
@property (nonatomic, strong) UIView *windowBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesure;
@end

@implementation BBSCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    self.navigationItem.title = @"回复";
    [self.view addSubview:self.tableView];
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘的隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //[self showEditReplyView:nil];
    [self setupEditView];
    [self requestData];
}

- (void)requestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AVQuery *query = [AVQuery queryWithClassName:_BBSComments];
    [query whereKey:kTopicId equalTo:[AVObject objectWithoutDataWithClassName:_BBS objectId:_topicModel.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error == nil) {
            if (objects.count) {
                [self dealWithAVObjects:objects];
                _tableView.tableFooterView = [UIView new];
            }else{
                NoDataView *nodata = [[NoDataView alloc] init];
                _tableView.tableFooterView = nodata;
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)dealWithAVObjects:(NSArray *)objects
{
    for (AVObject *obj in objects) {
        TopicCommentModel *userInfo = [TopicCommentModel getTopicCommentWithAVObject:obj];
        [_dataSource addObject:userInfo];
    }
}
#pragma mark --UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSCommentCell *cell = [BBSCommentCell initCellWithTableView:tableView];
    cell.commentModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCommentModel *model = self.dataSource[indexPath.row];
    self.replyTextField.text = [NSString stringWithFormat:@"@%@:",model.nickname];
}

#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight-44) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 100;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (UITapGestureRecognizer *)tapGesure
{
    if (!_tapGesure) {
        _tapGesure =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditReplyView)];
    }
    return _tapGesure;
}
- (void)setupEditView
{
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-kNavbarHeight-44, SCREEN_WIDTH, 44)];
    editView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, editView.frame.size.width - 5*2, 33)];
    [editView addSubview:bgView];
    bgView.backgroundColor = RGB(220, 220, 220);
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    
    _replyTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, editView.frame.size.width - 10*2, 44)];
    [editView addSubview:_replyTextField];
    
    _replyTextField.textAlignment = NSTextAlignmentLeft;
    _replyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _replyTextField.keyboardType = UIKeyboardTypeDefault;
    _replyTextField.placeholder = @"写回复";
    _replyTextField.font = [UIFont systemFontOfSize:14];
    _replyTextField.returnKeyType = UIReturnKeySend;
    [_replyTextField addTarget:self action:@selector(sendReply:) forControlEvents:UIControlEventEditingDidEndOnExit];
    _replyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _editView = editView;
    [self.view addSubview:_editView];
    
}
- (void)keyboardWillShow:(NSNotification *)note
{
    [self.view addGestureRecognizer:self.tapGesure];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.editView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight);
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)note
{
    [self.view removeGestureRecognizer:self.tapGesure];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.editView.transform = CGAffineTransformIdentity;
    }];
}

- (void)sendReply:(UITextField *)textfield
{
    [self hideEditReplyView];
    
    NSString *Reply = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (Reply.length >= 2)
    {
        [self sendReplyWithText:Reply];
    }
    else
    {
        [MBProgressHUD showError:@"您输入的内容太短"];
    }
}

- (void)sendReplyWithText:(NSString *)text
{
    AVObject *comment = [[AVObject alloc] initWithClassName:_BBSComments];
    [comment setObject:@1 forKey:kLike];
    [comment setObject:text forKey:kContent];
    UserInfoModel *user = [PPAccountTool getAccount];
    [comment setObject:user.username forKey:username];
    [comment setObject:user.nickname forKey:nickname];
    [comment setObject:user.icon forKey:icon];
    
    [comment setObject:[AVObject objectWithoutDataWithClassName:_BBS objectId:_topicModel.objectId] forKey:kTopicId];
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"回复成功"];
            [self.dataSource removeAllObjects];
            [self requestData];
            self.replyTextField.text = nil;
        }
    }];
}
- (void)hideEditReplyView
{
    [_replyTextField resignFirstResponder];
}

@end
