//
//  FPModuleHelper.h
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/9.
//

#import <Foundation/Foundation.h>
#import "FPModuleProtocoal.h"
NS_ASSUME_NONNULL_BEGIN
@interface FPModuleHelper : NSObject


+ (NSInteger)indexWithSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+ (NSInteger)indexWithDiffid:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;


+(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModelWithDiffId:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModelWithIndex:(NSInteger)index fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;



+ (void)removeSectionModelWithDiffId:(NSString*)diffId fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+ (void)removeSectionModelWithIndex:(NSInteger)index fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+ (void)removeSectionModelWithModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;

+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;

+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel afterSectionModelDiffId:(NSString*)diffId  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel afterSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)afterSectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;

+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel beforSectionModelDiffId:(NSString*)diffId  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;
+ (void)addSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)sectionModel beforSectionModel:(id<FPSectionModelProtocal,FPCreateSectionControllerProtocal>)beforSectionModel  fromNestedModel:(id<FPNestedSectionModelProtocal>)nestedModel;








+ (CGFloat)configureTextHeight:(NSString*)text font:(UIFont*)font widht:(CGFloat)width;
+ (CGFloat)configureTextHeightText:(NSString*)text font:(UIFont*)font widht:(CGFloat)width numberOfLines:(int)numberOfLines;
+ (BOOL)compareTextHeightWithNumberOfLines:(int)numberOfLines font:(UIFont*)font widht:(CGFloat)width text:(NSString*)text;

@end
NS_ASSUME_NONNULL_END
