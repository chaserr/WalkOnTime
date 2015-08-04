//
//  TXRadioHotListCollectionViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#define kImageWidthH  ((SCREEN_WIDTH-30)/3)      //UITableViewCell里面图片的宽度

#import "TXRadioHotListCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXRadioHotListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        

        self.coveringImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, kImageWidthH, kImageWidthH)];
        _coveringImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_coveringImgView];
        
        
        self.selectionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_coveringImgView.frame)*0.3, 10)];
        _selectionImgView.image = [UIImage imageNamed:@"ic_recommend"];
        [_coveringImgView addSubview:_selectionImgView];
        
        
        
    }
    return self;
}

- (void)setTxRadioHotListModel:(TXRadioHotListModel *)txRadioHotListModel{

    _txRadioHotListModel = txRadioHotListModel;
    
    // 赋值
    [self.coveringImgView sd_setImageWithURL:[NSURL URLWithString:txRadioHotListModel.coverimg]];
    
}



@end
