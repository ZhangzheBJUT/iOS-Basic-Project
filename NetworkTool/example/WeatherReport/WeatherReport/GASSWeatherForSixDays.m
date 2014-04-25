//*********************************************************
//  GASSWeatherForSixDays.m
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************

#import "GASSWeatherForSixDays.h"

@implementation GASSWeatherForSixDays
@synthesize  city;
@synthesize  cityid;
@synthesize  date_y;
@synthesize  week;
@synthesize  temp;
@synthesize  weather;
@synthesize  image;
@synthesize  img_title;
@synthesize  wind;

- (NSMutableArray*) temp
{
    if (_temp == nil)
    {
        _temp = [[NSMutableArray alloc] init];
    }
    
    return _temp;
}
- (NSMutableArray*) weather
{
    if (_weather == nil)
    {
        _weather = [[NSMutableArray alloc] init];
    }
    
    return _weather;
}
- (NSMutableArray*) image
{
    if (_image == nil)
    {
        _image = [[NSMutableArray alloc] init];
    }
    
    return _image;
}
- (NSMutableArray*) img_title
{
    if (_img_title == nil)
    {
        _img_title = [[NSMutableArray alloc] init];
    }
    
    return _img_title;
}
- (NSMutableArray*) wind
{
    if (_wind == nil)
    {
        _wind = [[NSMutableArray alloc] init];
    }
    
    return _wind;
}
@end
