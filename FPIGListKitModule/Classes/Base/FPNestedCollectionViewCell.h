//
//  FPNestedCollectionViewCell.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//

#import <UIKit/UIKit.h>
#import "FPIGListKitModule.h"

NS_ASSUME_NONNULL_BEGIN
@interface FPNestedCollectionViewCell : UICollectionViewCell<FPCollectionViewProtocal>
@property (nonatomic,copy)void(^tapCellBlock)(FPNestedCollectionViewCell *cell);
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSLayoutConstraint *leading;
@property (nonatomic,strong)NSLayoutConstraint *trailing;
@property (nonatomic,strong)NSLayoutConstraint *top;
@property (nonatomic,strong)NSLayoutConstraint *bottom;
@end
NS_ASSUME_NONNULL_END


//cell自带adapter 使用与一个SectionController 有多个itemCell时且cell又需配合SectionControllers才能使用
NS_ASSUME_NONNULL_BEGIN
@interface FPNestedAdapterCollectionViewCell : FPNestedCollectionViewCell<FPAdapterProtocal,IGListAdapterDataSource>
@property (nonatomic,weak)UIViewController *VC;
@property (nonatomic,assign)NSInteger workRange;
@property (nonatomic,weak)NSArray <id<FPBaseSectionModelProtocal>> *datas;
@property (nonatomic,strong)IGListAdapter *adapter;
@end
NS_ASSUME_NONNULL_END




NS_ASSUME_NONNULL_BEGIN
@interface FPBtnCollectionCell : UICollectionViewCell
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,copy)void (^tapBlock)(UIButton *button);
@property (nonatomic,strong)NSLayoutConstraint *leftCon;
@property (nonatomic,strong)NSLayoutConstraint *rightCon;
@property (nonatomic,strong)NSLayoutConstraint *bottomCon;
@property (nonatomic,strong)NSLayoutConstraint *topCon;
@end
NS_ASSUME_NONNULL_END





NS_ASSUME_NONNULL_BEGIN
@interface FPTextCollectionCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)NSLayoutConstraint *leftCon;
@property (nonatomic,strong)NSLayoutConstraint *rightCon;
@property (nonatomic,strong)NSLayoutConstraint *bottomCon;
@property (nonatomic,strong)NSLayoutConstraint *topCon;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface FPCollectionReusableView : UICollectionReusableView
@property (strong, nonatomic)NSLayoutConstraint *labelLeftCon;
@property (strong, nonatomic)NSLayoutConstraint *buttonRightCon;

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,copy)void (^buttonTapBlock)(UIButton *button);
@end
NS_ASSUME_NONNULL_END





NS_ASSUME_NONNULL_BEGIN
@interface FPUserInfoCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIImageView *tagImgView;
@property (nonatomic,copy)void (^rightButtonTapBlock)(UIButton *button);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewLeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewWidthCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label1LeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtonRightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label2BottomCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label1TopCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagImgViewLeftCon;
+ (NSBundle*)userInfoCollectionCellBundle;
@end
NS_ASSUME_NONNULL_END
