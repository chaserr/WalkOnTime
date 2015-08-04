//
//  TXReadingDetailTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadingDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXReadingDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 布局cell
        [self layoutMainTableViewCell];
        
    }
    return self;
}

- (void)layoutMainTableViewCell{
        // 标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellDistanceFromLeft, kCellDistanceFromTop, SCREEN_WIDTH - 2*kCellDistanceFromLeft, 30)];
        _titleLabel.font = kTitleFont;
        [self.contentView addSubview:_titleLabel];
        
        // 图片
        self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellDistanceFromLeft, CGRectGetMaxY(_titleLabel.frame)+10, CGRectGetWidth(_titleLabel.frame)*0.5, 60)];
        [self.contentView addSubview:_leftImgView];
        
        // 简介
        self.abstractLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImgView.frame)+5, CGRectGetMaxY(_titleLabel.frame)+10, CGRectGetWidth(_titleLabel.frame)*0.5-5, 60)];
        _abstractLabel.font = ksectionFont;
        _abstractLabel.numberOfLines = 0;
        [self.contentView addSubview:_abstractLabel];
        
}


- (void)setTxReadingDetailLIstModel:(TXReadingDetailLIstModel *)txReadingDetailLIstModel{

    _txReadingDetailLIstModel = txReadingDetailLIstModel;
    
    // 赋值
    _titleLabel.text = txReadingDetailLIstModel.title;
    
    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:txReadingDetailLIstModel.coverimg]];
    
    _abstractLabel.text = txReadingDetailLIstModel.content;
    
    _abstractLabel.frame = CGRectMake(CGRectGetMaxX(_leftImgView.frame)+5, CGRectGetMaxY(_titleLabel.frame)+10, CGRectGetWidth(_titleLabel.frame)*0.5-5, [TXReadingDetailTableViewCell heightForString:txReadingDetailLIstModel.content]);

    
    
}


// 计算文字高度
+ (CGFloat)heightForString:(NSString *)aString{

    CGRect rect = [aString boundingRectWithSize:CGSizeMake((SCREEN_WIDTH - 2*kCellDistanceFromLeft)*0.5-5, 45) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ksectionFont} context:nil];
    return rect.size.height;
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
