//
//  FPTestVC.m
//  FPCommentsModule_Example
//
//  Created by fanpeng on 2020/1/9.
//  Copyright © 2020 FPJack. All rights reserved.
//
#define kSWidth [UIScreen mainScreen].bounds.size.width

#import "FPTestVC.h"
#import <IGListKit/IGListKit.h>
#import <FPIGListKitModule.h>
@interface FPTestVC ()<IGListAdapterDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)IGListAdapter *adapter;
@property (nonatomic,strong)NSMutableArray <id<FPNumberOfItemSectionModelProtocal>> *datas;
@end
@implementation FPTestVC
- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
        _adapter.dataSource = self;
    }
    return _adapter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.adapter.collectionView = self.collectionView;
    NSMutableArray *datas = [NSMutableArray array];
    CGFloat space  = 10;
    for (int i = 0 ; i < 5; i++ ) {
        FPNumberItemModel *model = [FPNumberItemModel new];
        model.minimumLineSpacing = space;
        model.minimumInteritemSpacing = space;
        model.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        model.dequeueReusableCellBlock = ^UICollectionViewCell * _Nonnull(id  _Nonnull model, IGListSectionController * _Nonnull sectionController, id<IGListCollectionContext>  _Nonnull collectionContext, NSInteger index) {
            UICollectionViewCell *cell = [collectionContext dequeueReusableCellOfClass:[UICollectionViewCell class] forSectionController:sectionController atIndex:index];
            cell.backgroundColor = [UIColor redColor];
            return cell;
        };
        {
            FPDequeueReusableModel *rModel = [FPDequeueReusableModel new];
            rModel.class_name = [FPCollectionReusableView class];
            rModel.height = 30;
            rModel.dequeueReusableSupplementaryBlock = ^UICollectionReusableView * _Nonnull(NSString * _Nonnull elementKind, id  _Nonnull model, IGListSectionController * _Nonnull sectionController, id<IGListCollectionContext>  _Nonnull collectionContext, NSInteger index) {
                FPCollectionReusableView *view = [collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:sectionController class:[FPCollectionReusableView class] atIndex:index];
                view.backgroundColor = [UIColor grayColor];
                return view;
            };
            model.footer = rModel;
        }

        FPNumberOfItemsSectionController *sectionController = [FPNumberOfItemsSectionController new];
        sectionController.configureSupplementaryViewBlock = ^(id  _Nullable item, __kindof FPCollectionReusableView * _Nullable cell, IGListSectionController * _Nullable sectionController) {
            cell.label.text = @"ddd";
            [cell.button setTitle:@"dddd" forState:UIControlStateNormal];
        };
        model.sectionController = sectionController;
        CGFloat width = (kSWidth - 10 * 5)/6;
        NSMutableArray *items = [NSMutableArray array];
        for (int j = 0 ; j < 10 ; j ++ ) {
            FPDequeueReusableModel *subItem = [FPDequeueReusableModel new];
            subItem.class_name = [UICollectionViewCell class];
            subItem.width = width;
            subItem.height = width;

            [items addObject:subItem];
        }
        model.cellItems = items;
        [datas addObject:model];
    }
    self.datas = datas;
    [self.adapter performUpdatesAnimated:YES completion:nil];
}
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.datas;
}
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id<FPNumberOfItemSectionModelProtocal>)object{
    return object.sectionController;
}
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    
    return nil;
}
@end
