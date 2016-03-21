//
//  TopicCommentModel.m
//  LeCao
//
//  Created by Mr. Feng on 3/11/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "TopicCommentModel.h"

@implementation TopicCommentModel
+ (TopicCommentModel *)getTopicCommentWithAVObject:(AVObject *)obj
{
    TopicCommentModel *topic = [[TopicCommentModel alloc] init];
    topic.username = obj[username];
    topic.icon = obj[icon];
    topic.nickname = obj[nickname];
    topic.content = obj[@"content"];
    topic.updatedAt = [NSDate formattedStringWithDate:obj[@"updatedAt"]];
    return topic;
}
@end
