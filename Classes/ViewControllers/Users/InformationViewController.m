//
//  InformationViewController.m
//  LeCao
//
//  Created by Mr. Feng on 3/3/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationCell.h"
#import <UIImageView+WebCache.h>
#import <QiniuSDK.h>
#import "UIImage+Resize.h"
#import "PPAccountTool.h"
#import "XHChooseBirthController.h"
#import "XHChangeSignViewController.h"

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,XHChooseBirthControllerDelegate,XHChangeSignViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *placeholders;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, strong) UIImage *iconImg;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *home;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *interests;
@property (nonatomic, copy) NSString *contacts;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonPressed:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}
                                                          forState:UIControlStateNormal];
    self.names = [NSMutableArray arrayWithArray:@[@[@"头像",@"昵称",@"性别",@"生日",@"学校",@"家乡"],@[@"个性签名",@"兴趣爱好"],@[@"联系方式"]]];
    self.placeholders = [NSMutableArray arrayWithArray:@[@[@"",@"",@"请选择性别",@"请选择出生年月",@"请编辑您的学校",@"请编辑您的家乡"],@[@"请编辑个性签名",@"请选择兴趣爱好"],@[@"请填写微信号等"]]];
    self.dataSource = @[@[@"",@"",@"",@"",@"",@""],@[@"",@""],@[@""]];
    [self.view addSubview:self.tableView];
    [self initData];
}
#pragma mark --method
- (void)initData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    AVQuery *query = [AVQuery queryWithClassName:_USER];
    [query whereKey:username equalTo:[[PPAccountTool getAccount] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error == nil) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
            
            _objectId = [[objects lastObject] objectId];
            UserInfoModel *userInfo = [UserInfoModel getUserInfoWithAVObject:[objects lastObject]];
            _iconUrl = userInfo.icon?userInfo.icon:@"";
            _nickname = userInfo.nickname?userInfo.nickname:@"";
            _sex = userInfo.sex?userInfo.sex:@"";
            _birthday = userInfo.birthday?userInfo.birthday:@"";
            _school = userInfo.school?userInfo.school:@"";
            _home = userInfo.home?userInfo.home:@"";
            _sign = userInfo.sign?userInfo.sign:@"";
            _interests = userInfo.interests?userInfo.interests:@"";
            _contacts = userInfo.contacts?userInfo.contacts:@"";
            [self reloadThisTableView];
        }
    }];
}
- (void)saveButtonPressed:(UIButton *)btn
{
    AVObject *user = [AVObject objectWithoutDataWithClassName:_USER objectId:_objectId];
    [user setObject:_iconUrl forKey:icon];
    [user setObject:_nickname forKey:nickname];
    [user setObject:_sex forKey:sex];
    [user setObject:_birthday forKey:birthday];
    [user setObject:_school forKey:school];
    [user setObject:_home forKey:@"home"];
    [user setObject:_sign forKey:sign];
    [user setObject:_interests forKey:@"interests"];
    [user setObject:_contacts forKey:@"contacts"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"保存成功"];
            UserInfoModel *info = [PPAccountTool getAccount];
            info.nickname = _nickname;
            info.icon = _iconUrl;
            info.sign = _sign;
            info.school = _school;
            [PPAccountTool saveAccount:info];
            if ([self.delegate respondsToSelector:@selector(informationViewControllerDelegateSave)]) {
                [self.delegate informationViewControllerDelegateSave];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma mark -TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 20;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }else{
            return 45;
        }
    }else{
        return 45;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIEdgeInsets edgeinset = UIEdgeInsetsZero;
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            edgeinset = UIEdgeInsetsMake(0, 15, 0, 0);
        }
    }else if (indexPath.section == 2){
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
    static NSString *identifier = @"InformationCell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationCell" owner:self options:nil] objectAtIndex:0];
            cell.iconLbl.text = @"头像";
            if (_iconImg) {
                cell.iconImgView.image = _iconImg;
            }else{
                [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:[UIImage imageNamed:@"not_login_icon"]];
            }
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationCell" owner:self options:nil] objectAtIndex:1];
            NSString *name = [_names[indexPath.section] objectAtIndex:indexPath.row];
            cell.nameLbl.text = name;
            NSString *placeholder = [_placeholders[indexPath.section] objectAtIndex:indexPath.row];
            NSString *text = _dataSource[indexPath.section][indexPath.row];
            if (text.length>0) {
                cell.textLbl.text = text;
                cell.placeholdLbl.hidden = YES;
                cell.textLbl.hidden = NO;
            }else{
                cell.placeholdLbl.text = placeholder;
                cell.placeholdLbl.hidden = NO;
                cell.textLbl.hidden = YES;
            }
        }
    } else {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationCell" owner:self options:nil] objectAtIndex:1];
        NSString *name = [_names[indexPath.section] objectAtIndex:indexPath.row];
        cell.nameLbl.text = name;
        NSString *placeholder = [_placeholders[indexPath.section] objectAtIndex:indexPath.row];
        NSString *text = _dataSource[indexPath.section][indexPath.row];
        if (text.length>0) {
            cell.textLbl.text = text;
            cell.placeholdLbl.hidden = YES;
            cell.textLbl.hidden = NO;
        }else{
            cell.placeholdLbl.text = placeholder;
            cell.placeholdLbl.hidden = NO;
            cell.textLbl.hidden = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self showImagePickerController];
                break;
            case 2:
                [self showGenderPickerActionSheet];
                break;
            case 3:
            {
                XHChooseBirthController *vc = [[XHChooseBirthController alloc] initWithNibName:@"XHChooseBirthController" bundle:nil];
                vc.delegate = self;
                vc.birthday = _birthday;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            case 4:
            case 5:
            {
                XHChangeSignViewController *vc = [[XHChangeSignViewController alloc] init];
                vc.indexPath = indexPath;
                vc.dataSource = _dataSource;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
            default:
                break;
        }
    }else{
        XHChangeSignViewController *vc = [[XHChangeSignViewController alloc] init];
        vc.indexPath = indexPath;
        vc.dataSource = _dataSource;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --support methord
- (void)showImagePickerController{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionSheet.tag = 10;
    [actionSheet showInView:self.view];
}
- (void)showGenderPickerActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"男",@"女", nil];
    actionSheet.tag = 11;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        
        if (buttonIndex == 0)
        {
            [self takeImageFromCamera];
        }
        else if (buttonIndex == 1)
        {
            [self takeImageFromPhotoLibrary];
        }
    }else if (actionSheet.tag == 11){
        if (buttonIndex == 0)
        {
            _sex = @"男";
        }
        else if (buttonIndex == 1)
        {
            _sex = @"女";
        }
        [self reloadThisTableView];
    }
}
- (void)reloadThisTableView
{
    _dataSource = @[@[@"",_nickname,_sex,_birthday,_school,_home],@[_sign,_interests],@[_contacts]];
    [self.tableView reloadData];
}

