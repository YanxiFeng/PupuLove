//
//  UIImage+ColorImage.m
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+ (UIImage*)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    @autoreleasepool
    {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    @autoreleasepool
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
        [tintColor setFill];
        CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
        UIRectFill(bounds);
        
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
        
        UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tintedImage;
    }
}
@end
