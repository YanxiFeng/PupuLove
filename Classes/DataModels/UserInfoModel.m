//
//  UserInfo.m
//  LeCao
//
//  Created by Mr. Feng on 3/2/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
+ (UserInfoModel *)getUserInfoWithAVObject:(AVObject *)obj
{
    UserInfoModel *user = [[UserInfoModel alloc] init];
    user.username = obj[@"username"];
    user.password = obj[@"password"];
    user.nickname = obj[@"nickname"];
    user.icon = obj[@"icon"];
    user.sign = obj[@"sign"];
    user.birthday = obj[@"birthday"];
    user.school = obj[@"school"];
    user.sex = obj[@"sex"];
    user.home = obj[@"home"];
    user.interests = obj[@"interests"];
    user.contacts = obj[@"contacts"];
    return user;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.school forKey:@"school"];
    [encoder encodeObject:self.birthday forKey:@"birthday"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.sign forKey:@"sign"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.username = [decoder decodeObjectForKey:@"username"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.school = [decoder decodeObjectForKey:@"school"];
        self.birthday = [decoder decodeObjectForKey:@"birthday"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.sign = [decoder decodeObjectForKey:@"sign"];
    }
    return self;
}
@end