#pragma mark - DDActionSheet method 启动照相机

- (void)takeImageFromPhotoLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController* pickController = [[UIImagePickerController alloc] init];
        pickController.delegate = self;
        pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备无法读取相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)takeImageFromCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* pickController = [[UIImagePickerController alloc] init];
        pickController.delegate = self;
        pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持拍照功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImage* newImage = nil;
    if (image.size.width > 640) { //所有的图片尺寸控制在640*960内
        CGSize size;
        size.width = 640;
        size.height = image.size.height * (size.width/image.size.width);
        newImage = [image resizedImage:size interpolationQuality:kCGInterpolationDefault];
    }else {
        newImage = image;
    }
    
    if (newImage.size.height > 960) {
        CGSize size;
        size.height = 960;
        size.width = newImage.size.width * (size.height/newImage.size.height);
        newImage = [newImage resizedImage:size interpolationQuality:kCGInterpolationDefault];
    }
    
    CGRect rect;
    CGFloat h = newImage.size.height;
    CGFloat w = newImage.size.width;
    if (h>w) {
        rect = CGRectMake(0, (h-w)/2, w, w);
    }else{
        rect = CGRectMake((w-h)/2, 0, h, h);
    }
    newImage = [newImage croppedImage:rect];
    
    _iconImg = newImage;
    [self.tableView reloadData];
    // upload image
    [self upLoadImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)upLoadImage
{
    NSString *token = QINIUTOKEN;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(self.iconImg,0.5);
    NSString *imageURL = [NSString stringWithFormat:@"posterPhoto_uploader_%@.jpg",[NSString stringofCurrent]];
    [upManager putData:data key:imageURL token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
              } option:nil];
    self.iconUrl = [NSString stringWithFormat:@"http://jinshi2014.qiniudn.com/%@",imageURL];
}

#pragma mark --delegate
- (void)chooseBirthControllerWithBirthday:(NSString *)birthday
{
    _birthday = birthday;
    [self reloadThisTableView];
}
- (void)changeWithSign:(NSString *)sign indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
            {
                _nickname = sign;
                break;
            }
            case 4:
            {
                _school = sign;
                break;
            }
            case 5:
            {
                _home = sign;
                break;
            }
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                _sign = sign;
                break;
            }
            case 1:
            {
                _interests = sign;
                break;
            }
            default:
                break;
        }
    }else{
        _contacts = sign;
    }
    [self reloadThisTableView];
}
#pragma mark --getter & setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavbarHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
