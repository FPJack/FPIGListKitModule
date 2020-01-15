//
//  FPCommentSubCell.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/4.
//

#import <UIKit/UIKit.h>
#import "FPCommentSubProtocal.h"
@class TTTAttributedLabel;
NS_ASSUME_NONNULL_BEGIN
@interface FPCommentSubCell : UICollectionViewCell
@property (strong, nonatomic)TTTAttributedLabel *commentLab;
@property (nonatomic,strong)id <FPCommentSubProtocal> model;
@property (nonatomic,strong)void (^tapLinkBlock)(id<FPHyperlinkProtocal> link);
@end
NS_ASSUME_NONNULL_END
