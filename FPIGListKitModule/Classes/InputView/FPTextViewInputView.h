//
//  FPTextViewInputView.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/11.
//

#import <UIKit/UIKit.h>
#import <HPGrowingTextView/HPGrowingTextView.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPTextViewInputView : UIView<HPGrowingTextViewDelegate>
@property (nonatomic,strong,readonly)HPGrowingTextView *textView;
@property (nonatomic,copy,nullable)void (^sendBlock)(NSString *text);
+ (instancetype)share;
- (void)show;
- (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock;
- (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock shouldChangeTextBlock:(BOOL(^)(NSString *replaceText,HPGrowingTextView *textView))shouldBeginEditingBlock;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
