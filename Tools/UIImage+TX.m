//
//  UIImage+TX.m
//  chaser微了个博
//
//  Created by lanou3g on 15/6/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "UIImage+TX.h"
#import "NSString+TX.h"
@implementation UIImage (TX)

// 加载全屏图片
+ (UIImage *)fullscreenImage:(NSString *)imageName{
    
    // 如果是iphone5,对文件名特殊处理
    if (IPHONE5) {
        
        imageName = [imageName fileAppend:@"-568h@2x"];
        
  
    }
    
    // 加载图片
    return [self imageNamed:imageName];
}




@end
