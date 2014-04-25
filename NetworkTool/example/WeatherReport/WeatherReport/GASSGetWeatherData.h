//**********************************************************
//  GASSGetWeatherData.h
//  WeatherReport
//
//  Created by zhangzhe on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//**********************************************************/

#import <Foundation/Foundation.h>
@interface GASSGetWeatherData : NSObject
+ (BOOL)      getWeatherData:(NSMutableDictionary*) jsonDictionary withURL:(NSString*) url;
+ (UIImage *) getImageFromURL:(NSString*) index;
@end
