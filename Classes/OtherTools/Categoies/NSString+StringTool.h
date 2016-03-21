//
//  NSString+StringTool.h
//  LeCao
//
//  Created by Mr. Feng on 3/7/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTool)
/** 当前时间字符串 */
+ (NSString *) stringofCurrent;
+ (NSString *)ageWithBirth:(NSString *)birth;
+ (NSString *)getAstroWithBirth:(NSString *)birthday;
@end
