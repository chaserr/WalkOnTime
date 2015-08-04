//
//  TXMainableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//




#import "TXMainableViewCell.h"
#import "UIImageView+WebCache.h"
@interface TXMainableViewCell ()



@end


@implementation TXMainableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 布局cell
        [self layoutMainTableViewCell];
        
    }
    return self;
}

#pragma mark -- 布局cell
- (void)layoutMainTableViewCell{

    // 类型
    self.typeLable = [[UILabel alloc] initWithFrame:CGRectMake(kCellDistanceFromTop, kCellDistanceFromLeft, SCREEN_WIDTH - 40, kCellDistanceFromLeft)];
    _typeLable.font = kTypeLabelFont;
    [self.contentView addSubview:_typeLable];
    
    // 图片
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellDistanceFromLeft, CGRectGetMaxY(_typeLable.frame)+10, SCREEN_WIDTH - 40, 200 )];
    [self.contentView addSubview:_imgView];
    
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellDistanceFromLeft, CGRectGetMaxY(_imgView.frame)+20, SCREEN_WIDTH - 40, 30)];
    _titleLabel.font = kTitleFont;
    [self.contentView addSubview:_titleLabel];
    
    // 内容
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellDistanceFromLeft, CGRectGetMaxY(_titleLabel.frame)+10, SCREEN_WIDTH - 40, 20)];
    _detailLabel.text = @"content";
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = kContentFont;
    [self.contentView addSubview:_detailLabel];
    
    
    // 收藏图片 收藏数
    self.loveView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 360, 70, 20)];
//    _loveView.backgroundColor = [UIColor colorWithRed:1.000 green:0.186 blue:0.519 alpha:1.000];
    
    [self.contentView addSubview:_loveView];
    
    self.loveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 14)];
    _loveImgView.image = [UIImage imageNamed:@"ic_heart_empty"];
    [_loveView addSubview:_loveImgView];
    
    self.loveCount = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 50, 15)];
    _loveCount.font = kTypeLabelFont;

    [_loveView addSubview:_loveCount];
    
    
    
    
    
    
}



#pragma mark -- 重写模型set方法
- (void)setTxMainList:(TXMainViewList *)txMainList{

    _txMainList = txMainList;
    
    // 给子控件赋值
    NSString *typeName = [NSString stringWithFormat:@"%@·%@", txMainList.name, txMainList.enname];
    self.typeLable.text = typeName;
    
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:txMainList.coverimg]];
    
    self.titleLabel.text = txMainList.title;
    
    self.detailLabel.text = txMainList.content;
    
    self.loveCount.text = [NSString stringWithFormat:@"%@",txMainList.like];
    
    
    _detailLabel.frame = CGRectMake(20, 320, SCREEN_WIDTH - 20, [TXMainableViewCell heightForString:txMainList.content]);
    
    //    TXLog(@".....content高度:%.2f",[TXMainableViewCell heightForString:txMainList.content]);
    _detailLabel.numberOfLines = 0;
}

#pragma mark -- 计算文字高度
+ (CGFloat)heightForString:(NSString *)astring {
    
    CGRect rect = [astring boundingRectWithSize:CGSizeMake(335, 30) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:@{NSFontAttributeName:kContentFont} context:nil];
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
