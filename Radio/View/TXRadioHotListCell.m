//
//  TXRadioHotListCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//
#define kImageWidthH  ((SCREEN_WIDTH-30)/3)      //UITableViewCell里面图片的宽度
#import "TXRadioHotListCell.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "TXRadioHotListModel.h"
#import "TXRadioHotListCollectionViewCell.h"
#import "WXMRadioDetailViewController.h"
@interface TXRadioHotListCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *radioHotListArray;
@end

@implementation TXRadioHotListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        // 布局collectionView
        [self radioCollectionView];
        
        // 数据请求
        [self loadCollectionListData_radio];
        
        
    }
    return self;
}


#pragma mark -- 布局collectionView
- (void)radioCollectionView{
    
    
    
    // 使用系统提供的网络布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 创建一个UIcollectionView对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    // 水平滚动时代表列最小间距
    flowLayout.minimumLineSpacing = 8;
    // 水平滚动时代表行最小间距
    flowLayout.minimumInteritemSpacing = 5;
    
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(kImageWidthH, kImageWidthH);
    
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册可重用标识
    [_collectionView registerClass:[TXRadioHotListCollectionViewCell class] forCellWithReuseIdentifier:@"TXRadioHotListCollectionViewCell"];
    
    // 设置是否显示滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置是否反弹
    _collectionView.bounces = NO;
    
    // 设置item距离分区边界的位置
    //    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.contentView addSubview:_collectionView];
    
    
    
}

#pragma mark -- collecion数据请求
- (void)loadCollectionListData_radio{
    
    // 1.创建URL对象
    NSURL *url = [NSURL URLWithString:radioListUrl];
    
    // 2.创建NSMutableRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 3.设置HTTP请求类型
    [mutableRequest setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSString *bodyString = @"client=2";
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:bodyData];
    
    // 使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
            NSDictionary *dataDict = responseDict[@"data"];
            
#pragma mark -- 设置hotList列表
            self.radioHotListArray = [NSMutableArray array];
            NSArray *tmpHotListArray = dataDict[@"hotlist"];
            for (NSDictionary * dict in tmpHotListArray) {
                
                TXRadioHotListModel *txRadioHotListModel = [TXRadioHotListModel objectWithKeyValues:dict];
                [_radioHotListArray addObject:txRadioHotListModel];
                
            }
            
#warning 在数据请求下来后一定要进行数据刷新
            [self.collectionView reloadData];
        }

        
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                [self.footer endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
//                [SVProgressHUD showWithStatus:@"网络繁忙,努力加载中"];
            });
            
        }

    }];
    // 数据请求结束
}

#pragma mark -- collection dalegate and datasource
// 设置collection分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 设置item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _radioHotListArray.count;
    //    return 10;
}

// 绘制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TXRadioHotListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TXRadioHotListCollectionViewCell" forIndexPath:indexPath];
    
    // 设置数据
    TXRadioHotListModel *txRadioHotListModel = self.radioHotListArray[indexPath.item];
    cell.txRadioHotListModel = txRadioHotListModel;
    
//        cell.text = @"刘亦菲我喜欢你";
//        cell.flowCountLable.text = @"1793人关注";
    
    return cell;
}


// 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    TXLog(@"选中第%ld个item", indexPath.item);

     TXRadioHotListModel *txRadioHotListModel =  _radioHotListArray[indexPath.item];

    if ([_delegate respondsToSelector:@selector(txRadioHotListCell:)]) {
        [_delegate txRadioHotListCell:txRadioHotListModel];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
