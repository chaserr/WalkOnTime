//
//  SuggestOfBackViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//  使用系统自带的地图

#import "SuggestOfBackViewController.h"
#import <MapKit/MapKit.h>
@interface SuggestOfBackViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *mgr;

@property (nonatomic, strong) CLGeocoder *geocode; // 反地理编码

@end

@implementation SuggestOfBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"当前位置";
    
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 设置地图显示类型
    _mapView.mapType = MKMapTypeStandard;
    
    [self.view addSubview:_mapView];
    
    // 设置不允许地图旋转
    self.mapView.rotateEnabled = NO;
    
    // 成为mapView的代理
    self.mapView.delegate = self;
    
    // 如果想利用MapKit获取用户的位置, 可以追踪
    /*
     typedef NS_ENUM(NSInteger, MKUserTrackingMode) {
     MKUserTrackingModeNone = 0, 不追踪/不准确的
     MKUserTrackingModeFollow, 追踪
     MKUserTrackingModeFollowWithHeading, 追踪并且获取用的方向
     }
     */
    // 注意:在ios8中如果想追踪用户的位置,必须自己主动请求隐私权限
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 主动请求权限
        TXLog(@"允许追踪位置成功");
        self.mgr = [[CLLocationManager alloc] init];
        [_mgr requestAlwaysAuthorization];
    }
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    

    
}


#pragma mark -- MKMapViewDelegate
/*!
 *  @author 朝夕
 *
 *  @brief 每次更新到用户的位置就会调用(调用不频繁,只有位置改变才会调用)
 *
 *  @param mapView      促发事件的控件
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    /*
     地图上蓝色的点就称之为大头针
     大头针可以拥有标题/子标题/位置信息
     大头针上显示什么内容由大头针模型确定(MKUserLocation)
     */
    // 设置大头针显示的内容
//        userLocation.title = @"刘亦菲";
//        userLocation.subtitle = @"北京";

#pragma mark -- 利用反地理编码设置用户当前位置
    
    [self.geocode reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        
        userLocation.title = placeMark.name;
        userLocation.subtitle = placeMark.locality;
    }];
    
//    // 移动地图到当前用户位置
//    // 获取用户当前所在的位置的经纬度,并且设置为地图的中心点
//    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图显示区域
    CLLocationCoordinate2D centerCoordinate = userLocation.location.coordinate; // 用户的位置
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1); // 指定经纬度跨度
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // 设置显示区域
    [self.mapView setRegion:region animated:YES];
    
    

    
    
}


// 懒加载
- (CLGeocoder *)geocode{
    
    if (!_geocode) {
        self.geocode = [[CLGeocoder alloc] init];
    }
    return _geocode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
