//
//  FPTextViewInputVC.h
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/3/1.
//  Copyright © 2020 FPJack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HPGrowingTextView/HPGrowingTextView.h>
NS_ASSUME_NONNULL_BEGIN
@interface FPTextViewInputVC : UIViewController
@property (nonatomic,strong,readonly)HPGrowingTextView *textView;
@property (nonatomic,strong,readonly)UIButton *sendBtn;
@property (nonatomic,strong,readonly)UIView *bottomView;

+ (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock;
+ (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock shouldChangeTextBlock:(BOOL(^)(NSString *text,HPGrowingTextView *textView))shouldChangeTextBlock;

+ (FPTextViewInputVC*)inputVCText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock;
+ (FPTextViewInputVC*)inputVCText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock shouldChangeTextBlock:(BOOL(^)(NSString *text,HPGrowingTextView *textView))shouldChangeTextBlock;
@end

NS_ASSUME_NONNULL_END
