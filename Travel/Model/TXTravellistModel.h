//
//  TXTravellistModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject_collection_model.h"
#import "SubjectsModel.h"
@interface TXTravellistModel : NSObject

@property (nonatomic, strong) Subject_collection_model *subject_collection;

@property (nonatomic, strong) NSArray *subjects;


@end
