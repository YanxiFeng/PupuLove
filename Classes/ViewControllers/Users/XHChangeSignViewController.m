//
//  XHChangeSignViewController.m
//  1.基本框架搭建
//
//  Created by Mr. Feng on 11/17/14.
//  Copyright (c) 2014 YN. All rights reserved.
//

#import "XHChangeSignViewController.h"

@interface XHChangeSignViewController ()

@property (nonatomic, strong) UITextView *opinionTextView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *countLbl;
@property (nonatomic, assign) NSInteger preLength;

@end

@implementation XHChangeSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexColor:@"#f5f5f5"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textHaveValue) name:UITextViewTextDidChangeNotification object:nil];
    //ui
    [self setupUIs];
    [self loadData];
    [self textHaveValue];
}

- (void)loadData
{
    _opinionTextView.text = _dataSource[_indexPath.section][_indexPath.row];

    if (_indexPath.section == 0) {
        switch (_indexPath.row) {
            case 1:
            {
                self.navigationItem.title = @"昵称";
                _label.text = @"这么好听的名字，我怎能不心动❤️";
                break;
            }
            case 4:
            {
                self.navigationItem.title = @"学校";
                _label.text = @"校园生活是最轻松的。";
                break;
            }
            case 5:
            {
                self.navigationItem.title = @"家乡";
                _label.text = @"你来自哪里呢？";
                break;
            }
                
            default:
                break;
        }
    }else if (_indexPath.section == 1){
        switch (_indexPath.row) {
            case 0:
            {
                self.navigationItem.title = @"个性签名";
                _label.text = @"编辑你的个性签名吧";
                break;
            }
            case 1:
            {
                self.navigationItem.title = @"兴趣爱好";
                _label.text = @"编辑的兴趣爱好吧";
                break;
            }
            default:
                break;
        }
    }else{
        self.navigationItem.title = @"联系方式";
        _label.text = @"留下你的微信号、微博号吧";
    }
}

- (void)commit
{
    NSString *text = self.opinionTextView.text;
    if (text.length>30) {
        text = [text substringToIndex:30];
    }
    if ([self.delegate respondsToSelector:@selector(changeWithSign:indexPath:)]) {
        [self.delegate changeWithSign:text indexPath:_indexPath];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textHaveValue
{
    NSString *str = _opinionTextView.text;
    NSInteger length = [self lengthChineseWith:_opinionTextView.text];
    NSInteger chLength = 0;
    NSString *temp = @"";
    for(int i=0; i< [str length];i++){
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *n = [NSString stringWithFormat:@"%@",s];
        temp = [temp stringByAppendingString:n];
        chLength = [self lengthChineseWith:temp];
        if (chLength>=30) {
            break;
        }
    }
    
    if (chLength>=30) {
        _countLbl.textColor = [UIColor colorWithHexColor:@"#ff3333"];
        _opinionTextView.text = temp;
        _countLbl.text = [NSString stringWithFormat:@"%d",0];
    }else{
        _countLbl.textColor = [UIColor colorWithHexColor:@"#c8c8c8"];
        _countLbl.text = [NSString stringWithFormat:@"%ld",(long)(30-length)];
    }
}

- (NSInteger)lengthChineseWith:(NSString *)str
{
    int chLength = 0;
    for(int i=0; i< [str length];i++){
        unichar a = [str characterAtIndex:i];
        if(((int)(a)>127)) chLength ++;
    }
    return chLength + ((str.length-chLength))/2;
}

- (void)setupUIs
{
    UIScrollView *scorllview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scorllview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 89)];
    container.backgroundColor = [UIColor colorWithHexColor:@"#ffffff"];
    [scorllview addSubview:container];
    
    for (int i=0; i<2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i*88.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHexColor:@"#c8c3c8"];
        [container addSubview:line];
    }
    
    _opinionTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, container.frame.size.height-20)];
    _opinionTextView.backgroundColor = [UIColor whiteColor];
    _opinionTextView.font = [UIFont systemFontOfSize:17];
    [_opinionTextView becomeFirstResponder];
    [container addSubview:_opinionTextView];
    
    _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, container.frame.size.height-30, 20, 20)];
    _countLbl.font = PPFONT(14);
    _countLbl.textColor = [UIColor colorWithHexColor:@"#c8c8c8"];
    [container addSubview:_countLbl];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(container.frame)+10, 260, 18)];
    self.label = label;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = RGB(150, 150, 150);
    label.font = PPFONT(14);
    [scorllview addSubview:label];
    
    [self.view addSubview:scorllview];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
