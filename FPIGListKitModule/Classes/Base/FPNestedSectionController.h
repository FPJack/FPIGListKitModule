//
//  FPNestedSectionController.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//

#import <IGListKit/IGListKit.h>
#import "FPModuleProtocoal.h"

NS_ASSUME_NONNULL_BEGIN
@interface FPBaseSectionController : IGListSectionController
<FPSectionControllerHelperProtocal>
@property (nonatomic,copy)FPConfigureSectionCellBlock configureCellBlock;
@property (nonatomic,copy)FPConfigureSupplementaryViewBlock configureSupplementaryViewBlock;
@property (nonatomic,copy)void (^didSelectItemBlock)(IGListSectionController *sectionController,id model,NSIndexPath *indexPath);
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface FPNestedSectionController : FPBaseSectionController
@property (nonatomic,readonly)IGListAdapter *adapter;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface FPSingleSectionController : FPBaseSectionController
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface FPNumberOfItemsSectionController : FPBaseSectionController
@end
NS_ASSUME_NONNULL_END
