//
//  NSString+TX.m
//  chaser微了个博
//
//  Created by lanou3g on 15/6/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "NSString+TX.h"

@implementation NSString (TX)

- (NSString *)fileAppend:(NSString *)append{
    
    // 先获取文件拓展名
    NSString *ext = [self pathExtension];
    
    // 删除最后面的扩展名
    NSString *imageName = [self stringByDeletingPathExtension];
    
    // 拼接-568h@2x
    imageName = [imageName stringByAppendingString:append];
    
    // 拼接扩展名
    return  [imageName stringByAppendingPathExtension:ext];
    
}


@end
