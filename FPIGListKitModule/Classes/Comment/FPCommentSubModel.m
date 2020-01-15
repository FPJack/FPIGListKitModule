//
//  FPCommentSubModel.m
//  FPCommentsModule
//
//  Created by fanpeng on 2020/1/11.
//

#import "FPCommentSubModel.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@implementation FPHyperlinkModel
@end



static TTTAttributedLabel *label;
@implementation FPCommentSubModel
@synthesize height = _height;
- (CGFloat)height{
    CGFloat width = self.width;
    if (_height == 0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
            label.numberOfLines = 0;
        });
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 3;
        [label setText:self.attrText.string afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            [mutableAttributedString setAttributes:@{NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, mutableAttributedString.length)];
            return mutableAttributedString;
        }];
       _height =  ceil([label sizeThatFits:CGSizeMake(width, MAXFLOAT)].height);
        _height += 3;
    }
    return _height;
}
- (NSAttributedString *)attrText{
    if (!_attrText && _commentText && _commentText.length > 0) {
        NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        NSMutableArray *links = [NSMutableArray array];
        UIColor *highColor = [UIColor colorWithRed:0 green:120/255.0 blue:1 alpha:1];
        UIColor *norColor = [UIColor blackColor];
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 3;
        if (self.commentUserName && self.commentUserName.length > 0) {//回复人
                NSAttributedString *userAttr = [[NSMutableAttributedString alloc]initWithString:self.commentUserName];
                NSRange userNameRange = NSMakeRange(0,self.commentUserName.length);
                FPHyperlinkModel *model = [FPHyperlinkModel new];
                model.range = userNameRange;
                model.mid = self.commentUserId;
                model.text = self.commentUserName;
                model.enableTap = YES;
                model.configure = @{NSForegroundColorAttributeName : highColor,NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle};
                [links addObject:model];
                [mAttr appendAttributedString:userAttr];
        }
        
        if (mAttr.length > 0 && self.commentByUserName && self.commentByUserName.length > 0) {//
                NSAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@" 回复 "];
                NSRange range = NSMakeRange(mAttr.length,attr.length);
                FPHyperlinkModel *model = [FPHyperlinkModel new];
                model.range = range;
                model.enableTap = NO;
                model.text = attr.string;
                model.configure = @{NSForegroundColorAttributeName : norColor,NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle};
                [links addObject:model];
                [mAttr appendAttributedString:attr];
        }

        if (self.commentByUserName && self.commentByUserName.length > 0) {
                NSAttributedString *commentAttr = [[NSMutableAttributedString alloc]initWithString:self.commentByUserName];
                NSRange range = NSMakeRange(mAttr.string.length,self.commentByUserName.length);
                FPHyperlinkModel *model = [FPHyperlinkModel new];
                model.range = range;
                model.mid = self.commentByUserId;
                model.text = self.commentByUserName;
                model.enableTap = YES;
                model.configure = @{NSForegroundColorAttributeName : highColor,NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle};
                [links addObject:model];
            [mAttr appendAttributedString:commentAttr];
        }
        
        if (mAttr.length > 0) {//
                NSAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@" : "];
                NSRange range = NSMakeRange(mAttr.length,attr.length);
                FPHyperlinkModel *model = [FPHyperlinkModel new];
                model.range = range;
                model.enableTap = NO;
                model.text = attr.string;
                model.configure = @{NSForegroundColorAttributeName : norColor,NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle};
                [links addObject:model];
                [mAttr appendAttributedString:attr];
        }


        if (self.commentText && self.commentText.length > 0) {
            NSAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.commentText];
            NSRange range = NSMakeRange(mAttr.length,attr.length);
            FPHyperlinkModel *model = [FPHyperlinkModel new];
            model.range = range;
            model.mid = self.commentId;
            model.text = attr.string;
            model.enableTap = NO;
            model.configure = @{NSForegroundColorAttributeName : norColor,NSFontAttributeName : self.textFont,NSParagraphStyleAttributeName:paragraphStyle};
            [links addObject:model];
            [mAttr appendAttributedString:attr];
        }
        self.links = links;
        _attrText = mAttr;
    }
    return _attrText;
}
+ (CGFloat)configureTTTAttributedLabelTextHeightText:(NSString*)text configure:(NSDictionary*)config width:(CGFloat)width numberOfLines:(int)numberOfLines{
    static TTTAttributedLabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
        label.numberOfLines = 0;
    });
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString setAttributes:config range:NSMakeRange(0, mutableAttributedString.length)];
        return mutableAttributedString;
    }];
    label.numberOfLines = numberOfLines;
    return ceil([label sizeThatFits:CGSizeMake(width, MAXFLOAT)].height);
}
@end

