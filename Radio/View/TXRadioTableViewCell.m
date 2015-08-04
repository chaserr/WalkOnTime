//
//  TXRadioTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXRadioTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXRadioTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 80)];
        _leftImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_leftImgView];
        
        
        // title
        self.viewOfTitel = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImgView.frame)+5, CGRectGetMinY(_leftImgView.frame)+5, SCREEN_WIDTH - CGRectGetMaxX(_leftImgView.frame)-10, 20)];
//        _viewOfTitel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_viewOfTitel];
        
        
        self.titleLabel = [[UILabel alloc ] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_viewOfTitel.frame)*0.5, 20)];
        _titleLabel.text = @"听暖";
//        _titleLabel.backgroundColor = [UIColor colorWithRed:0.496 green:1.000 blue:0.840 alpha:1.000];
        _titleLabel.font = kRadioTitleFont;
        [_viewOfTitel addSubview:_titleLabel];
        
        self.listenImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_viewOfTitel.frame) - 60, 0, 10, 10)];
        _listenImgView.image = [UIImage imageNamed:@"20150713110643936_easyicon_net_16"];
        [_viewOfTitel addSubview:_listenImgView];
        
        self.listenNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_listenImgView.frame)+5, 0, 60, 10)];
        _listenNumber.text = @"3119347";
//        _listenNumber.backgroundColor = [UIColor greenColor];
        _listenNumber.font = kRadioDescFont;
        [_viewOfTitel addSubview:_listenNumber];
        
        

        
        
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImgView.frame)+5, CGRectGetMaxY(_titleLabel.frame)+15, SCREEN_WIDTH - CGRectGetMaxX(_leftImgView.frame)-10, 20)];
        _userNameLabel.text = @"by.vincy琪";
        _userNameLabel.textColor = [UIColor colorWithRed:0.652 green:0.726 blue:1.000 alpha:1.000];
//        _userNameLabel.backgroundColor = [UIColor redColor];
        _userNameLabel.font = kRadioDescFont;
        [self.contentView addSubview:_userNameLabel];
        
        self.descrtptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImgView.frame)+5, CGRectGetMaxY(_userNameLabel.frame)+5, SCREEN_WIDTH - CGRectGetMaxX(_leftImgView.frame)-30, 30)];
        _descrtptionLabel.numberOfLines = 2;
        _descrtptionLabel.text = @"我看夕阳的时候,从来不说话";
        _descrtptionLabel.font = kRadioDescFont;
        [self.contentView addSubview:_descrtptionLabel];
        
        
    }
    return self;
}


- (void)setTxRadioListModel:(TXRadioListModel *)txRadioListModel{

    _txRadioListModel = txRadioListModel;
    
    // 赋值
    self.titleLabel.text = txRadioListModel.title;
    
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:txRadioListModel.coverimg]];
    
    NSString *nameLableText = [NSString stringWithFormat:@"by.%@", txRadioListModel.userinfo.uname];
    self.userNameLabel.text = nameLableText;
    
    self.listenNumber.text = txRadioListModel.count;
    
    self.descrtptionLabel.text = txRadioListModel.desc;
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
