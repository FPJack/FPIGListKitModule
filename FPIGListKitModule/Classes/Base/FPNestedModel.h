//
//  FPBaseSectionModel.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/4.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "FPModuleProtocoal.h"



NS_ASSUME_NONNULL_BEGIN
@interface FPBaseSectionModel : NSObject<FPSectionModelProtocal>
@property(nonatomic,copy)NSString *diffId;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;

@property (nonatomic,assign)UIEdgeInsets sectionInset;

@property (nonatomic,strong)id<FPConfigureReusableSupplementaryProtocal> header;
@property (nonatomic,strong)id<FPConfigureReusableSupplementaryProtocal> footer;


//生成sectionController
@property (nonatomic,strong)IGListSectionController *sectionController;
@property (nonatomic,copy)IGListSectionController* (^sectionControllerBlock)(id<FPSectionModelProtocal> model);

@property (nonatomic,copy)UICollectionViewCell  *(^dequeueReusableCellBlock)(id model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);

@property (nonatomic,strong)id strongObject;//备用
@property (nonatomic,weak)id weakObject;//备用
@end
NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN
@interface FPSingleSectionModel : FPBaseSectionModel
@property (nonatomic,strong)Class class_name;
@property (nonatomic,copy)NSString* nibName;
@property (nonatomic,strong)NSBundle *bundle;
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface FPDequeueReusableModel : NSObject<FPConfigureReusableCellProtocal,FPConfigureReusableSupplementaryProtocal>
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,strong)Class class_name;
@property (nonatomic,copy)NSString* nibName;
@property (nonatomic,strong)NSBundle *bundle;
@property (nonatomic,copy)UICollectionViewCell  *(^dequeueReusableCellBlock)(id model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@property (nonatomic,copy)UICollectionReusableView  *(^dequeueReusableSupplementaryBlock)(NSString *elementKind,id model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface FPNestedModel : FPBaseSectionModel<FPNestedSectionModelProtocal>
@property (nonatomic,assign)NSInteger workingRangeSize;
@property (nonatomic,assign)UIEdgeInsets collectionViewContentInset;
@property (nonatomic,strong)NSMutableArray <id<FPSectionModelProtocal>> *nestedCellItems;
@property (nonatomic,copy)UICollectionViewCell<FPCollectionViewProtocal>  *(^dequeueReusableCellBlock)(id<FPSectionModelProtocal> model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@end
NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN
@interface FPUserModel : FPSingleSectionModel
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *rightBtnImageName;
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,strong)UIImage *placeholderImage;
@property(nonatomic,copy)NSString *userName;
@end
NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN
@interface FPTextModel : FPSingleSectionModel
@property(nonatomic,copy)NSString *content;
@property (nonatomic,assign)int numberOfLines;
@property (nonatomic,strong)UIFont *font;
@end
NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN
@interface FPNumberItemModel : FPBaseSectionModel<FPNumberOfItemSectionModelProtocal>
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic,strong)NSMutableArray <id<FPConfigureReusableCellProtocal>> *cellItems;
@end
NS_ASSUME_NONNULL_END
