//
//  macro.h
//  PupuLove
//
//  Created by Mr. Feng on 3/1/16.
//  Copyright © 2016 YanxiFeng. All rights reserved.
//

#ifndef macro_h
#define macro_h

#define ImageFromResource(x) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:x ofType:nil]] //从mainBundle中 拿图片

#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

#define RGBA(r, g, b, a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define PPFONT(x) [UIFont systemFontOfSize:x]

#define Theme_Color RGB(246, 58, 62)
#define Backgroud_color RGB(242, 243, 245)
#define Title_Color RGB(100, 100, 100)
#define Content_Color RGB(62, 62, 62)

#define SINAAPPKEY @"1337939509"
#define SINAAPPSECRET @"e87890c0d7d365d5a7ffb92b3738ff87"

#define QINIUTOKEN  @"6Qktv2QMjNkt8Qgs6QLzZNZ2P2uA-d68vtFbSVuK:mI7HxpJV3wpGGC45U5zwN_LUZ9g=:eyJzY29wZSI6ImppbnNoaTIwMTQiLCJkZWFkbGluZSI6MTU3MjMyODA3N30="

#define _USER @"UsersDatas"
#define _BBS @"BBSDatas"
#define _BBSComments @"BBSComments"

#define kTabbarHeight 49
#define kNavbarHeight 64

#endif /* macro_h */
