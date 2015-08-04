//
//  WXMRadioDetailTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMRadioDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation WXMRadioDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //user图片
        self.userInfoCoveringImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        _userInfoCoveringImg.backgroundColor = [UIColor grayColor ];
        _userInfoCoveringImg.layer.cornerRadius = _userInfoCoveringImg.frame.size.width / 2;
        _userInfoCoveringImg.clipsToBounds = YES;
        [self.contentView addSubview:_userInfoCoveringImg];
        
        //user名
        self.userInfoNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userInfoCoveringImg.frame) + 10, CGRectGetMinY(_userInfoCoveringImg.frame) + 5, 100, 10)];
        _userInfoNameLabel.text = @"DJ何善尼";
        _userInfoNameLabel.font = kRadioTitleFont;
        _userInfoNameLabel.textColor = [UIColor colorWithRed:0.185 green:0.528 blue:1.000 alpha:0.7];
        [self.contentView addSubview:_userInfoNameLabel];
        
        //des
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userInfoCoveringImg.frame) , (CGRectGetMaxY(_userInfoCoveringImg.frame) + 20), self.frame.size.width, 10)];
        _descLabel.text = @"只告诉你这个密码";
        _descLabel.font = kRadioTitleFont;
        [self.contentView addSubview:_descLabel];
        
       //listenImage
        self.listenImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userInfoNameLabel.frame)+100, 20, 10, 10)];
        _listenImgView.image = [UIImage imageNamed:@"20150713110643936_easyicon_net_16"];
        [self.contentView addSubview:_listenImgView];
        
        
      //listenNumber
        self.listenNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_listenImgView.frame)+5, 20, 60, 10)];
        _listenNumber.text = @"3119347";
        _listenNumber.font = kRadioDescFont;
        _listenNumber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_listenNumber];
        
    }
    return self;
}

- (void)setWxmRadioInfoModel:(WXMRadioInfoModel *)wxmRadioInfoModel
{
    
    _wxmRadioInfoModel = wxmRadioInfoModel;
    
    TXLog(@"%@", self.wxmRadioInfoModel);
    
    //赋值
    [self.userInfoCoveringImg sd_setImageWithURL:[NSURL URLWithString:wxmRadioInfoModel.userinfo.icon]];
    self.userInfoNameLabel.text = wxmRadioInfoModel.userinfo.uname;
    self.descLabel.text = wxmRadioInfoModel.desc;
    
    // NSNumber->字符串
    NSString * musicvisitnumString = [NSString stringWithFormat:@"%@", wxmRadioInfoModel.musicvisitnum];
    self.listenNumber.text = musicvisitnumString;

    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
