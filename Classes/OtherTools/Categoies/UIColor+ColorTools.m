//
//  UIColor+ColorTools.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "UIColor+ColorTools.h"

@implementation UIColor (ColorTools)
+ (UIColor *)colorWithHexColor:(NSString*)hexColor
{
    // hex格式:@"#ff7300",否则抛出异常
    assert(7 == [hexColor length]);
    assert('#' == [hexColor characterAtIndex:0]);
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexColor substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexColor substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexColor substringWithRange:NSMakeRange(5, 2)]];
    
    // R
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    // G
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    // B
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:1.0];
}
+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}
@end
