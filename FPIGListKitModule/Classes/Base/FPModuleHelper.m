//
//  FPModuleHelper.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//
#import "FPModuleHelper.h"
@implementation FPModuleHelper

+ (NSInteger)indexWithSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    __block NSInteger index = NSNotFound;
    [nestedModel.nestedCellItems enumerateObjectsUsingBlock:^(id<FPSectionModelProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sectionModel]) {
            index = idx;
        }
    }];
    return index;
}
+ (NSInteger)indexWithDiffid:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    __block NSInteger index = NSNotFound;
    [nestedModel.nestedCellItems enumerateObjectsUsingBlock:^(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([diffId isEqualToString:obj.diffId]) {
            index = idx;
        }
    }];
    return index;
}


+(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModelWithDiffId:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    __block id <FPSectionModelProtocal,FPCreateSectionControllerProtocal> model;
    [nestedModel.nestedCellItems enumerateObjectsUsingBlock:^(id<FPSectionModelProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.diffId isEqualToString:diffId]) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}
+(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModelWithIndex:(NSInteger)index fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    if (index < 0 || !nestedModel ||!nestedModel.nestedCellItems) {
        return nil;
    }
    if (index < nestedModel.nestedCellItems.count) {
        return nestedModel.nestedCellItems[index];
    }
    return nil;
}

+ (void)removeSectionModelWithDiffId:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    __weak typeof(nestedModel) weakNestedModel = nestedModel;
    [nestedModel.nestedCellItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<FPSectionModelProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.diffId isEqualToString:diffId]) {
            nestedModel.height = 0;
            [weakNestedModel.nestedCellItems removeObject:obj];
            *stop = YES;
        }
    }];
}
+ (void)removeSectionModelWithModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    [self removeSectionModelWithDiffId:sectionModel.diffId fromNestedModel:nestedModel];
}
+ (void)removeSectionModelWithIndex:(NSInteger)index fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    
    if (nestedModel.nestedCellItems.count > index) {
        nestedModel.height = 0;
        [nestedModel.nestedCellItems removeObjectAtIndex:index];
    }
}

+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    if (sectionModel && nestedModel && nestedModel.nestedCellItems) {
        [nestedModel.nestedCellItems addObject:sectionModel];
        nestedModel.height = 0;
    }
}


+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel afterSectionModelDiffId:(NSString*)diffId  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    id<FPSectionModelProtocal,FPCreateSectionControllerProtocal> afterSectionModel = [self sectionModelWithDiffId:diffId fromNestedModel:nestedModel];
    [self addSectionModel:sectionModel afterSectionModel:afterSectionModel fromNestedModel:nestedModel];
}
+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel afterSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)afterSectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    NSInteger afterIndex = [self indexWithSectionModel:afterSectionModel fromNestedModel:nestedModel];
    if (afterIndex != NSNotFound) {
        [nestedModel.nestedCellItems insertObject:sectionModel atIndex:afterIndex + 1];
        nestedModel.height = 0;
    }
}

+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel beforSectionModelDiffId:(NSString*)diffId  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    id<FPSectionModelProtocal,FPCreateSectionControllerProtocal> beforSectionModel = [self sectionModelWithDiffId:diffId fromNestedModel:nestedModel];
    [self addSectionModel:sectionModel beforSectionModel:beforSectionModel fromNestedModel:nestedModel];
}
+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel beforSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)beforSectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    NSInteger beforIndex = [self indexWithSectionModel:beforSectionModel fromNestedModel:nestedModel];
    if (beforIndex != NSNotFound) {
        [nestedModel.nestedCellItems insertObject:sectionModel atIndex:beforIndex];
        nestedModel.height = 0;
    }
}









+ (CGFloat)configureTextHeight:(NSString*)text font:(UIFont*)font widht:(CGFloat)width{
    if (text == nil || text.length == 0) return 0;
    return [self configureTextHeightText:text font:font widht:width numberOfLines:0];
}
+ (CGFloat)configureTextHeightText:(NSString*)text font:(UIFont*)font widht:(CGFloat)width numberOfLines:(int)numberOfLines{
    if (font == nil || width == 0) return 0;
    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [UILabel new];
    });
    label.font = font;
    label.text = text;
    label.numberOfLines = numberOfLines;
    return ceil([label sizeThatFits:CGSizeMake(width, MAXFLOAT)].height);
}
+ (BOOL)compareTextHeightWithNumberOfLines:(int)numberOfLines font:(UIFont*)font widht:(CGFloat)width text:(NSString*)text{
    CGFloat realHeight = [self configureTextHeight:text font:font widht:width];
    CGFloat numberOfLinesHeight = [self configureTextHeightText:text font:font widht:width numberOfLines:numberOfLines];
    return realHeight > numberOfLinesHeight;
}

@end
