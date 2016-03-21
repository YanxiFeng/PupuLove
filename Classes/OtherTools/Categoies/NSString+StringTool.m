//
//  NSString+StringTool.m
//  LeCao
//
//  Created by Mr. Feng on 3/7/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "NSString+StringTool.h"

@implementation NSString (StringTool)
+ (NSString *) stringofCurrent {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyyMMddHHmmsszzz"];
    return [formatter stringFromDate:[NSDate date]];
}
+ (NSString *)ageWithBirth:(NSString *)birth
{
    if (birth == nil) {
        return nil;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *myDate = [dateFormatter dateFromString:birth];
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitYear;
    NSDateComponents *comps = [gregorian
                               components:unitFlags fromDate:myDate  toDate:now  options:0];
    NSInteger year = [comps year];
    return [NSString stringWithFormat:@"%ld",(long)year];
}
+ (NSString *)getAstroWithBirth:(NSString *)birthday
{
    if (birthday == nil) {
        return nil;
    }
    NSInteger m = [[birthday substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger d = [[birthday substringWithRange:NSMakeRange(6, 2)] integerValue];
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return [result stringByAppendingString:@"座"];
}
@end
