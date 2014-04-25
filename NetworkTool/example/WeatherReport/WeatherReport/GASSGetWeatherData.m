//**********************************************************
//  GASSGetWeatherData.m
//  WeatherReport
//
//  Created by zhangzhe on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//**********************************************************/

#import "GASSGetWeatherData.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@implementation GASSGetWeatherData

+ (BOOL) getWeatherData:(NSMutableDictionary*) jsonDictionary withURL:(NSString*) url
{
    
    NSURL *baseURL  = [NSURL URLWithString:BASEURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    NSDictionary * params = @{@"Accept": @"Application/Json, text/Json"};
    
    [httpClient getPath:url
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *result  = [NSString stringWithUTF8String:[responseObject bytes]];
         NSData *data      =  [result dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableLeaves
                                                               error:nil];
         [jsonDictionary addEntriesFromDictionary:dict];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {

         NSLog(@"#########Error retrieving data: %@", error);
     }];
    
    
   return YES;
}
+ (UIImage *) getImageFromURL:(NSString*) index
{
    NSString *url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif",index];
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    result = [UIImage imageWithData:data];
        
    return result;
}
@end
