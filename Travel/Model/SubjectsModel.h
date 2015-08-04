//
//  SubjectsModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectsModel : NSObject

/**评分*/
@property (nonatomic, copy) NSString *rating;

/**详情*/
@property (nonatomic, copy) NSString *ItemUrl;

/**section类型*/
@property (nonatomic, copy) NSString *type;



/**大图片*/
@property (nonatomic, copy) NSString *pic;

/**item类型*/
@property (nonatomic, copy) NSString *genres;

/**电影id*/
@property (nonatomic, copy) NSString *itemId;

/**书名*/
@property (nonatomic, copy) NSString *title;

/**简介*/
@property (nonatomic, copy) NSString *intro_abstract;

/**国籍*/
@property (nonatomic, copy) NSString *pubdate;

/**演员*/

@property (nonatomic, copy) NSString *actors;

/**导演*/
@property (nonatomic, copy) NSString *directors;

/**作者*/
@property (nonatomic, strong) NSString *author;
@end
