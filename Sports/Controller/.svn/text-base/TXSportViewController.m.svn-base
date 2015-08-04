//
//  TXSportViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSportViewController.h"
#import "TXSpotrCollectionViewCell.h"
#import "TXSportCollectionLayout.h"
@interface TXSportViewController ()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation TXSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局collectionView
    [self layoutCollectionView];
}

#pragma mark -- 布局CollectionView
- (void)layoutCollectionView{
    
    // 使用系统提供的网络布局
    
    TXSportCollectionLayout *flowLayout = [[TXSportCollectionLayout alloc] init];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 创建一个UIcollectionView对象
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    
    // 数据请求
    
    
    // 水平滚动时代表列最小间距
    flowLayout.minimumLineSpacing = 2;

//    // 水平滚动时代表行最小间距
    flowLayout.minimumInteritemSpacing =5;
    
     TXLog(@"水平间距%f", flowLayout.minimumInteritemSpacing);
    
    // 设置滚动方向
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, 185);
    
    self.flowLayout = flowLayout;
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册可重用标识
    [_collectionView registerClass:[TXSpotrCollectionViewCell class] forCellWithReuseIdentifier:@"TXSpotrCollectionViewCell"];
    
    // 设置是否显示滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置item距离分区边界的位置
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 5);
    
    [self.view addSubview:_collectionView];
    
   
    
}


#pragma mark -- collection dalegate and datasource
// 设置collection分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(15, 10, 10, 10);
}


// 设置item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    return _doulistsArray.count;
    return 9;
}

// 绘制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TXSpotrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TXSpotrCollectionViewCell" forIndexPath:indexPath];
    
    // 设置数据
    
    cell.nameLabel.text = @"刘亦菲我喜欢你";
    cell.scoreLabel.text = @"评分:9.0";
    
    return cell;
}
//
//// 设置每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//    return 5;
//}
//
//// 设置每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 5;
//}

// 设置选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    TXLog(@"点击了cell");
}

- (void)viewDidLayoutSubviews{

    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
