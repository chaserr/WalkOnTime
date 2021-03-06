//
//  TXTravelListTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTravelListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "SubjectsModel.h"


@implementation TXTravelListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 布局cell
        [self layoutMainTableViewCell];
        
    }
    return self;
}

#pragma mark -- 布局cell
- (void)layoutMainTableViewCell{
    
    // 封装查看人数和跳转图片
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(10, kCellDistanceFromLeft-10, SCREEN_WIDTH - 20, 25)];
    _titleView.userInteractionEnabled = YES;
    // 点击标题触发事件
    
    self.tapGestureWithTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureWithTitle:)];
    
    [self.titleView addGestureRecognizer:_tapGestureWithTitle];
    [self.contentView addSubview:_titleView];
    
    // 标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame)/2,CGRectGetHeight(_titleView.frame))];
    self.titleLabel.font = ksectionFont;
    
//    _titleLabel.backgroundColor = [UIColor colorWithRed:0.787 green:1.000 blue:0.709 alpha:1.000];
    [_titleView addSubview:_titleLabel];
    
    // 观看人数
    self.lookCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleView.frame)-70, 0, 50, CGRectGetHeight(_titleView.frame))];
    self.lookCount.textAlignment = NSTextAlignmentRight;
    self.lookCount.font = [UIFont systemFontOfSize:13];
    [_titleView addSubview:_lookCount];
    
    self.nextImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lookCount.frame)+5, 5, 10, 15)];
    _nextImg.image = [UIImage imageNamed:@"ic_arrow_grey"];
    [_titleView addSubview:_nextImg];
    

    // 第一本书
    self.first_txTravelListCellForView = [[TXTravelListCellForView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleView.frame)+10, (SCREEN_WIDTH-60)/3, 130)];
    self.tapGestureWithFirstImg= [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapGestureWithfirstImg:)];
    [_first_txTravelListCellForView addGestureRecognizer:_tapGestureWithFirstImg];
    _first_txTravelListCellForView.userInteractionEnabled = YES;
    [self.contentView addSubview:_first_txTravelListCellForView];
    
    // 第二本书
    self.second_txTravelListCellForView = [[TXTravelListCellForView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_first_txTravelListCellForView.frame)+10, CGRectGetMaxY(_titleView.frame)+10, (SCREEN_WIDTH-60)/3, 130)];
    self.tapGestureWithSecondImg= [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapGestureWithsecondImg:)];
    [_second_txTravelListCellForView addGestureRecognizer:_tapGestureWithSecondImg];
    _second_txTravelListCellForView.userInteractionEnabled = YES;
    [self.contentView addSubview:_second_txTravelListCellForView];
    
    // 第三本书
    self.third_txTravelListCellForView = [[TXTravelListCellForView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_second_txTravelListCellForView.frame)+10, CGRectGetMaxY(_titleView.frame)+10, (SCREEN_WIDTH-60)/3, 130)];
    self.tapGestureWithThirdImg= [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapGestureWiththirdImg:)];
    [_third_txTravelListCellForView addGestureRecognizer:_tapGestureWithThirdImg];
    _third_txTravelListCellForView.userInteractionEnabled = YES;
    [self.contentView addSubview:_third_txTravelListCellForView];
    
 
    
}



#pragma mark -- 轻拍手势

- (void)tapGestureWithTitle:(UITapGestureRecognizer *)tapGuesture {

    if ([_delegate respondsToSelector:@selector(txTravelListTableViewCellShowDetailWithTapGesture: txTravellistModelWithUrl:)]) {
        [_delegate txTravelListTableViewCellShowDetailWithTapGesture:tapGuesture txTravellistModelWithUrl:self.txTravellistModel.subject_collection.subject_collection_url];
    }
    
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.txTravellistModel.subject_collection.subject_collection_url]];
    
//    TXLog(@"轻拍标题s%@",self.txTravellistModel.subject_collection.name);
 
}

- (void)tapGestureWithfirstImg:(UITapGestureRecognizer *)tapGuesture {
    
    NSArray *array = self.txTravellistModel.subjects;
    
    SubjectsModel *subjectModel = array[0];
    NSString *urlString = subjectModel.itemId;
    
    // 模型转字典
//    NSDictionary *subjectsDict = [array[0] keyValues];
    //    TXLog(@"模型转字典:%@",subjectsDict);
    // 图片->详情
//    NSString *normalImgUrl = [subjectsDict objectForKey:@"ItemUrl"];
    
    
    if ([_delegate respondsToSelector:@selector(txTravelListTableViewCellShowDetailWithTapGesture: txTravellistModelFirstImgWithUrl:)]) {
        [_delegate txTravelListTableViewCellShowDetailWithTapGesture:tapGuesture txTravellistModelFirstImgWithUrl:urlString];
    }
    
}

