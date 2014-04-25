//****************************************************
//  GASSParseWeatherData.m
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//****************************************************

#import "GASSParseWeatherData.h"
#import "GASSWeatherForSixDays.h"

#define WEATERRESULT @"weatherinfo"

@implementation GASSParseWeatherData
@synthesize weatherResult = _weatherResult;

-(NSMutableDictionary*) weatherResult
{
    if (nil == _weatherResult)
    {
        _weatherResult = [[NSMutableDictionary alloc] init];
    }
    
    return _weatherResult;
}

- (id)  initWithPath:(NSString *) path
             completionBlock:(void(^)(GASSWeatherForSixDays * result)) success
                   failBlock:(void(^)(NSString *errorMsg)) fail
{
    if (self = [super init])
    {
        sucessBlock = success;
        faileBlock  = fail;
        
        [self performSelectorInBackground:@selector(generateModels:)
                               withObject:path];
    }
    return self;
}
/*****************************************************************
 * 函数描述：
 *        对外访问的接口，产生Zone对象数组。
 *
 ******************************************************************/
-(void) generateModels:(NSString *) path
{
    NSDictionary * params = @{@"Accept": @"Application/Json, text/Json"};
    
    [ZZUtilNetwork JSONDataWithBasedURL:BASEURL Path:path Params:params Object:self];
}
#pragma mark -
#pragma mark ZZUtilNewtorkdDelegate
- (void) GetDataDone:(id)data
{
    if (data == nil)
    {
        faileBlock(@"网络连接发生错误");
        return;
    }
    [self.weatherResult addEntriesFromDictionary:(NSMutableDictionary*)data];
    [self parse];
}

-(void) parse
{
    if (self.weatherResult == nil || self.weatherResult.count==0)
    {
        faileBlock(@"数据错误");
        return;
    }
    NSDictionary *parts   = [self.weatherResult objectForKey:WEATERRESULT];
    
    GASSWeatherForSixDays *weatherObject = [[GASSWeatherForSixDays alloc] init];
    weatherObject.city    = [NSString stringWithString:[parts objectForKey:@"city"]];
    weatherObject.cityid  = [NSString stringWithString:[parts objectForKey:@"cityid"]];
    weatherObject.date_y  = [NSString stringWithString:[parts objectForKey:@"date_y"]];
    weatherObject.week    = [NSString stringWithString:[parts objectForKey:@"week"]];
    
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp1"]]];
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp2"]]];
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp3"]]];
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp4"]]];
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp5"]]];
    [weatherObject.temp addObject:[NSString stringWithString:[parts objectForKey:@"temp6"]]];
    
    
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather1"]]];
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather2"]]];
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather3"]]];
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather4"]]];
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather5"]]];
    [weatherObject.weather addObject:[NSString stringWithString:[parts objectForKey:@"weather6"]]];
    
    
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img1"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img2"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img3"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img4"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img5"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img6"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img7"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img8"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img9"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img10"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img11"]]];
    [weatherObject.image addObject:[NSString stringWithString:[parts objectForKey:@"img12"]]];
    
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title1"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title2"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title3"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title4"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title5"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title6"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title7"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title8"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title9"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title10"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title11"]]];
    [weatherObject.img_title addObject:[NSString stringWithString:[parts objectForKey:@"img_title12"]]];
    
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind1"]]];
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind2"]]];
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind3"]]];
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind4"]]];
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind5"]]];
    [weatherObject.wind addObject:[NSString stringWithString:[parts objectForKey:@"wind6"]]];
    
    sucessBlock(weatherObject);

}
@end
