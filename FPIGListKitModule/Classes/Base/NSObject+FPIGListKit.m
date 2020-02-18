//
//  NSObject+FPIGListKit.m
//  FPIGListKitModule_Example
//
//  Created by fanpeng on 2020/2/7.
//  Copyright © 2020 FPJack. All rights reserved.
//

#import "NSObject+FPIGListKit.h"
#import <objc/runtime.h>
#import <FPIGListKitModule.h>
@implementation NSObject (FPIGListKit)
static const char FPIGListAdapter = '\0';
- (void)setIGCollectionView:(UICollectionView *)IGCollectionView{
    objc_setAssociatedObject(self, &FPIGListAdapter,
                             IGCollectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UICollectionView *)IGCollectionView{
    UICollectionView *collectionView =  objc_getAssociatedObject(self, &FPIGListAdapter);
    if (!collectionView) {
        collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
        self.IGCollectionView = collectionView;
    }
    return collectionView;
}
static const char FPIGAdapter = '\0';
- (void)setIGAdapter:(IGListAdapter *)IGAdapter{
    objc_setAssociatedObject(self, &FPIGAdapter,
                             IGAdapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (IGListAdapter *)IGAdapter{
    IGListAdapter *adapter =  objc_getAssociatedObject(self, &FPIGAdapter);
    if (!adapter) {
        adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:[self igAdapterVC] workingRangeSize:[self igWorkingRangeSize]];
        adapter.dataSource = self;
        self.IGAdapter = adapter;
    }
    return adapter;
}
static const char FPIGDatas = '\0';
- (void)setIGDatas:(NSMutableArray *)IGDatas{
    objc_setAssociatedObject(self, &FPIGDatas,
                             IGDatas, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)IGDatas{
    NSMutableArray *datas =  objc_getAssociatedObject(self, &FPIGDatas);
      if (!datas) {
          datas = [NSMutableArray array];
          self.IGDatas = datas;
      }
      return datas;
}
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.IGDatas;
}
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id<FPBaseSectionModelProtocal>)object{
    if ([object respondsToSelector:@selector(sectionController)] && object.sectionController) {
        return object.sectionController;
    }else if([object respondsToSelector:@selector(sectionControllerBlock)]){
        return object.sectionControllerBlock(object);
    }
    return nil;
}
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{return nil;}
- (UIViewController *)igAdapterVC{return nil;}
- (NSInteger)igWorkingRangeSize{return 0;}
@end
