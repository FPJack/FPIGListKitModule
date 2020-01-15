//
//  FPCommentSubProtocal.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/4.
//

#import <Foundation/Foundation.h>
#import "FPModuleProtocoal.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FPHyperlinkProtocal <NSObject>
@property(nonatomic,assign)NSRange range;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,assign)BOOL enableTap;
@property(nonatomic,strong)NSDictionary* configure;
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@protocol FPCommentSubProtocal <FPSingleSectionModelProtocal>
@required
@property (nonatomic,strong)UIFont *textFont;
@optional
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,copy)NSString *commentUserId;
@property(nonatomic,copy)NSString *commentUserName;
@property(nonatomic,copy)NSString *commentByUserId;
@property(nonatomic,copy)NSString *commentByUserName;
@property(nonatomic,copy)NSString *commentText;
@property (nonatomic,strong)NSAttributedString *attrText;
@property (nonatomic,strong)NSArray <id<FPHyperlinkProtocal>> *links;
@end
NS_ASSUME_NONNULL_END


