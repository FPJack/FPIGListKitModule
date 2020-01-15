//
//  FPModuleBaseVC.h
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/1/15.
//  Copyright © 2020 FPJack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface FPBaseListKitVC : UIViewController
@property (nonatomic,strong)IGListAdapter *adapter;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *datas;
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface FPBaseListKitView : UIView
@property (nonatomic,strong)IGListAdapter *adapter;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *datas;
@end
NS_ASSUME_NONNULL_END
