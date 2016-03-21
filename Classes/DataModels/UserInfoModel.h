//
//  UserInfo.h
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

+ (UserInfoModel *)getUserInfoWithAVObject:(AVObject *)obj;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *home;
@property (nonatomic, copy) NSString *sign;//签名
@property (nonatomic, copy) NSString *interests;
@property (nonatomic, copy) NSString *contacts;
@end
