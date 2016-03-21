//
//  UIImage+ColorImage.h
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage*)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

@end
