//
//  FPTextViewInputVC.m
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/3/1.
//  Copyright © 2020 FPJack. All rights reserved.
//

#import "FPTextViewInputVC.h"
@interface FPTextViewInputVC ()<HPGrowingTextViewDelegate>
@property (nonatomic,strong,readwrite)HPGrowingTextView *textView;
@property (nonatomic,strong,readwrite)UIButton *sendBtn;
@property (nonatomic,strong,readwrite)UIView *bottomView;
@property (nonatomic,copy,nullable)void (^sendBlock)(NSString *text);
@property (nonatomic,copy)BOOL(^shouldChangeTextBlock)(NSString *text,HPGrowingTextView *textView);
@end
@implementation FPTextViewInputVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,UIScreen.mainScreen.bounds.size.height, [UIScreen mainScreen].bounds.size.width,54)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 8, 30, 40);
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendBtn setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    }
    return _sendBtn;
}
- (HPGrowingTextView *)textView{
    if (!_textView) {
        _textView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 15 * 3 - 30, 34.0)];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.minHeight = 34;
        _textView.placeholder = @"请输入";
        _textView.maxNumberOfLines = 5;
        _textView.backgroundColor = [UIColor orangeColor];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 17;
        _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _textView.layer.masksToBounds = YES;
        _textView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _textView.returnKeyType = UIReturnKeySend;
    }
    return _textView;
}
- (void)sendAction {
    if (self.sendBlock) {
          self.sendBlock(self.textView.text);
      }
    [self dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    tapBtn.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:tapBtn];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.textView];
    [self.bottomView addSubview:self.sendBtn];

    //键盘弹出
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *userInfo = note.userInfo;
        CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat bHeight = self.bottomView.frame.size.height;
        [UIView animateWithDuration:0.4 animations:^{
            self.bottomView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - bHeight - frame.size.height, frame.size.width,bHeight);
        }];
    }];
    //键盘收起
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [UIView animateWithDuration:0.4 animations:^{
            self.bottomView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, CGRectGetWidth(self.bottomView.frame),54);
        }];
    }];
    [self.textView becomeFirstResponder];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)textViewHeight:(CGFloat)height{
    self.textView.frame = CGRectMake(15, CGRectGetMinY(self.textView.frame), CGRectGetWidth(self.textView.frame), height);
    CGFloat maxY = CGRectGetMaxY(self.bottomView.frame);
    self.bottomView.frame = CGRectMake(0, maxY - height - 20, [UIScreen mainScreen].bounds.size.width, height + 20);
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height{
    if (height == CGRectGetHeight(self.textView.frame)) return
        [UIView animateWithDuration:0.1 animations:^{
            [self textViewHeight:height];
        }];
}
- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendAction];
        return NO;
    }
    if (self.shouldChangeTextBlock) {
        return self.shouldChangeTextBlock(text,growingTextView);
    }
    return YES;
}
+ (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock{
    FPTextViewInputVC *vc = [self inputVCText:text placholder:placholder block:callBlock];
    UIViewController *presentVC = [self.class topViewController];
    if (!presentVC) presentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [[self.class topViewController] presentViewController:vc animated:YES
                                               completion:nil];
    
}
+ (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock shouldChangeTextBlock:(BOOL(^)(NSString *text,HPGrowingTextView *textView))shouldChangeTextBlock{
    FPTextViewInputVC *vc = [self inputVCText:text placholder:placholder block:callBlock shouldChangeTextBlock:shouldChangeTextBlock];
    UIViewController *presentVC = [self.class topViewController];
    if (!presentVC) presentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [[self.class topViewController] presentViewController:vc animated:YES
                                               completion:nil];
    
}
+ (FPTextViewInputVC*)inputVCText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock {
    FPTextViewInputVC *vc = [FPTextViewInputVC new];
    vc.sendBlock = callBlock;
    vc.textView.placeholder = placholder;
    vc.textView.text = text;
    return vc;
}
+ (FPTextViewInputVC*)inputVCText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock shouldChangeTextBlock:(BOOL(^)(NSString *text,HPGrowingTextView *textView))shouldChangeTextBlock{
    FPTextViewInputVC *vc = [FPTextViewInputVC new];
    vc.shouldChangeTextBlock = shouldChangeTextBlock;
    vc.sendBlock = callBlock;
    vc.textView.placeholder = placholder;
    vc.textView.text = text;
    return vc;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
+(UIViewController*)topViewController
{
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    return [self topViewController:window.rootViewController];
}
+(UIViewController*)topViewController:(UIViewController*)root
{
    //check to see if there is a view controller presented on top
    if(root.presentedViewController != nil)
    {
        return [self topViewController:root.presentedViewController];
    }
    //check to see if this is a tab controller
    if([root isKindOfClass:[UITabBarController class]])
    {
        UITabBarController * tab = (UITabBarController*)root;
        return [self topViewController:tab.selectedViewController];
    }
    //check to see if this is a nav controller
    if([root isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * nav = (UINavigationController*)root;
        return [self topViewController:nav.topViewController];
    }
    //otherwise, this is the root VC.
    return root;
}
@end
