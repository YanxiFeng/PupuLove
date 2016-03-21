//
//  BBSTopicModel.h
//  LeCao
//
//  Created by Mr. Feng on 3/6/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSTopicModel : NSObject

+ (BBSTopicModel *)getBBSTopicWithAVObject:(AVObject *)obj;

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *updatedAt;
@end
