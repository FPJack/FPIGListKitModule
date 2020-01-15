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
@property (nonatomic,copy,nullable)void (^sendBlock)(NSString *text);
+ (instancetype)share;
- (void)show;
- (void)showText:(nullable NSString *)text placholder:(nullable NSString*)placholder block:(void(^)(NSString *text))callBlock;
- (void)dismiss;


@end

NS_ASSUME_NONNULL_END
