//
//  FPCommentSubCell.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/4.
//
#import "FPCommentSubCell.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
@interface FPCommentSubCell()<TTTAttributedLabelDelegate>
@end
@implementation FPCommentSubCell
- (TTTAttributedLabel *)commentLab{
    if (!_commentLab) {
        _commentLab = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
        _commentLab.numberOfLines = 0;
        _commentLab.userInteractionEnabled = YES;
    }
   return _commentLab;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI{
    [self.contentView addSubview:self.commentLab];
    [self.commentLab setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.commentLab attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.commentLab attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.commentLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.commentLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[constraint1,constraint2,constraint3,constraint4]];
}
- (void)setModel:(id<FPCommentSubProtocal>)model{
    _model = model;
    self.commentLab.linkAttributes = @{@(NO):(NSString *)kCTUnderlineStyleAttributeName,[UIColor blackColor] : (NSString*)kCTForegroundColorAttributeName};
    self.commentLab.activeLinkAttributes = @{@(YES):(NSString *)kCTUnderlineStyleAttributeName,[UIColor redColor] : (NSString*)kCTForegroundColorAttributeName};
    self.commentLab.delegate = self;
    [self.commentLab setText:model.attrText.string afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [model.links enumerateObjectsUsingBlock:^(id<FPHyperlinkProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mutableAttributedString setAttributes:obj.configure range:obj.range];
        }];
        return mutableAttributedString;
    }];
    //添加超链接
    [model.links enumerateObjectsUsingBlock:^(id<FPHyperlinkProtocal>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.enableTap){
            [self.commentLab addLinkToTransitInformation:@{@"obj" : obj} withRange:obj.range];
        }
    }];
}
- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTransitInformation:(NSDictionary *)components{
    id<FPHyperlinkProtocal> obj = components[@"obj"];
    if (self.tapLinkBlock) self.tapLinkBlock(obj);
}
@end
