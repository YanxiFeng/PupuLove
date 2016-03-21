//
//  TopicCommentModel.h
//  LeCao
//
//  Created by Mr. Feng on 3/11/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicCommentModel : NSObject
+ (TopicCommentModel *)getTopicCommentWithAVObject:(AVObject *)obj;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, strong) UIImage *pic;
@end
