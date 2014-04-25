//*********************************************************
//  GASSWeatherForSixDays.h
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************

#import <Foundation/Foundation.h>

@interface GASSWeatherForSixDays : NSObject
{
    NSString *_city;    //城市名字
    NSString *_cityid;  //城市编号
    NSString *_date_y;  //年月日
    NSString *_week;    //星期
    
    NSMutableArray *_temp;     //温度
    NSMutableArray *_weather;  //天气
    NSMutableArray *_image;    //天气图片
    NSMutableArray *_img_title;//图片描述
    NSMutableArray *_wind;     //风
}
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *cityid;
@property(nonatomic,strong) NSString *date_y;
@property(nonatomic,strong) NSString *week;

@property(nonatomic,strong) NSMutableArray *temp;
@property(nonatomic,strong) NSMutableArray *weather;
@property(nonatomic,strong) NSMutableArray *image;
@property(nonatomic,strong) NSMutableArray *img_title;
@property(nonatomic,strong) NSMutableArray *wind;
@end
