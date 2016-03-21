//
//  XHChooseBirthController.m
//  IXueHao
//
//  Created by Mr. Feng on 9/16/15.
//  Copyright (c) 2015 XH. All rights reserved.
//

#import "XHChooseBirthController.h"

@interface XHChooseBirthController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *starLbl;
@property (nonatomic, assign) BOOL hasChanged;
@end

@implementation XHChooseBirthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.constraintWidth.constant = SCREEN_WIDTH;
    self.constraintHeight.constant = SCREEN_HEIGHT;
    self.hasChanged = NO;
}

- (void)setNav
{
    self.navigationItem.title = @"出生日期";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(completeChangeNewObject:)];
}

- (void)completeChangeNewObject:(id)sender
{
    if (_birthday.length < 1) {
        _birthday = @"19950101";
    }
    if ([self.delegate respondsToSelector:@selector(chooseBirthControllerWithBirthday:)]) {
        [self.delegate chooseBirthControllerWithBirthday:_birthday];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_birthday.length<8) return;
    NSString *age = [NSString ageWithBirth:_birthday];
    self.ageLbl.text = [NSString stringWithFormat:@"%@岁",age];
    NSInteger month = [[_birthday substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger day = [[_birthday substringWithRange:NSMakeRange(6, 2)] integerValue];
    self.starLbl.text = [self getAstroWithMonth:month day:day];
    
    NSString *dateStr = _birthday;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    self.datePicker.date = date;
}


- (IBAction)dateChanged:(id)sender {
    self.ageLbl.text = [self getAgeWith:self.datePicker.date];
    self.starLbl.text = [self getAstroWithDate:self.datePicker.date];
    [self getBirthdayWithData];
}

- (void)getBirthdayWithData
{
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyyMMdd"];
    NSString *date = [dateformate stringFromDate:self.datePicker.date];
    self.birthday = date;
}

- (NSString *)getAstroWithDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateDay = [components day];
    NSInteger brithDateMonth = [components month];
    return [self getAstroWithMonth:brithDateMonth day:brithDateDay];
}
//年龄
- (NSString *)getAgeWith:(NSDate*)birthday{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthday toDate:[NSDate  date] options:0];
    return [NSString stringWithFormat:@"%ld岁",(long)[components year]];
}
//星座
- (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
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
