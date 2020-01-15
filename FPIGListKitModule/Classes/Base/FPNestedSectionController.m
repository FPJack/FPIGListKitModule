//
//  FPNestedSectionController.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//

#import "FPNestedSectionController.h"
#import "FPNestedCollectionViewCell.h"
@interface FPBaseSectionController()<IGListSupplementaryViewSource>
@property (nonatomic,strong)id<FPSectionModelProtocal> model;
@end
@implementation FPBaseSectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.supplementaryViewSource = self;
    }
    return self;
}
#pragma supplementaryViewSource
- (NSArray<NSString *> *)supportedElementKinds{
    NSMutableArray *elementKinds = [NSMutableArray array];
    if ([self.model respondsToSelector:@selector(header)] && self.model.header) {
        [elementKinds addObject: UICollectionElementKindSectionHeader];
    }
    if ([self.model respondsToSelector:@selector(footer)] && self.model.footer) {
        [elementKinds addObject: UICollectionElementKindSectionFooter];
    }
    return elementKinds;
}
- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index{
    id<FPConfigureReusableSupplementaryProtocal> model = [elementKind isEqualToString:UICollectionElementKindSectionHeader] ? self.model.header : self.model.footer;
    UICollectionReusableView *supplementaryView = [self viewForSupplementaryElementOfKind:elementKind atIndex:index from:model];
    if (self.configureSupplementaryViewBlock) {
        self.configureSupplementaryViewBlock(self.model, supplementaryView, self);
    }
    return supplementaryView;
}
- (UICollectionReusableView*)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                       atIndex:(NSInteger)index from:(id<FPConfigureReusableSupplementaryProtocal>)fromModel{
    UICollectionReusableView *supplementaryView;
    if ([fromModel respondsToSelector:@selector(dequeueReusableSupplementaryBlock)] &&  fromModel.dequeueReusableSupplementaryBlock) {
        supplementaryView = fromModel.dequeueReusableSupplementaryBlock(elementKind,self.model,self,self.collectionContext,index);
    }else{
        if ([fromModel respondsToSelector:@selector(nibName)] &&
            [fromModel respondsToSelector:@selector(bundle)] &&
            fromModel.nibName && fromModel.bundle) {
            supplementaryView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self nibName:fromModel.nibName bundle:fromModel.bundle atIndex:index];
            
        }else if([fromModel respondsToSelector:@selector(class_name)] && fromModel.class_name){
            supplementaryView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:fromModel.class_name atIndex:index];
        }
    }
    return supplementaryView;
}
- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index{
    CGFloat height = self.collectionContext.containerSize.height;
    CGFloat width = self.collectionContext.containerSize.width;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if ([self.model.header respondsToSelector:@selector(width)]) {
            width = self.model.header.width;
        }
        if ([self.model.header respondsToSelector:@selector(height)]) {
            height = self.model.header.height;
        }
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        if ([self.model.footer respondsToSelector:@selector(width)]) {
            width = self.model.footer.width;
        }
        if ([self.model.footer respondsToSelector:@selector(height)]) {
            height = self.model.footer.height;
        }
    }
    return CGSizeMake(width, height);
}
-(void)didUpdateToObject:(id<FPSectionModelProtocal>)object{
    self.inset = object.sectionInset;
    self.model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    if ([self respondsToSelector:@selector(didSelectItemBlock)] && self.didSelectItemBlock) {
        self.didSelectItemBlock(self, self.model, index);
    }
}
@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///                    FPNestedSectionController
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface FPNestedSectionController()<IGListAdapterDataSource>
@property (nonatomic,readwrite)IGListAdapter *adapter;
@property (nonatomic,strong)id<FPNestedSectionModelProtocal> model;
@end
@implementation FPNestedSectionController
@dynamic model;
- (IGListAdapter *)adapter{
    if (!_adapter) {
        NSInteger workingRangeSize = 0;
        if ([self.model respondsToSelector:@selector(workingRangeSize)] && self.model.workingRangeSize) {
            workingRangeSize = self.model.workingRangeSize;
        }
        _adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:self.viewController workingRangeSize:workingRangeSize];
        _adapter.dataSource = self;
    }
    return _adapter;
}
- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = self.collectionContext.containerSize.width - self.inset.left - self.inset.right;
    CGFloat height = self.collectionContext.containerSize.height - self.inset.top - self.inset.bottom;
    if ([self.model respondsToSelector:@selector(height)]) {
        if (self.model.height < 0) height = 0.01;
        if (self.model.height > 0) height = self.model.height;
    }
    if ([self.model respondsToSelector:@selector(width)]) {
        if (self.model.width < 0) width = 0.01;
        if (self.model.width > 0) width = self.model.width;
    }
    return CGSizeMake(width, height);
}
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<FPCollectionViewProtocal> *cell;
    if ([self.model respondsToSelector:@selector(dequeueReusableCellBlock)] && self.model.dequeueReusableCellBlock) {
        cell = self.model.dequeueReusableCellBlock(self.model,self,self.collectionContext,index);
    }else{
        cell = [self.collectionContext dequeueReusableCellOfClass:FPNestedCollectionViewCell.class forSectionController:self atIndex:index];
    }
    if ([self.model respondsToSelector:@selector(collectionViewContentInset)]) {
        cell.collectionView.contentInset = self.model.collectionViewContentInset;
    }
    self.adapter.collectionView = cell.collectionView;
    [self.adapter reloadDataWithCompletion:nil];
    if ([self respondsToSelector:@selector(configureCellBlock)] && self.configureCellBlock) {
        self.configureCellBlock(self.model, cell,self);
    }
    return cell;
}
- (nullable UIView *)emptyViewForListAdapter:(nonnull IGListAdapter *)listAdapter {return nil;}
- (nonnull IGListSectionController *)listAdapter:(nonnull IGListAdapter *)listAdapter sectionControllerForObject:(nonnull id <FPSectionModelProtocal>)object {
    if ([object respondsToSelector:@selector(sectionController)] && object.sectionController) {
        return object.sectionController;
    }else{
        return object.sectionControllerBlock(self.model);
    }
}
- (nonnull NSArray<id<IGListDiffable>> *)objectsForListAdapter:(nonnull IGListAdapter *)listAdapter {
    return self.model.nestedCellItems;
}
@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////       FPSingleSectionController
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@interface FPSingleSectionController()
@property (nonatomic,strong)id<FPSingleSectionModelProtocal> model;
@end
@implementation FPSingleSectionController
@dynamic model;
- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = self.collectionContext.containerSize.width - self.inset.left - self.inset.right- self.collectionContext.containerInset.left - self.collectionContext.containerInset.right;
    CGFloat height = self.collectionContext.containerSize.height - self.inset.top - self.inset.bottom - self.collectionContext.containerInset.top - self.collectionContext.containerInset.bottom;
    
    if ([self.model respondsToSelector:@selector(height)]) {
        if (self.model.height < 0) height = 0.01;
        if (self.model.height > 0) height = self.model.height;
    }
    if ([self.model respondsToSelector:@selector(width)]) {
        if (self.model.width < 0) width = 0.01;
        if (self.model.width > 0) width = self.model.width;
    }
    return CGSizeMake(width, height);
}
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell;
    if ([self.model respondsToSelector:@selector(dequeueReusableCellBlock)] && self.model.dequeueReusableCellBlock) {
        cell = self.model.dequeueReusableCellBlock(self.model,self,self.collectionContext,index);
    }else{
        id<FPLoadReusableViewProtocal> cellItem = self.model;
        if ([cellItem respondsToSelector:@selector(nibName)] && [cellItem respondsToSelector:@selector(bundle)] && cellItem.nibName && cellItem.bundle) {
            cell = [self.collectionContext dequeueReusableCellWithNibName:cellItem.nibName bundle:cellItem.bundle forSectionController:self atIndex:index];
        }else{
            cell = [self.collectionContext dequeueReusableCellOfClass:cellItem.class_name forSectionController:self atIndex:index];
        }
    }
    if (self.configureCellBlock) self.configureCellBlock(self.model, cell,self);
    return cell;
}
@end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



