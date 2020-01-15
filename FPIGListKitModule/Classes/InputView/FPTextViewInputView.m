//
//  FPTextViewInputView.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/11.
//

#import "FPTextViewInputView.h"
static FPTextViewInputView *instance;
static UIView *maskView;
@interface FPTextViewInputView()
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)HPGrowingTextView *textView;
@property (nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UIView *lineView;

@end

@implementation FPTextViewInputView

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 42)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 8, 30, 40);
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
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
        _textView.internalTextView.inputAccessoryView = self;
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
+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        instance = [[FPTextViewInputView alloc]init];
        instance.frame = [UIScreen mainScreen].bounds;
        UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [dismissBtn addTarget:instance action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [instance addSubview:dismissBtn];
        [instance setSubView];
        [maskView addSubview:instance];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidHideNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            if (maskView.superview) {
                [maskView removeFromSuperview];
                maskView.alpha = 1;
            };
        }];
    });
    return instance;
}
- (void)setSubView{
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1)];
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:instance.lineView];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.sendBtn];
    [self textViewHeight:self.textView.frame.size.height];
}
- (void)textViewHeight:(CGFloat)height{
    self.textView.frame = CGRectMake(15, CGRectGetMinY(self.textView.frame), CGRectGetWidth(self.textView.frame), height);
    self.bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height - 20, [UIScreen mainScreen].bounds.size.width, height + 20);
}
- (void)showText:(NSString*)text placholder:(NSString*)placholder block:(void(^)(NSString *text))callBlock{
    [self.bottomView addSubview:self.textView];
    self.sendBlock = callBlock;
    self.textView.placeholder = placholder;
    self.textView.text = text;
    [self show];
}
- (void)show{
    [[UIApplication sharedApplication].delegate.window addSubview:maskView];
    [maskView addSubview:self];
    [self.textView becomeFirstResponder];
}
- (void)dismiss{
    [self.textView resignFirstResponder];
    maskView.alpha = 0;
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height{
    if (height == CGRectGetHeight(self.textView.frame)) return
        [UIView animateWithDuration:0.1 animations:^{
            [self textViewHeight:height];
        }];
}
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView{
    [self sendAction];
    return YES;
}
- (void)sendAction {
    [self dismiss];
    if (self.sendBlock) {
        self.sendBlock(self.textView.text);
        self.textView.text = nil;
    }
}

@end
