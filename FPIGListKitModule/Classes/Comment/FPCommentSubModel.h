//
//  FPCommentSubModel.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/11.
//

#import <Foundation/Foundation.h>
#import <FPIGListKitModule.h>
#import <FPCommentSubProtocal.h>
NS_ASSUME_NONNULL_BEGIN
@interface FPHyperlinkModel : NSObject<FPHyperlinkProtocal>
@property(nonatomic,assign)NSRange range;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,assign)BOOL enableTap;
@property(nonatomic,strong)NSDictionary* configure;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface FPCommentSubModel : FPListKitSectionModel<FPCreateSectionControllerProtocal,FPCommentSubProtocal>
@property (nonatomic,strong)UIFont *textFont;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,copy)NSString *commentUserId;
@property(nonatomic,copy)NSString *commentUserName;
@property(nonatomic,copy)NSString *commentByUserId;
@property(nonatomic,copy)NSString *commentByUserName;
@property(nonatomic,copy)NSString *commentText;
@property (nonatomic,strong)NSAttributedString *attrText;
@property (nonatomic,strong)NSArray <id<FPHyperlinkProtocal>> *links;
+ (CGFloat)configureTTTAttributedLabelTextHeightText:(NSString*)text configure:(NSDictionary*)config width:(CGFloat)width numberOfLines:(int)numberOfLines;
@end

NS_ASSUME_NONNULL_END
