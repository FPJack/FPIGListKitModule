//
//  FPModuleProtocoal.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/4.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
typedef void (^FPConfigureSectionCellBlock)(id __nullable item, __kindof UICollectionViewCell * __nullable cell,IGListSectionController * __nullable sectionController);
typedef void (^FPConfigureSupplementaryViewBlock)(id __nullable item, __kindof UICollectionReusableView * __nullable cell,IGListSectionController * __nullable sectionController);
@protocol FPSubSectionModelsProtocal;
@protocol FPSectionModelProtocal;

//
NS_ASSUME_NONNULL_BEGIN
@protocol FPCollectionViewProtocal <NSObject>
@property (nonatomic,strong)UICollectionView *collectionView;
@end
NS_ASSUME_NONNULL_END

//SectionController生成器
NS_ASSUME_NONNULL_BEGIN
@protocol FPCreateSectionControllerProtocal <NSObject>
@optional
#warning 必须实现一个
//建议初始化的时候直接赋值 后续通过模型可以直接拿该对象
@property (nonatomic,strong)IGListSectionController *sectionController;

//懒加载初始化没有做属性保存 没掉用一次生成一个新的sectionController对象 后续通过模型拿不到同一个对象
@property (nonatomic,copy)IGListSectionController* (^sectionControllerBlock)(id<FPSectionModelProtocal> model);
@end
NS_ASSUME_NONNULL_END

//配置cell
NS_ASSUME_NONNULL_BEGIN
@protocol FPSectionControllerHelperProtocal <NSObject>
@optional
@property (nonatomic,strong)FPConfigureSectionCellBlock configureCellBlock;
@property (nonatomic,strong)FPConfigureSupplementaryViewBlock configureSupplementaryViewBlock;
@property (nonatomic,copy)void (^didSelectItemBlock)(IGListSectionController *sectionController,id model,NSInteger index);
@end
NS_ASSUME_NONNULL_END


//每个itemSize
NS_ASSUME_NONNULL_BEGIN
@protocol FPWidthHeightProtocal  <NSObject>
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;
@end
NS_ASSUME_NONNULL_END

//load cell or supplementaryView
NS_ASSUME_NONNULL_BEGIN
@protocol FPLoadReusableViewProtocal <NSObject>
@optional
@property (nonatomic,strong)Class class_name;
@property (nonatomic,copy)NSString* nibName;
@property (nonatomic,strong)NSBundle* bundle;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@protocol FPLoadReusableCellBlockProtocal <NSObject>
@optional
@property (nonatomic,copy)UICollectionViewCell  *(^dequeueReusableCellBlock)(id model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@protocol FPLoadReusableSupplementaryBlockProtocal <NSObject>
@optional
@property (nonatomic,copy)UICollectionReusableView  *(^dequeueReusableSupplementaryBlock)(NSString *elementKind,id model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@end
NS_ASSUME_NONNULL_END




//load Cell protocal
NS_ASSUME_NONNULL_BEGIN
@protocol FPConfigureReusableCellProtocal <FPLoadReusableViewProtocal,FPWidthHeightProtocal,FPLoadReusableCellBlockProtocal>
@end
NS_ASSUME_NONNULL_END


//load supplementaryView protocal
NS_ASSUME_NONNULL_BEGIN
@protocol FPConfigureReusableSupplementaryProtocal <FPLoadReusableViewProtocal,FPWidthHeightProtocal,FPLoadReusableSupplementaryBlockProtocal>
@end
NS_ASSUME_NONNULL_END




//配置SectionController宽高 SectionInset
NS_ASSUME_NONNULL_BEGIN
@protocol FPSectionModelProtocal <IGListDiffable,FPWidthHeightProtocal,FPCreateSectionControllerProtocal,FPLoadReusableCellBlockProtocal>
@required
@property(nonatomic,copy)NSString *diffId;
@optional
@property (nonatomic,strong)id<FPConfigureReusableSupplementaryProtocal> header;
@property (nonatomic,strong)id<FPConfigureReusableSupplementaryProtocal> footer;
@property (nonatomic,assign)UIEdgeInsets sectionInset;
@end
NS_ASSUME_NONNULL_END
// 一个section一个cellItem
NS_ASSUME_NONNULL_BEGIN
@protocol FPSingleSectionModelProtocal <FPSectionModelProtocal,FPLoadReusableViewProtocal>
@end
NS_ASSUME_NONNULL_END



//一个section嵌套多个section  场景cell上面放一个UICollectionView
NS_ASSUME_NONNULL_BEGIN
@protocol FPNestedSectionModelProtocal <FPSectionModelProtocal,FPLoadReusableCellBlockProtocal>
@optional
@property (nonatomic,assign)NSInteger workingRangeSize;
@property (nonatomic,assign)UIEdgeInsets collectionViewContentInset;
@property (nonatomic,strong)NSMutableArray <id<FPSectionModelProtocal>> *nestedCellItems;
@property (nonatomic,copy)UICollectionViewCell<FPCollectionViewProtocal>  *(^dequeueReusableCellBlock)(id<FPSectionModelProtocal> model,IGListSectionController *sectionController,id<IGListCollectionContext> collectionContext,NSInteger index);
@end
NS_ASSUME_NONNULL_END


//一个section多个cellItem基类
NS_ASSUME_NONNULL_BEGIN
@protocol FPNumberOfItemSectionModelProtocal <FPSectionModelProtocal,FPWidthHeightProtocal,FPLoadReusableCellBlockProtocal>
@optional
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic,strong)NSMutableArray <id<FPConfigureReusableCellProtocal>> *cellItems;
@end
NS_ASSUME_NONNULL_END
