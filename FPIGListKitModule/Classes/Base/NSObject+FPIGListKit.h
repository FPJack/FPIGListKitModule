//
//  NSObject+FPIGListKit.h
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/2/7.
//  Copyright © 2020 FPJack. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
@protocol FPBaseSectionModelProtocal;
NS_ASSUME_NONNULL_BEGIN
@protocol FPIGListKitProtocal <NSObject>
@required
- (UIViewController*)igAdapterVC;
@optional
- (NSInteger)igWorkingRangeSize;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (FPIGListKit)<FPIGListKitProtocal,IGListAdapterDataSource>
@property (nonatomic,strong)IGListAdapter *IGAdapter;
@property (strong, nonatomic)UICollectionView *IGCollectionView;
@property (nonatomic,strong)NSMutableArray<FPBaseSectionModelProtocal> *IGDatas;
@end
NS_ASSUME_NONNULL_END
