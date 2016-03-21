//
//  LoginViewController.m
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
- (IBAction)weiboLogin:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
- (IBAction)canselClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
}

#pragma mark --support morthod
- (void)saveUserInfo:(UserInfoModel *)user
{
    AVQuery *query = [AVQuery queryWithClassName:_USER];
    [query whereKey:username equalTo:user.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0) {
            //保存用户信息
            AVObject *av = [AVObject objectWithClassName:_USER];
            [av setObject:user.username forKey:username];
            [av setObject:user.password forKey:password];
            [av setObject:user.nickname forKey:nickname];
            [av setObject:user.icon forKey:icon];
            [av setObject:user.sign forKey:sign];
            [av setObject:user.school forKey:school];
            [av setObject:user.birthday forKey:birthday];
            [av setObject:user.sex forKey:sex];
            [av setObject:user.interests forKey:@"interests"];
            [av setObject:user.home forKey:@"home"];
            [av setObject:user.contacts forKey:@"contacts"];
            [av saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    UserInfoModel *info = [UserInfoModel getUserInfoWithAVObject:av];
                    [PPAccountTool saveAccount:info];
                    [self loginSucceed];
                } else {
                    //保存失败
                }
            }];
        }else{
            UserInfoModel *userInfo = [UserInfoModel getUserInfoWithAVObject:objects[0]];
            [PPAccountTool saveAccount:userInfo];
            [self loginSucceed];
        }
    }];
    
}
- (void)loginSucceed
{
    if ([self.delegate respondsToSelector:@selector(loginViewControllerDelegateSucceed)]) {
        [self.delegate loginViewControllerDelegateSucceed];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sina
{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:SINAAPPKEY andAppSecret:SINAAPPSECRET andRedirectURI:@"http://fengyanxi.cn"];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
        } else {
            NSDictionary *rawUser = object[@"raw-user"];
            UserInfoModel *user = [[UserInfoModel alloc] init];
            user.username = [NSString stringWithFormat:@"sina_%@",object[@"id"]];
            user.password = @"123456";
            user.school = @"天津师范大学管理学院";
            user.birthday = @"19950101";
            user.sex = @"女";
            user.contacts = @"暂无";
            user.home = @"湖南长沙";
            user.interests = @"购物、看电影、写作、绘画、摄影、旅游。。。";
            user.nickname = object[@"username"];
            user.icon = rawUser[@"profile_image_url"];
            user.sign = rawUser[@"description"];
            //登录成功
            [self saveUserInfo:user];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];
}
- (void)weChat
{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin withAppKey:SINAAPPKEY andAppSecret:SINAAPPSECRET andRedirectURI:@""];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
        } else {
            
        }
    } toPlatform:AVOSCloudSNSWeiXin];
}

- (IBAction)wechatLogin:(id)sender {
    [self weChat];
}

- (IBAction)weiboLogin:(id)sender {
    [self sina];
}

- (IBAction)loginBtnClick:(id)sender {
    AVQuery *query = [AVQuery queryWithClassName:_USER];
    [query whereKey:username equalTo:self.accountTextField.text];
    [query whereKey:password equalTo:self.passwdTextField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0) {
            [MBProgressHUD showError:@"账号或密码错误"];
        }else{
            UserInfoModel *userInfo = [UserInfoModel getUserInfoWithAVObject:objects[0]];
            [PPAccountTool saveAccount:userInfo];
            [self loginSucceed];
        }
    }];
}

- (IBAction)canselClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
