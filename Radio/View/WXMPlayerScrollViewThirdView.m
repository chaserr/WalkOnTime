//
//  WXMPlayerScrollViewThirdView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//


#import "WXMPlayerScrollViewThirdView.h"
#import "WYLILViEW.h"
#import "UIImageView+WebCache.h"
@implementation WXMPlayerScrollViewThirdView

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        
        self.lilView1 = [[WYLILViEW alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH / 2  , 50)];
        _lilView1.firstLabel.text = @"主播:";
        _lilView1.firstLabel.font = [UIFont fontWithName:nil size:12];
        _lilView1.image.layer.cornerRadius = _lilView1.image.frame.size.width / 2;
        _lilView1.image.clipsToBounds = YES;
        _lilView1.secondLabel.text = @"李念";
        _lilView1.secondLabel.textAlignment = NSTextAlignmentLeft;
        _lilView1.secondLabel.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_lilView1];
        
        self.lilView2 = [[WYLILViEW alloc] initWithFrame:CGRectMake(10,  60, SCREEN_WIDTH / 2, 50)];
        _lilView2.firstLabel.text = @"原文:";
        _lilView2.firstLabel.font = [UIFont fontWithName:nil size:12];
        _lilView2.image.layer.cornerRadius = _lilView2.image.frame.size.width / 2;
        _lilView2.image.clipsToBounds = YES;
        _lilView2.secondLabel.text = @"李念";
        _lilView2.secondLabel.textAlignment = NSTextAlignmentLeft;
        _lilView2.secondLabel.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_lilView2];
        
    //来自电台
        self.fromStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 80, 20)];
        _fromStationLabel.text = @"来自电台:";
        _fromStationLabel.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_fromStationLabel];
        
        self.fromStationcontent = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_fromStationLabel.frame) - 10, 120, SCREEN_WIDTH - 80, 20)];
        _fromStationcontent.text = @"半个故事一首歌";
        _fromStationcontent.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_fromStationcontent];
        
    //主播其他作品
        self.otherworksLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 80, 20)];
        _otherworksLabel.text = @"主播其他作品";
        _otherworksLabel.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_otherworksLabel];
        
        self.imageArray = [NSMutableArray array];
        self.titleLabelArray = [NSMutableArray array];
        for (int i = 0; i < 2; i ++) {
            for (int j = 0; j <3; j ++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(28 + j  * 100 + 10 * j  , 210 + i * 100 + i * 10, 100, 100)];
                imageView.backgroundColor = [UIColor purpleColor];
                [self addSubview:imageView];
                [_imageArray addObject:imageView];
                self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 100, 15)];
                _titleLabel.text = @"一个人得兵荒马乱";
                _titleLabel.font = kRadioTitleFont;
                [imageView addSubview:_titleLabel];
                [_titleLabelArray addObject:_titleLabel];
            }
        }
        
        
      //查看全部电台
        self.backToAllStationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backToAllStationBtn.frame = CGRectMake(SCREEN_WIDTH - 160, SCREEN_HEIGHT - 220, 120, 20);
        [_backToAllStationBtn setTitle:@"查看其他电台" forState:UIControlStateNormal];
        [self addSubview:_backToAllStationBtn];
        
        self.backToAllStationImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _backToAllStationImg.frame = CGRectMake(SCREEN_WIDTH - 40, SCREEN_HEIGHT - 220, 10, 20);
        _backToAllStationImg.backgroundColor = [UIColor grayColor];
        [self addSubview:_backToAllStationImg];
        
        
    }

    return self;
}

- (void) setWxmPlayerThirdViewModel:(WXMPlayerThirdViewModel *)wxmPlayerThirdViewModel
{

    _wxmPlayerThirdViewModel = wxmPlayerThirdViewModel;
    //赋值
    [self.lilView1.image sd_setImageWithURL:[NSURL URLWithString:wxmPlayerThirdViewModel.userinfo.icon]];
    self.lilView1.secondLabel.text = wxmPlayerThirdViewModel.userinfo.uname;
    [self.lilView2.image sd_setImageWithURL:[NSURL URLWithString:wxmPlayerThirdViewModel.authorinfo.icon]];
    self.lilView2.secondLabel.text = wxmPlayerThirdViewModel.authorinfo.uname;
    self.fromStationcontent.text = wxmPlayerThirdViewModel.radioname;
    for (int i = 0; i < 6; i ++) {
        [_imageArray[i ] sd_setImageWithURL:[NSURL URLWithString:wxmPlayerThirdViewModel.coverimg]];
       
    }


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
