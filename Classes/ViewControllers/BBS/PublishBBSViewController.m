//
//  PublishBBSViewController.m
//  LeCao
//
//  Created by Mr. Feng on 3/6/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "PublishBBSViewController.h"
#import "UIImage+Resize.h"
#import "BBSImageVC.h"
#import "PPAccountTool.h"
#import <QiniuSDK.h>

@interface PublishBBSViewController ()<UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIScrollView    *_scrollView;
    
    UITextField     *_titleField;
    UITextView      *_textView;
    UIView          *_toolView; //照相机 需要上传的图片 字数
}

@property (nonatomic, copy) NSString *imageUrl;

@end

@implementation PublishBBSViewController

- (id)init{
    if (self = [super init])
    {
        _imageArray = [[NSMutableArray alloc] init];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark --lifesycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Backgroud_color;
    self.navigationItem.title = @"发表主题";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(publishButtonPressed:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}
                                                          forState:UIControlStateNormal];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.clipsToBounds = NO;
    [self.view addSubview:_scrollView];
    
    
    _titleField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-5*2, 40)];
    _titleField.placeholder = @"标题(可选)";
    _titleField.delegate = self;
    _titleField.font = [UIFont systemFontOfSize:14];
    _titleField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _titleField.returnKeyType = UIReturnKeyNext;
    [_scrollView addSubview:_titleField];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleField.frame), SCREEN_WIDTH, 1)];
    line.backgroundColor = RGB(220, 220, 220);
    [_scrollView addSubview:line];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleField.frame) + 2, SCREEN_WIDTH, _scrollView.frame.size.height - CGRectGetMaxY(_titleField.frame) - 2 - 60)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = RGB(150, 150, 150);
    _textView.font = [UIFont systemFontOfSize:14];
    
    [_scrollView addSubview:_textView];
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 20 - 44 - 35, SCREEN_WIDTH, 35)];
    _toolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolView];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.tag = -20;
    [cameraBtn setImage:[UIImage imageNamed:@"chuanzhaopian.png"] forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(10, 0, 30, 30);
    [cameraBtn addTarget:self action:@selector(showImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:cameraBtn];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_titleField resignFirstResponder];
    //[_textView resignFirstResponder];
}


#pragma mark - keybordWillShow

- (void)keyboardWillChange:(NSNotification *)notification{
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = CGSizeMake(0, 0);
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) { //显示键盘
        kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    }
    
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _scrollView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, self.view.frame.size.height - kbSize.height );
        _textView.frame = CGRectMake(0, CGRectGetMaxY(_titleField.frame) + 2, SCREEN_WIDTH, _scrollView.frame.size.height - CGRectGetMaxY(_titleField.frame) - 2 - 40);
        
        if (_scrollView.contentSize.height > _scrollView.frame.size.height) {
            [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentSize.height - _scrollView.frame.size.height) animated:YES];
        }
        _toolView.frame = CGRectMake(_toolView.frame.origin.x, self.view.frame.size.height - _toolView.frame.size.height - kbSize.height, _toolView.frame.size.width, _toolView.frame.size.height);
    }];
}

#pragma mark - support method
- (void)showImagePickerController{
    [_titleField resignFirstResponder];
    [_textView resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self takeImageFromCamera];
    }
    else if (buttonIndex == 1)
    {
        [self takeImageFromPhotoLibrary];
    }
}

