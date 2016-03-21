//
//  XHChooseBirthController.h
//  IXueHao
//
//  Created by Mr. Feng on 9/16/15.
//  Copyright (c) 2015 XH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHChooseBirthControllerDelegate <NSObject>
- (void)chooseBirthControllerWithBirthday:(NSString *)birthday;
@end

@interface XHChooseBirthController : UIViewController
- (IBAction)dateChanged:(id)sender;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, weak) id<XHChooseBirthControllerDelegate> delegate;
@end