@interface FPNumberOfItemsSectionController()
@property (nonatomic,strong)id<FPNumberOfItemSectionModelProtocal> model;
@end
@implementation FPNumberOfItemsSectionController
@dynamic model;
- (NSInteger)numberOfItems{
    return self.model.cellItems.count;
}
- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat height = self.collectionContext.containerSize.height - self.inset.top - self.inset.bottom;
    CGFloat width = self.collectionContext.containerSize.width - self.inset.left - self.inset.right;
    id<FPConfigureReusableCellProtocal> cellItem = self.model.cellItems[index];
    if ([cellItem respondsToSelector:@selector(height)]) {
        if (cellItem.height < 0) height = 0.01;
        if (cellItem.height > 0) height = cellItem.height;
    }
    if ([cellItem respondsToSelector:@selector(width)]) {
        if (cellItem.width < 0) width = 0.01;
        if (cellItem.width > 0) width = cellItem.width;
    }
    return CGSizeMake(height, width);
}
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    UICollectionViewCell *cell;
    id<FPConfigureReusableCellProtocal> model = self.model.cellItems[index];
    if ([self.model respondsToSelector:@selector(dequeueReusableCellBlock)] && self.model.dequeueReusableCellBlock) {
        cell =  self.model.dequeueReusableCellBlock(self.model,self,self.collectionContext,index);
    }else{
        cell = [self dequeueCell:model index:index];
    }
    if (self.configureCellBlock) self.configureCellBlock(model, cell,self);
    return cell;
}
- (UICollectionViewCell*)dequeueCell:(id<FPConfigureReusableCellProtocal>)model index:(NSInteger)index{
    UICollectionViewCell *cell;
    if ([model respondsToSelector:@selector(dequeueReusableCellBlock)] && model.dequeueReusableCellBlock) {
        cell = model.dequeueReusableCellBlock(model,self,self.collectionContext,index);
    }else{
        if ([model respondsToSelector:@selector(nibName)] &&
            [model respondsToSelector:@selector(bundle)] &&
            model.nibName && model.bundle) {
            cell = [self.collectionContext dequeueReusableCellWithNibName:model.nibName bundle:model.bundle forSectionController:self atIndex:index];
        }else if([model respondsToSelector:@selector(class_name)] && model.class_name){
            cell = [self.collectionContext dequeueReusableCellOfClass:model.class_name forSectionController:self atIndex:index];
        }
    }
    return cell;
}
-(void)didUpdateToObject:(id<FPNumberOfItemSectionModelProtocal>)object{
    if ([object respondsToSelector:@selector(sectionInset)]) {
        self.inset = object.sectionInset;
    }
    if ([object respondsToSelector:@selector(minimumLineSpacing)]) {
        self.minimumLineSpacing = object.minimumLineSpacing;
    }
    if ([object respondsToSelector:@selector(minimumInteritemSpacing)]) {
        self.minimumInteritemSpacing = object.minimumInteritemSpacing;
    }
    self.model = object;
}
@end