- (void)showImageView:(UIButton*)button{
    BBSImageVC *vc = [[BBSImageVC alloc] init];
    vc.imageSourceVC = self;
    vc.image = [button imageForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reSetToolsView{
    UIView *imageViews = [_toolView viewWithTag:-10];
    if (!imageViews) {
        imageViews = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 40 * 5 - 10, 30)];
        imageViews.tag = -10;
        [_toolView addSubview:imageViews];
    }
    
    for (UIView *view in imageViews.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < _imageArray.count; i ++) {
        UIImage *image = [_imageArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.tag = 100 +i;
        button.frame = CGRectMake(i * 40, 0, 30, 30);
        [button addTarget:self action:@selector(showImageView:) forControlEvents:UIControlEventTouchUpInside];
        [imageViews addSubview:button];
    }
    
    UIButton *cameraBtn = (UIButton *)[_toolView viewWithTag:-20];
    if (_imageArray.count == 5) {
        cameraBtn.enabled = NO;
    }
    else {
        cameraBtn.enabled = YES;
    }
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textView  becomeFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger maxLength = 25;
    NSInteger length = textField.text.length + string.length - range.length;
    BOOL shouldChange = YES;
    if (length > maxLength) {
        NSInteger lastLength = maxLength + range.length - textField.text.length;
        if (lastLength > 0) {
            string = [string substringWithRange:NSMakeRange(0, lastLength)];
            
            NSMutableString *testString = [NSMutableString stringWithString:textField.text];
            [testString replaceCharactersInRange:range withString:string];
            textField.text = testString;
        }
        
        
        shouldChange = NO;
    }
    
    return shouldChange;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSInteger maxLength = 500;
    NSInteger length = textView.text.length + text.length - range.length;
    BOOL shouldChange = YES;
    if (length > maxLength) {
        NSInteger lastLength = maxLength + range.length - textView.text.length;
        if (lastLength > 0) {
            text = [text substringWithRange:NSMakeRange(0, lastLength)];
            
            NSMutableString *string = [NSMutableString stringWithString:textView.text];
            [string replaceCharactersInRange:range withString:text];
            textView.text = string;
        }
        
        
        shouldChange = NO;
    }
    
    return shouldChange;
}

#pragma mark - DDActionSheet method 启动照相机

- (void)takeImageFromPhotoLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController* pickController = [[UIImagePickerController alloc] init];
        pickController.delegate = self;
        pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备无法读取相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)takeImageFromCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* pickController = [[UIImagePickerController alloc] init];
        pickController.delegate = self;
        pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持拍照功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImage* newImage = nil;
    if (image.size.width > 640) { //所有的图片尺寸控制在640*960内
        CGSize size;
        size.width = 640;
        size.height = image.size.height * (size.width/image.size.width);
        newImage = [image resizedImage:size interpolationQuality:kCGInterpolationDefault];
    }
    else {
        newImage = image;
    }
    
    if (newImage.size.height > 960) {
        CGSize size;
        size.height = 960;
        size.width = newImage.size.width * (size.height/newImage.size.height);
        newImage = [newImage resizedImage:size interpolationQuality:kCGInterpolationDefault];
    }
    [_imageArray removeAllObjects];
    [_imageArray addObject:newImage];
    [self reSetToolsView];
    // upload image
    [self upLoadImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)upLoadImage
{
    NSString *token = QINIUTOKEN;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation([self.imageArray firstObject],0.5);
    NSString *imageURL = [NSString stringWithFormat:@"posterPhoto_uploader_%@.jpg",[NSString stringofCurrent]];
    [upManager putData:data key:imageURL token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", resp);
              } option:nil];
    self.imageUrl = [NSString stringWithFormat:@"http://jinshi2014.qiniudn.com/%@",imageURL];
}


#pragma mark - request & result

- (void)publishButtonPressed:(UIBarButtonItem *)item
{
    if ([_titleField canResignFirstResponder]) {
        [_titleField resignFirstResponder];
    }
    
    if ([_textView canResignFirstResponder]) {
        [_textView resignFirstResponder];
    }
    
    NSString *content = [_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (content.length == 0 && _imageArray.count == 0)
    {
        [MBProgressHUD showError:@"帖子没有内容"];
        return;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self saveBBSData];
    
}
- (void)saveBBSData
{
    UserInfoModel *user = [PPAccountTool getAccount];
    //保存帖子信息
    AVObject *av = [AVObject objectWithClassName:_BBS];
    [av setObject:user.username forKey:username];
    [av setObject:user.icon forKey:icon];
    [av setObject:user.nickname forKey:nickname];
    [av setObject:user.school forKey:school];
    //
    [av setObject:_titleField.text forKey:@"title"];
    [av setObject:_textView.text forKey:@"content"];
    [av setObject:_imageUrl forKey:@"image"];
    [av saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"发布成功"];
            if ([self.delegate respondsToSelector:@selector(publishBBSVCDelegateReloadBBS)]) {
                [self.delegate publishBBSVCDelegateReloadBBS];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            //保存失败
        }
    }];
}

@end
