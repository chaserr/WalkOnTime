//
//  UIImage+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+MJ.h"

@implementation UIImage (MJ)
+ (UIImage *)imageWithName:(NSString *)name
{
//    if (iOS7) {
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        UIImage *image = [UIImage imageNamed:newName];
//        if (image == nil) { // 没有_os7后缀的图片
//            image = [UIImage imageNamed:name];
//        }
//        return image;
//    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)resizeImage
{
    CGFloat leftCap = self.size.width * 0.5f;
    CGFloat topCap = self.size.height * 0.5f;
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)cut:(CGSize)sizeScale
{
    CGFloat width = self.size.width * sizeScale.width;
    CGFloat height = self.size.height * sizeScale.height;
    CGFloat x = (self.size.width -  width) * 0.5;
    CGFloat y = (self.size.height - height) * 0.5;
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef ref = CGImageCreateWithImageInRect(self.CGImage, rect);
    return [UIImage imageWithCGImage:ref];
}

@end
