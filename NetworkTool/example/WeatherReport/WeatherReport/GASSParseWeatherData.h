//****************************************************
//  GASSParseWeatherData.h
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//****************************************************

#import <Foundation/Foundation.h>

#import "ZZUtilNetWork.h"

@class GASSWeatherForSixDays;

typedef void (^Success)(GASSWeatherForSixDays *resultArray);
typedef void (^Faile)(NSString *errorMsg);

@interface GASSParseWeatherData : NSObject<ZZUtilNetworkDelete>
{
    NSMutableDictionary *_weatherResult;
    Success sucessBlock;
    Faile   faileBlock;
}

@property (nonatomic,strong) NSMutableDictionary* weatherResult;

- (id)  initWithPath:(NSString *) path
             completionBlock:(void(^)(GASSWeatherForSixDays* result)) success
                   failBlock:(void(^)(NSString *errorMsg)) fail;
@end
