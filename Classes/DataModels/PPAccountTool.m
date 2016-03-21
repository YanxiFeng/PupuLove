//
//  PPAccountTool.m
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PPAccountTool.h"

@implementation PPAccountTool
+ (BOOL)saveAccount:(UserInfoModel *)account
{
    // 获取doc的目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接保存的路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"account.data"];
    // 存储返回的用户信息
    return  [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+ (UserInfoModel *)getAccount
{
    // 获取doc的目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接保存的路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"account.data"];
    // 获取用户存储的授权信息
    UserInfoModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return account;
}

+ (BOOL)isLogin
{
    BOOL _isLogin;
    UserInfoModel *userInfo = [PPAccountTool getAccount];
    if (userInfo == nil) {
        _isLogin = NO;
    }else{
        if (userInfo.username == nil) {
            _isLogin = NO;
        }else{
            _isLogin = YES;
        }
    }
    return _isLogin;
}
@end
