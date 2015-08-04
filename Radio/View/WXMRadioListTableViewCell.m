
//
//  WXMRadioListTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMRadioListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WXMRadioInfoModel.h"

@implementation WXMRadioListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       //图片
        self.coveringView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        _coveringView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_coveringView];
        
    //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_coveringView.frame) + 10, CGRectGetMinY(_coveringView.frame) + 10, self.frame.size.width , 10)];
        _titleLabel.text = @"相濡以沫的你，是来日相忘的人";
        _titleLabel.font = kTypeLabelFont;
        [self.contentView addSubview:_titleLabel];
        
        //收听图标
        self.numberOfListenView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_coveringView.frame) + 10,CGRectGetMaxY(_coveringView.frame) - 20 ,10 , 10)];
        
        _numberOfListenView.image = [UIImage imageNamed:@"20150713110643936_easyicon_net_16"];
        [self.contentView addSubview:_numberOfListenView];
        
        //收听人数
        self.numberOfListenLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numberOfListenView.frame) + 5, CGRectGetMaxY(_numberOfListenView.frame) - 10, 100, 10)];
        _numberOfListenLabel.text = @"1234";
        _numberOfListenLabel.font = kRadioDescFont;
        [self.contentView addSubview:_numberOfListenLabel];
        
        //播放按钮
        self.playerView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 40 - 10, 20, 20)];
        _playerView.image = [UIImage imageNamed:@"u=2369337130,3196043322&fm=21&gp=0"];
        [self.contentView addSubview:_playerView];
        
        
        //网络请求
    //    [self loadDataTableViewCell];
        
        
    }
    return self;
}

- (void)setWxmRadioListModel:(WXMRadioListModel *)wxmRadioListModel
{
    _wxmRadioListModel = wxmRadioListModel;
    
    //赋值
    self.titleLabel.text = wxmRadioListModel.title;
    [self.coveringView sd_setImageWithURL:[NSURL URLWithString:wxmRadioListModel.coverimg]];
    self.numberOfListenLabel.text = wxmRadioListModel.musicVisit;
    self.freshMusicView = wxmRadioListModel.isnew;

    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