- (void)tapGestureWithsecondImg:(UITapGestureRecognizer *)tapGuesture {
    
    NSArray *array = self.txTravellistModel.subjects;
    
    // 模型转字典
//    NSDictionary *subjectsDict = [array[1] keyValues];
//        TXLog(@"模型转字典:%@",subjectsDict);
    SubjectsModel *subjectModel = array[1];
    NSString *urlString = subjectModel.itemId;
    // 图片->详情
//    NSString *normalImgUrl = [subjectsDict objectForKey:@"itemId"];
    
    if ([_delegate respondsToSelector:@selector(txTravelListTableViewCellShowDetailWithTapGesture: txTravellistModelSecondImgWithUrl:)]) {
        [_delegate txTravelListTableViewCellShowDetailWithTapGesture:tapGuesture txTravellistModelSecondImgWithUrl:urlString];
    }
    
}

- (void)tapGestureWiththirdImg:(UITapGestureRecognizer *)tapGuesture {
    
    NSArray *array = self.txTravellistModel.subjects;
    
    // 模型转字典
    NSDictionary *subjectsDict = [array[2] keyValues];
    //    TXLog(@"模型转字典:%@",subjectsDict);
    
    // 图片->详情
    NSString *normalImgUrl = [subjectsDict objectForKey:@"id"];
    
    if ([_delegate respondsToSelector:@selector(txTravelListTableViewCellShowDetailWithTapGesture: txTravellistModelThirdImgWithUrl:)]) {
        [_delegate txTravelListTableViewCellShowDetailWithTapGesture:tapGuesture txTravellistModelThirdImgWithUrl:normalImgUrl];
    }
    
}




- (void)setTxTravellistModel:(TXTravellistModel *)txTravellistModel{

    _txTravellistModel = txTravellistModel;
    
    
    
    // 赋值
    
    self.titleLabel.text = txTravellistModel.subject_collection.name;
    
    
    self.lookCount.text = txTravellistModel.subject_collection.subject_count;

    NSArray *array = txTravellistModel.subjects;
    
    // 模型转字典
    NSDictionary *subjectsDict = [array[0] keyValues];
//    TXLog(@"模型转字典:%@",subjectsDict);
    
  // 图片
    NSString *normalImgUrl = [[subjectsDict objectForKey:@"pic"] objectForKey:@"normal"];
    [self.first_txTravelListCellForView.imgView sd_setImageWithURL:[NSURL URLWithString:normalImgUrl]];

    // 名称
    self.first_txTravelListCellForView.nameLabel.text = subjectsDict[@"title"];
    
    // 评分
    NSNumber *scoreNumber = [[subjectsDict objectForKey:@"rating"] objectForKey:@"value"];
//    TXLog(@"----->%@",scoreNumber);
    CGFloat scoreFloat = [scoreNumber floatValue];
    NSString *appendString = [NSString stringWithFormat:@"评分:    %.1f", scoreFloat];
    self.first_txTravelListCellForView.scoreLabel.text = appendString;
    
    
    // 第二本书
    // 模型转字典
    NSDictionary *subjectsDictTwo = [array[1] keyValues];
    //    TXLog(@"模型转字典:%@",subjectsDict);
    
    // 图片
    [self.second_txTravelListCellForView.imgView sd_setImageWithURL:[NSURL URLWithString:[[subjectsDictTwo objectForKey:@"pic"] objectForKey:@"normal"]]];
    
    // 名称
    self.second_txTravelListCellForView.nameLabel.text = subjectsDictTwo[@"title"];
    
    // 评分
    NSNumber *scoreNumberTwo = [[subjectsDictTwo objectForKey:@"rating"] objectForKey:@"value"];
    //    TXLog(@"----->%@",scoreNumber);
    CGFloat scoreFloatTwo = [scoreNumberTwo floatValue];
    NSString *appendStringTwo = [NSString stringWithFormat:@"评分:    %.1f", scoreFloatTwo];
    self.second_txTravelListCellForView.scoreLabel.text = appendStringTwo;
    
    
    // 第三本书
    
    // 模型转字典
    NSDictionary *subjectsDictThird = [array[2] keyValues];
    //    TXLog(@"模型转字典:%@",subjectsDict);
    
    // 图片
    [self.third_txTravelListCellForView.imgView sd_setImageWithURL:[NSURL URLWithString:[[subjectsDictThird objectForKey:@"pic"] objectForKey:@"normal"]]];
    
    // 名称
    self.third_txTravelListCellForView.nameLabel.text = subjectsDictThird[@"title"];
    
    // 评分
    NSNumber *scoreNumberThird = [[subjectsDictThird objectForKey:@"rating"] objectForKey:@"value"];
    //    TXLog(@"----->%@",scoreNumber);
    CGFloat scoreFloatThird = [scoreNumberThird floatValue];
    NSString *appendStringThird = [NSString stringWithFormat:@"评分:    %.1f", scoreFloatThird];
    self.third_txTravelListCellForView.scoreLabel.text = appendStringThird;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
