//
//  FPNestedCollectionViewCell.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
@interface FPNestedCollectionViewCell : UICollectionViewCell
@property (nonatomic, readonly)UICollectionView *collectionView;
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
@property (nonatomic,copy)void (^rightButtonTapBlock)(UIButton *button);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewLeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewWidthCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label1LeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtonRightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label2BottomCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label1TopCon;
+ (NSBundle*)userInfoCollectionCellBundle;
@end
NS_ASSUME_NONNULL_END
