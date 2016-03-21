//
//  BBSTopicModel.m
//  LeCao
//
//  Created by Mr. Feng on 3/6/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "BBSTopicModel.h"

@implementation BBSTopicModel

+ (BBSTopicModel *)getBBSTopicWithAVObject:(AVObject *)obj
{
    BBSTopicModel *topic = [[BBSTopicModel alloc] init];
    topic.objectId = obj.objectId;
    topic.username = obj[username];
    topic.icon = obj[icon];
    topic.nickname = obj[nickname];
    topic.school = obj[school];
    topic.title = obj[@"title"];
    topic.content = obj[@"content"];
    topic.image = obj[@"image"];
    topic.updatedAt = [NSDate formattedStringWithDate:obj[@"updatedAt"]];
    return topic;
}

@end
