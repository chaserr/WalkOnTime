//
//  RequestUrl.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#ifndef WalkOnTime_RequestUrl_h
#define WalkOnTime_RequestUrl_h

/** 首页*/
//首页列表数据请求Url  请求参数start=0&client=2&limit=10
#define homeUrlHead @"http://api2.pianke.me/pub/today"

//首页列表详情数据请求  请求参数contentid=52a880957f8b9ae115000028&client=2
#define articalUrl  @"http://api2.pianke.me/article/info"



/** 旅游界面*/
/**旅游界面数据请求*/
//#define travelUrl @"https://frodo.douban.com/api/v2/tag/16/subject_collection_boards?apikey=0dad551ec0f84ed02907ff5c42e8ec70&count=20&editor_choice=1"
//
///** 旅游界面collectionView数据请求*/
//#define travelList_collectionUrl @"https://frodo.douban.com/api/v2/tag/16/related_doulists?apikey=0dad551ec0f84ed02907ff5c42e8ec70"

/** 读书界面*/
/**读书界面数据请求*/
#define reading_doubanUrl @"https://frodo.douban.com/api/v2/tag/3/subject_collection_boards?apikey=0dad551ec0f84ed02907ff5c42e8ec70&count=20&editor_choice=1"

/** 读书界面collectionView数据请求*/
#define reading_collectionUrl @"https://frodo.douban.com/api/v2/tag/3/related_doulists?apikey=0dad551ec0f84ed02907ff5c42e8ec70"


///** 摄影界面*/
//// 摄影界面首页数据
//#define photoListUrl @"https://frodo.douban.com/api/v2/tag/5903/subject_collection_boards?apikey=0dad551ec0f84ed02907ff5c42e8ec70&count=20&editor_choice=1"
//
//// collectionList数据请求
//#define photoListCollectionUrl @"https://frodo.douban.com/api/v2/tag/5903/related_doulists?apikey=0dad551ec0f84ed02907ff5c42e8ec70"


/** 影视界面*/
// 影视界面首页数据
#define movieUrl @"https://frodo.douban.com/api/v2/tag/49/subject_collection_boards?udid=1422361929c3079a48b9248d9b10e6f06eb61091&apikey=0dad551ec0f84ed02907ff5c42e8ec70&count=20&editor_choice=1&loc_id=108288"

// 影视collectionList数据请求
#define photoListCollectionUrl @"https://frodo.douban.com/api/v2/tag/49/related_doulists?apikey=0dad551ec0f84ed02907ff5c42e8ec70"


/** 阅读界面*/
// 阅读界面数据请求  请求参数:client=2
#define readingUrl @"http://api2.pianke.me/read/columns"

// 阅读界面详情页最新列表数据请求  请求参数:sort=addtime&start=0&client=2&typeid=1&limit=10 最新列表
#define readingDetailList_addTimeUrl @"http://api2.pianke.me/read/columns_detail"

// 阅读界面详情页最热列表数据请求  请求参数:sort=hot&start=0&client=2&typeid=1&limit=10 最热列表
#define readingArticalDetail_hotUrl @"http://api2.pianke.me/read/columns_detail";

// 阅读界面详情页列表文章详情数据请求  请求参数:contentid=52a880957f8b9ae115000028&client=2  contentid进行拼接
#define readingArticalDetailUrl @"http://api2.pianke.me/article/info"

/** 电台界面*/
// 电台界面列表详情页数据请求 请求参数:client=2
#define radioListUrl @"http://api2.pianke.me/ting/radio"

//电台界面电台详情页数据请求  请求参数:auth=&client=1&deviceid=19277E37-CDE3-4691BCE3FEA693CA2BC6&radioid=559f981053479ce2228b4620&version=3.0.4
#define radioDetailUrl @"http://api2.pianke.me/ting/radio_detail"

//电台界面播放页数据请求 请求参数：auth=&client=1&deviceid=19277E37-CDE3-4691-BCE3-FEA693CA2BC6&tingid=55a8e54953479c03598b4605&version=3.0.4
#define radioPlayerUrl @"http://api2.pianke.me/ting/info"

#endif
