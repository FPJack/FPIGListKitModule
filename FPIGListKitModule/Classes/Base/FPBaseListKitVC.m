//
//  FPModuleBaseVC.m
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/1/15.
//  Copyright © 2020 FPJack. All rights reserved.
//

#import "FPBaseListKitVC.h"
#import <FPIGListKitModule.h>
@interface FPBaseListKitVC ()
@end
@implementation FPBaseListKitVC
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    return _collectionView;
}
- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
        _adapter.dataSource = self;
    }
    return _adapter;
}
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.datas;
}
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id<FPBaseSectionModelProtocal>)object{
    if ([object respondsToSelector:@selector(sectionController)] && object.sectionController) {
        return object.sectionController;
    }else if([object respondsToSelector:@selector(sectionControllerBlock)]){
        return object.sectionControllerBlock(object);
    }
    return nil;
}
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}
@end


@implementation FPBaseListKitView
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    return _collectionView;
}
- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:self.VC workingRangeSize:0];
        _adapter.dataSource = self;
    }
    return _adapter;
}
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI{
    [self addSubview:self.collectionView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.datas;
}
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id<FPBaseSectionModelProtocal>)object{
    if ([object respondsToSelector:@selector(sectionController)] && object.sectionController) {
        return object.sectionController;
    }else if(object respondsToSelector:@selector(sectionControllerBlock)){
        return object.sectionControllerBlock(object);
    }
    return nil;
}
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

@end
