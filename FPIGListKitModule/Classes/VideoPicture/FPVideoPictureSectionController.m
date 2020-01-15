//
//  FPVideoPictureSectionController.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/8.
//

#import "FPVideoPictureSectionController.h"
@implementation FPVideoPictureModel

@synthesize height = _height;
- (CGFloat)height{
    #warning  height = 0 下面的sectionController不会显示 可能是IGListKit的问题 后续再看
    if (self.sources.count == 0) return 0.01;
    if (!_height) {
        if (self.sources.count == 1 && !CGSizeEqualToSize(self.oneItemSize, CGSizeZero)) {
            _height = self.oneItemSize.height;
        }else{
            NSInteger column = self.column <= 0 ? 1 : self.column;
            NSInteger line = (self.sources.count - 1)/column + 1;
            CGFloat itemWidth = (self.width - (column - 1) * self.minimumInteritemSpacing)/column;
            CGFloat itemHeight = itemWidth * line;
            CGFloat spaceHeight = (line - 1) * self.minimumLineSpacing;
            _height = itemHeight + spaceHeight;
        }
    }
    return _height;
}
@end
@interface FPVideoPictureCollectionCell()
@property (nonatomic,strong)FPImageVideoCell *imageVideoCell;
@end
@implementation FPVideoPictureCollectionCell
- (FPImageVideoCell *)imageVideoCell{
    if (!_imageVideoCell) {
        _imageVideoCell = [[FPImageVideoCell alloc]initWithFrame:CGRectZero];
    }
    return _imageVideoCell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageVideoCell];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageVideoCell.frame = self.contentView.bounds;
}
@end
@interface FPVideoPictureSectionController()
@property (nonatomic,strong)id <FPVideoPictureProtocal> model;
@end
@implementation FPVideoPictureSectionController
- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = self.model.width;
    if (width <= 0) {
        width = self.collectionContext.containerSize.width - self.inset.left - self.inset.right;
    }
    return CGSizeMake(width, self.model.height);
}
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    FPVideoPictureCollectionCell* cell = [self.collectionContext dequeueReusableCellOfClass:FPVideoPictureCollectionCell.class forSectionController:self atIndex:index];
    FPImageVideoCell *videoImageCell = cell.imageVideoCell;
    {
        videoImageCell.type = self.model.type;
        videoImageCell.minimumLineSpacing = self.model.minimumLineSpacing;
        videoImageCell.minimumInteritemSpacing = self.model.minimumInteritemSpacing;
        videoImageCell.column = self.model.column;
        videoImageCell.itemSize = self.model.oneItemSize;
        videoImageCell.maxImageCount = self.model.maxImageCount <= 0 ? 9 : self.model.maxImageCount;
        videoImageCell.maxVideoCount = self.model.maxVideoCount <= 0 ? 1 : self.model.maxVideoCount;
        videoImageCell.source = self.model.sources;
//        videoImageCell.source = [self.model.sources mutableCopy];
    }
    if ([self respondsToSelector:@selector(configureCellBlock)] && self.configureCellBlock) {self.configureCellBlock(self.model, cell,self);}
    return cell;
}
- (void)didUpdateToObject:(id<FPVideoPictureProtocal>)object{
    self.inset = object.sectionInset;
    self.model = object;
}
- (void)didSelectItemAtIndex:(NSInteger)index{
    if ([self respondsToSelector:@selector(didSelectItemBlock)] && self.didSelectItemBlock) {
        self.didSelectItemBlock(self, self.model, index);
    }
}

@end

