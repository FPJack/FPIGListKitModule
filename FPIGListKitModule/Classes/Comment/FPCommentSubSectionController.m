//
//  FPCommentSubSectionController.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/6.
//

#import "FPCommentSubSectionController.h"
#import "FPCommentSubProtocal.h"
#import "FPCommentSubCell.h"
@interface FPCommentSubSectionController()
@property (nonatomic,weak)id<FPCommentSubProtocal> model;
@end
@implementation FPCommentSubSectionController
- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = self.model.width;
    if (width <= 0) {
        width = self.collectionContext.containerSize.width - self.inset.left - self.inset.right - self.collectionContext.containerInset.left - self.collectionContext.containerInset.right;
    }
    return CGSizeMake(width, self.model.height);
}
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    FPCommentSubCell* cell = [self.collectionContext dequeueReusableCellOfClass:FPCommentSubCell.class forSectionController:self atIndex:index];
    cell.model = self.model;
    __weak typeof(self) weakSelf = self;
    cell.tapLinkBlock = ^(id<FPHyperlinkProtocal>  _Nonnull link) {
        if (weakSelf.tapLinkBlock) weakSelf.tapLinkBlock(weakSelf, weakSelf.model,link);
    };
    if ([self respondsToSelector:@selector(configureCellBlock)] && self.configureCellBlock) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.section];
        self.configureCellBlock(self.model,indexPath, cell,self);
    }
    return cell;
}
- (void)didUpdateToObject:(id<FPCommentSubProtocal>)object{
    self.inset = object.sectionInset;
    self.model = object;
}
- (void)didSelectItemAtIndex:(NSInteger)index{
    if ([self respondsToSelector:@selector(didSelectItemBlock)] && self.didSelectItemBlock) {
        self.didSelectItemBlock(self, self.model, [NSIndexPath indexPathForItem:index inSection:self.section]);
    }
}
@end
