//
//  TXPhotoCollectionListTableViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoCollectionListTableViewCell.h"
#import "AFNetworking.h"
#import "TXPhotoDoulistModel.h"
#import "TXPhotoListCollectionViewCell.h"

@interface TXPhotoCollectionListTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *photoDoulistsArray; // collectionListArray

@end

@implementation TXPhotoCollectionListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.photoDoulistsArray = [NSMutableArray array];
        
        // 布局collectionView
        [self travelCollectionView_photo];
        
        // 数据请求
        [self loadCollectionListData_photo];
        
        
        
    }
    return self;
}

#pragma mark -- 布局collectionView
- (void)travelCollectionView_photo{
    
    
    
    // 使用系统提供的网络布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 创建一个UIcollectionView对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    // 水平滚动时代表列最小间距
    flowLayout.minimumLineSpacing = 5;
    // 水平滚动时代表行最小间距
    flowLayout.minimumInteritemSpacing = 5;
    
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(150, 150);
    
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册可重用标识
    [_collectionView registerClass:[TXPhotoListCollectionViewCell class] forCellWithReuseIdentifier:@"TXPhotoListCollectionViewCell"];
    
    // 设置是否显示滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置是否反弹
    _collectionView.bounces = NO;
    
    // 设置item距离分区边界的位置
//        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
    
    [self.contentView addSubview:_collectionView];
    
    
    
}

#pragma mark -- collecion数据请求
- (void)loadCollectionListData_photo{
    
    // 对第4个section上的collectionView进行数据请求
    // 请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    
    
    // 请求参数:
    [manger GET:photoListCollectionUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 请求数据成功
        
        NSArray *doulistsTempArray = responseObject[@"doulists"];
        for (NSDictionary *dict in doulistsTempArray) {
            
            // 封装
            TXPhotoDoulistModel *txPhotoDoulistsModel = [TXPhotoDoulistModel txPhotoDoulistsModelWithDictionary:dict];
            [self.photoDoulistsArray addObject:txPhotoDoulistsModel];
            
        }
//        TXLog(@">>>>%@", _photoDoulistsArray);
        
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求数据失败
        TXLog(@"错误代码:%@",error);
    }];
    
}

#pragma mark -- collection dalegate and datasource
// 设置collection分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 设置item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoDoulistsArray.count;
    //    return 10;
}

// 绘制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TXPhotoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TXPhotoListCollectionViewCell" forIndexPath:indexPath];
    
    // 设置数据
    TXPhotoDoulistModel *txPhotoDoulistsModel = self.photoDoulistsArray[indexPath.item];
    cell.txPhotoDoulistModel = txPhotoDoulistsModel;
    
    //    cell.titleLabel.text = @"刘亦菲我喜欢你";
    //    cell.flowCountLable.text = @"1793人关注";
    
    return cell;
}


// 选中item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    TXLog(@"选中第%ld个item", (long)indexPath.item);
    TXPhotoDoulistModel *txPhotoDoulistModel = _photoDoulistsArray[indexPath.item];
    if ([_delegate respondsToSelector:@selector(CollectionWithTableViewCellDelegate:)]) {
        [_delegate CollectionWithTableViewCellDelegate:txPhotoDoulistModel];
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