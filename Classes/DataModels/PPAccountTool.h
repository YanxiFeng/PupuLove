//
//  PPAccountTool.h
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface PPAccountTool : NSObject
/** 保存用户信息 */
+ (BOOL)saveAccount:(UserInfoModel *)account;
/** 获取用户信息 */
+ (UserInfoModel *)getAccount;
/** 是否登录 */
+ (BOOL)isLogin;
@end
