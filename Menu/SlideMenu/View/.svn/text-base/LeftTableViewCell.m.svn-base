//
//  LeftTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 12, 9, 15)];
        _imgView.image = [UIImage imageNamed:@"ic_arrow_grey"];
        [self.contentView addSubview:_imgView];
        
        
        self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 22)];
        [self.contentView addSubview:_iconImgView];
        
    }
    
    return  self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
