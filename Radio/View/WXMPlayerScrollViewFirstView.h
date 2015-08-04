//
//  WXMPlayerScrollViewFirstView.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMPlayerFirstViewModel.h"
#import "WXMPlayerInfoModel.h"
@interface WXMPlayerScrollViewFirstView : UIView

/** 主题图片 */

@property (nonatomic, strong) UIImageView *titleImage;

/**  主题*/

@property (nonatomic,strong) UILabel *titleLabel;

/**  感兴趣图片*/

@property (nonatomic, strong) UIImageView *interestImage;

/**  感兴趣人数*/

@property (nonatomic, strong) UILabel *interestNumLabel;

/**  评论图片*/

@property (nonatomic, strong) UIImageView *commentImage;

/**  评论人数*/
@property (nonatomic, strong) UILabel *commentNumLabel;


/**  播放时间显示*/
//@property(nonatomic, strong) UILabel *elapsedTime;//过去时间
@property (nonatomic, strong) UILabel *timeRemaining;//剩余时间

/**  播放进度条*/
@property (nonatomic, strong) UISlider *playerSlider;

@property (nonatomic, strong) WXMPlayerFirstViewModel *wxmPlayerFirstViewModel;
@end
