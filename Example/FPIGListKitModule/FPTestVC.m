//
//  FPTestVC.m
//  FPCommentsModule_Example
//
//  Created by fanpeng on 2020/1/9.
//  Copyright © 2020 FPJack. All rights reserved.
//
#define kSWidth [UIScreen mainScreen].bounds.size.width
#define kDefaultNumberOfLines 3
#define kMoreCommentDiffId @"kMoreCommentDiffId"
#import <FPVideoPictureSectionController.h>
#import <FPCommentSubCell.h>
#import <FPCommentSubModel.h>
#import <FPCommentSubSectionController.h>
#import "FPTestVC.h"
#import <IGListKit/IGListKit.h>
#import <FPIGListKitModule.h>
#import <SDWebImage/SDWebImage.h>
#import <FPTextViewInputView.h>
#import <FPNestedSectionController.h>
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
- (void)setNumberItems{
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
        sectionController.didSelectItemBlock = ^(IGListSectionController * _Nonnull sectionController, id  _Nonnull model, NSInteger index) {
            
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
        [self.datas addObject:model];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.datas = [NSMutableArray array];
    
    [self setNumberItems];
    self.navigationController.navigationBar.translucent = NO;
    FPNumberItemModel *mainModel = [FPNumberItemModel new];
    {
        FPDequeueReusableModel *rModel = [FPDequeueReusableModel new];
        rModel.class_name = [FPCollectionReusableView class];
        rModel.height = 30;
        rModel.dequeueReusableSupplementaryBlock = ^UICollectionReusableView * _Nonnull(NSString * _Nonnull elementKind, id  _Nonnull model, IGListSectionController * _Nonnull sectionController, id<IGListCollectionContext>  _Nonnull collectionContext, NSInteger index) {
            FPCollectionReusableView *view = [collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:sectionController class:[FPCollectionReusableView class] atIndex:index];
            view.backgroundColor = [UIColor grayColor];
            return view;
        };
        //        mainModel.header = rModel;
    }
    FPNumberOfItemsSectionController *sectionController = [FPNumberOfItemsSectionController new];
    mainModel.sectionController = sectionController;
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0 ; i < 1; i ++) {
        [items addObject:[self createModel:i]];
    }
    mainModel.cellItems = items;
    
    [self.datas addObject:mainModel];
    
    self.adapter.collectionView = self.collectionView;
    
    [self.collectionView layoutIfNeeded];
    NSLog(@"%f  ----%f",mainModel.cellItems.firstObject.height,mainModel.cellItems.lastObject.height);
    
}
- (id)createModel:(int)index{
    {
        NSMutableArray *subArr = [NSMutableArray array];
        FPNestedSectionController *nestedSC = [FPNestedSectionController new];
        FPNestedModel *mainModel = [FPNestedModel new];
        mainModel.width = kSWidth;
        {
            FPUserModel *userModel = [FPUserModel new];
            userModel.diffId = @"FPUserModel";
            userModel.userName = [NSString stringWithFormat:@"%d--Jack",index];
            userModel.time = @"2019-09-02";
            FPSingleSectionController *sectonController = [FPSingleSectionController new];
            sectonController.configureCellBlock = ^(FPUserModel*  _Nonnull item, __kindof FPUserInfoCollectionCell * _Nonnull cell,IGListSectionController *sectionController) {
                cell.imgView.backgroundColor = [UIColor orangeColor];
                cell.label1.text = item.userName;
                cell.label2.text = item.time;
                cell.imgView.layer.cornerRadius = 22.5;
                cell.imgView.layer.masksToBounds = YES;
                cell.rightButtonTapBlock = ^(UIButton * _Nonnull button) {
                    //                    [self.datas removeObject:mainModel];
                    [self.adapter performUpdatesAnimated:YES completion:nil];
                };
            };
            userModel.sectionController = sectonController;
            userModel.height = 60;
            userModel.nibName = @"FPUserInfoCollectionCell";
            userModel.bundle = [FPUserInfoCollectionCell userInfoCollectionCellBundle];
            [subArr addObject:userModel];
        }
        
        {
            FPTextModel *textModel = [FPTextModel new];
            textModel.diffId = @"FPTextModel";
            textModel.class_name = FPTextCollectionCell.class;
            FPSingleSectionController *sectonController = [FPSingleSectionController new];
            textModel.font = [UIFont systemFontOfSize:13];
            sectonController.configureCellBlock = ^(FPTextModel*  _Nonnull item, __kindof FPTextCollectionCell * _Nonnull cell,IGListSectionController * sectionController) {
                cell.label.text = item.content;
                cell.label.numberOfLines = item.numberOfLines;
                cell.label.font = item.font;
                cell.label.textColor = [UIColor blackColor];
            };
            textModel.sectionController = sectonController;
            textModel.numberOfLines = 0;
            NSString *imageUrl = @"https://img.52z.com/upload/news/随着项目的不断迭代，各个模块会越来越复杂image/20180621/20180621055651_47663.jpg";
            int rand = arc4random() % 5 + 1;
            NSMutableArray *stringArr = [NSMutableArray array];
            for (int i = 0 ; i < rand; i ++) {
                [stringArr addObject:imageUrl];
            }
            textModel.numberOfLines = kDefaultNumberOfLines;
            NSString *content = [stringArr componentsJoinedByString:@"-"];
            textModel.content = content;
            textModel.sectionInset = UIEdgeInsetsMake(0, 68, 0, 50);
            textModel.width = kSWidth - textModel.sectionInset.left - textModel.sectionInset.right;
            [subArr addObject:textModel];
            
            if ([FPModuleHelper compareTextHeightWithNumberOfLines:textModel.numberOfLines font:textModel.font widht:textModel.width text:textModel.content]) {
                [subArr addObject:[self createExpandSection:mainModel]];
            }
        }
        
        
        {
            FPVideoPictureModel *model = [FPVideoPictureModel new];
            model.diffId = @"FPVideoPictureModel";
            FPVideoPictureSectionController *sectionController = [FPVideoPictureSectionController new];
            sectionController.configureCellBlock = ^(FPVideoPictureModel*  _Nonnull item, __kindof FPVideoPictureCollectionCell * _Nonnull cell,IGListSectionController *sectionController) {
                cell.imageVideoCell.cornerRadius = 5;
                cell.imageVideoCell.loadNetworkImageBlock = ^(UIImageView * _Nonnull imageView, NSURL * _Nonnull url, UIImage * _Nonnull placeholderImage) {
                    [imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
                };
            };
            model.sectionController = sectionController;
            model.column = 3;
            model.minimumLineSpacing = 10;
            model.minimumInteritemSpacing = 10;
            NSString *imageUrl = @"https://img.52z.com/upload/news/image/20180621/20180621055651_47663.jpg";
            int rand = arc4random() % 10;
            if (rand < 7) {
                //图片
                int rand = arc4random() % 10 ;
                NSMutableArray *arr = [NSMutableArray array];
                for (int i = 0 ; i < rand; i ++) {
                    [arr addObject:[imageUrl mutableCopy]];
                }
                if (arr.count == 1) {
                    model.oneItemSize = CGSizeMake(arc4random()%100 + 100, arc4random()%100 + 100);
                    model.maxImageCount = 1;
                }
                model.sources = arr;
                model.type = FPImageTypeShowImage;
                if (rand == 4) {
                    model.sectionInset = UIEdgeInsetsMake(5, 68, 0, 100);
                    model.column = 2;
                    
                }else{
                    model.sectionInset = UIEdgeInsetsMake(5, 68, 0, 20);
                }
            }else{
                //视频
                FPVideoItem *item = [FPVideoItem new];
                item.coverUrl = imageUrl;
                item.itemSize = CGSizeMake(arc4random()%100 + 100, arc4random()%100 + 100);
                NSURL*url=  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"mp4"]];
                item.videoUrl = url;
                model.maxVideoCount = 1;
                model.type = FPImageTypeShowVideo;
                model.oneItemSize = item.itemSize;
                model.sources = [@[item] mutableCopy];
                model.sectionInset = UIEdgeInsetsMake(5, 68, 0, 20);
                
            }
            model.width = kSWidth - model.sectionInset.left - model.sectionInset.right;
            if (model.sources.count > 0) {[subArr addObject:model];}
        }
        
        {
            FPTextModel *model = [FPTextModel new];
            FPSingleSectionController *sectionController = [FPSingleSectionController new];
            sectionController.configureCellBlock = ^(id  _Nonnull item, __kindof FPTextCollectionCell * _Nonnull cell,IGListSectionController * sectionController) {
                cell.label.text = @"两小时前";
                cell.label.font = [UIFont systemFontOfSize:12];
                cell.label.textColor = [UIColor grayColor];
            };
            model.sectionController = sectionController;
            model.class_name = FPTextCollectionCell.class;
            model.height = 30;
            model.sectionInset = UIEdgeInsetsMake(5, 68, 0, 0);
            [subArr addObject:model];
        }
        
        {
            FPNestedModel *commentModel = [FPNestedModel new];
            commentModel.collectionViewContentInset = UIEdgeInsetsMake(10, 12, 10, 12);
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger rand = arc4random() % 10 + 1;
            for (int i = 0; i < rand; i ++) {
                NSString *text = @"会越来越复赖，而且每个模块可能会有共同比较麻烦。";
                NSMutableArray *jArr = [NSMutableArray array];
                NSInteger rand = arc4random() % 10 + 1;
                for (int j = 0 ; j < rand; j ++) {
                    [jArr addObject:text];
                }
                FPCommentSubModel *model = [self createSubComment:[jArr componentsJoinedByString:@"-"] nestedModel:mainModel];
                //                model.sectionController.inset = model.inset;
                [arr addObject:model];
            }
            if (rand > 5) {
                {
                    FPTextModel *model = [FPTextModel new];
                    FPSingleSectionController *sectionController = [FPSingleSectionController new];
                    sectionController.configureCellBlock = ^(id  _Nullable item, __kindof FPBtnCollectionCell * _Nullable cell, IGListSectionController * _Nullable sectionController) {
                        [cell.button setTitle:@"查看更多评论" forState:UIControlStateNormal];
                        cell.tapBlock = ^(UIButton * _Nonnull button) {
                            //点击查看更多评论
                            
                        };
                        [cell.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    };
                    model.diffId = kMoreCommentDiffId;
                    model.sectionController = sectionController;
                    model.class_name = FPBtnCollectionCell.class;
                    model.height = 15;
                    model.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
                    [arr addObject:model];
                }
            }
            commentModel.nestedCellItems = arr;
            FPNestedSectionController *sc = [FPNestedSectionController new];
            sc.configureCellBlock = ^(id  _Nonnull item, __kindof FPNestedCollectionViewCell * _Nonnull cell,IGListSectionController *sectionController) {
                cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
                cell.contentView.layer.cornerRadius = 5;
                cell.contentView.layer.masksToBounds = YES;
            };
            commentModel.sectionInset = UIEdgeInsetsMake(0, 68, 0, 20);
            commentModel.sectionController = sc;
            commentModel.diffId = @"comment";
            [subArr addObject:commentModel];
        }
        
        mainModel.nestedCellItems = subArr;
        mainModel.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
        mainModel.sectionController = nestedSC;
        mainModel.dequeueReusableCellBlock = ^UICollectionViewCell<FPCollectionViewProtocal> * _Nonnull(id<FPSectionModelProtocal>  _Nonnull model, IGListSectionController * _Nonnull sectionController, id<IGListCollectionContext>  _Nonnull collectionContext, NSInteger index) {
            FPNestedModel *nestedModel = (FPNestedModel*)model;
            FPNestedAdapterCollectionViewCell *cell = [collectionContext dequeueReusableCellOfClass:[FPNestedAdapterCollectionViewCell class] forSectionController:sectionController atIndex:index];
            cell.adapter.viewController = self;
            cell.datas = nestedModel.nestedCellItems;
            return cell;
        };
        return mainModel;
        
    }
}
- (id)createSubComment:(NSString*)text nestedModel:(id<FPNestedSectionModelProtocal>)nestedModel{
    FPCommentSubModel *model = [FPCommentSubModel new];
    CGFloat width = kSWidth - 68 - 12 * 2 - 20;
    FPCommentSubSectionController *sectionController = [FPCommentSubSectionController new];
    __weak typeof(self) weakSelf = self;
    sectionController.tapLinkBlock = ^(FPCommentSubSectionController * _Nonnull sectionController,id<FPCommentSubProtocal> commentModel ,id<FPHyperlinkProtocal>  _Nonnull link) {
        //点击用户名
    };
    sectionController.didSelectItemBlock = ^(IGListSectionController *sectionController,id<FPCommentSubProtocal> commentModel,NSInteger index) {
        id<FPNestedSectionModelProtocal> comment = (id<FPNestedSectionModelProtocal>)[FPModuleHelper sectionModelWithDiffId:@"comment" fromNestedModel:nestedModel];
        
        //点击回复内容
        if (sectionController.section == 0) {
            //删除操作
            [FPModuleHelper removeSectionModelWithDiffId:commentModel.diffId fromNestedModel:comment];
            if (comment.nestedCellItems.count == 0) {
                [FPModuleHelper removeSectionModelWithDiffId:comment.diffId fromNestedModel:nestedModel];
            }
            nestedModel.height = 0;
            
            [nestedModel.sectionController.collectionContext performBatchAnimated:YES updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
                [batchContext reloadSectionController:nestedModel.sectionController];
            } completion:nil];
            return ;
        }
        [FPTextViewInputView.share showText:nil placholder:@"输入" block:^(NSString * _Nonnull text) {
            if (!text) return ;
            FPCommentSubModel *subModel = [weakSelf createSubComment:text nestedModel:nestedModel];
            if ([FPModuleHelper indexWithDiffid:kMoreCommentDiffId fromNestedModel:comment] != NSNotFound) {
                [FPModuleHelper addSectionModel:subModel beforSectionModelDiffId:kMoreCommentDiffId fromNestedModel:comment];
            }else{
                [FPModuleHelper addSectionModel:subModel fromNestedModel:comment];
            }
            nestedModel.height = 0;
            [nestedModel.sectionController.collectionContext performBatchAnimated:YES updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
                [batchContext reloadSectionController:nestedModel.sectionController];
            } completion:nil];
        }];
    };
    model.textFont = [UIFont systemFontOfSize:13];
    model.sectionController = sectionController;
    model.commentText = text;
    model.commentByUserName = [NSString stringWithFormat:@"评论人"];
    model.width = width;
    model.commentUserName = @"回复人";
    model.commentByUserId = @"444";
    model.commentUserId = @"333";
    model.commentId = @"9333993";
    return model;
}
- (id)createExpandSection:(FPNestedModel*)nestedModel{
    
    FPTextModel *model = [FPTextModel new];
    FPSingleSectionController *sectionController = [FPSingleSectionController new];
    sectionController.configureCellBlock = ^(FPTextModel*  _Nullable item, __kindof FPBtnCollectionCell * _Nullable cell, IGListSectionController * _Nullable sectionController) {
        [cell.button setTitle:item.strongObject ? @"收起" : @"全文" forState:UIControlStateNormal];
        cell.tapBlock = ^(UIButton * _Nonnull button) {
            //点击查看更多评论
            item.strongObject = item.strongObject ? nil : @"";
            [button setTitle:item.strongObject ? @"收起" : @"全文" forState:UIControlStateNormal];
            FPTextModel *contentModel = (FPTextModel*)[FPModuleHelper sectionModelWithDiffId:@"FPTextModel" fromNestedModel:nestedModel];
            contentModel.numberOfLines = item.strongObject ? 0 : kDefaultNumberOfLines;
            contentModel.height = 0;
            nestedModel.height = 0;
            [nestedModel.sectionController.collectionContext performBatchAnimated:NO updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
                [batchContext reloadSectionController:nestedModel.sectionController];
            } completion:nil];
        };
        [cell.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    };
    model.sectionController = sectionController;
    model.class_name = FPBtnCollectionCell.class;
    model.height = 15;
    model.sectionInset = UIEdgeInsetsMake(5, 68, 0, 0);
    return model;
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
