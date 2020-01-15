//
//  FPCommentSubSectionController.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/6.
//

#import <IGListKit/IGListKit.h>
#import "FPCommentSubProtocal.h"
@protocol FPHyperlinkProtocal;
NS_ASSUME_NONNULL_BEGIN

@interface FPCommentSubSectionController : IGListSectionController
@property (nonatomic,copy)void (^tapLinkBlock)(FPCommentSubSectionController *sectionController,id<FPCommentSubProtocal> commentModel,id<FPHyperlinkProtocal>  _Nonnull link);
@property (nonatomic,copy)void (^didSelectItemBlock)(IGListSectionController *sectionController,id<FPSectionModelProtocal> model,NSInteger index);

@end

NS_ASSUME_NONNULL_END
