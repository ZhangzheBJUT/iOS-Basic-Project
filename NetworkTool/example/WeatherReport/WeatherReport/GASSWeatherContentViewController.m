//
//  GASSWeatherContentViewController.m
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import "GASSWeatherContentViewController.h"
#import "GASSWeatherForSixDays.h"
#import "ZZUtilNetWork.h"

@interface GASSWeatherContentViewController ()
@property (assign,nonatomic) NSUInteger index;
@property (weak,nonatomic)   GASSWeatherForSixDays *weatherForSixDays;

@end

@implementation GASSWeatherContentViewController
@synthesize index;
@synthesize weatherForSixDays = _weatherForSixDays;
@synthesize url = _url;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           withObject:(GASSWeatherForSixDays*) object
             andIndex:(NSUInteger) aindex
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.weatherForSixDays = object;
        index = aindex;
    }
    return self;
}
- (NSString *) weakName:(NSUInteger) integer
{
    NSString *result = nil;
    switch (integer)
    {
        case 0:
            result =  @"日";
            break;
        case 1:
            result = @"一";
            break;
        case 2:
            result = @"二";
            break;
        case 3:
            result = @"三";
            break;
        case 4:
            result = @"四";
            break;
        case 5:
            result = @"五";
            break;
        case 6:
            result = @"六";
            break;
        default:
            break;
    }
    return result;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //显示日期
    NSCalendar* cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit |NSWeekdayCalendarUnit;
    NSDateComponents* comp;
    NSDate *date    = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:3600*24*index];
    comp  = [cal components:unitFlags fromDate:newDate];
    self.date.text = [NSString stringWithFormat:@"%d月 %d日 星期%@",
                      comp.month,comp.day,[self weakName:comp.weekday-1]];

    //显示天气情况
    NSString *myWeather = [self.weatherForSixDays.weather objectAtIndex:index];
    NSArray  *WeatherDayAndNight = [myWeather componentsSeparatedByString:@"转"];

    
    self.weatherDay.text   = [WeatherDayAndNight objectAtIndex:0];
    self.weatherNight.text = [WeatherDayAndNight objectAtIndex:[WeatherDayAndNight count]-1];

    //显示温度
    NSString *myTemp = [self.weatherForSixDays.temp objectAtIndex:index];
    NSArray  *tempDayAndNight = [myTemp componentsSeparatedByString:@"~"];
    self.tempDay.text  =  [NSString stringWithFormat:@"最高温度:%@",[tempDayAndNight objectAtIndex:0]];
    self.tempNight.text =[NSString stringWithFormat:@"最低温度:%@",[tempDayAndNight objectAtIndex:1]];

    //显示风的情况
    self.windDay.text   = [self.weatherForSixDays.wind objectAtIndex:index];
    self.windNight.text = [self.weatherForSixDays.wind objectAtIndex:index];
     
    //显示天气图片
    NSString *myPic1 = [self.weatherForSixDays.image objectAtIndex:index*2];
    NSString *url = [NSString stringWithFormat:@"%@/%@.gif",BASEURL,myPic1];
    NSURL *URL  = [NSURL URLWithString:url];
    NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:URL];
    [ZZUtilNetwork ImageDataWithRequest:requst Size:CGSizeMake(1, 1) Tag:3 Object:self];

   // [self.imageDay setImage:[GASSGetWeatherData getImageFromURL:myPic1 ]];
    
    NSString *myPic2 = [self.weatherForSixDays.image objectAtIndex:index*2+1];
    if ([myPic2 isEqualToString:@"99"] == YES)
    {
        NSString *url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif",myPic1];
        NSURL *URL  = [NSURL URLWithString:url];
        NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:URL];
        [ZZUtilNetwork ImageDataWithRequest:requst Size:CGSizeMake(1, 1) Tag:0 Object:self];
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif",myPic2];
        NSURL *URL  = [NSURL URLWithString:url];
        NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:URL];
        [ZZUtilNetwork ImageDataWithRequest:requst Size:CGSizeMake(1, 1) Tag:1 Object:self];
    }
}
- (void) ImageDataDone:(UIImage*) image withTag:(NSInteger) tag
{
    if (image != nil && tag==0)
    {
        [self.imageNight setImage:image];
        return;
    }
    
    if (image !=nil && tag==1)
    {
        [self.imageNight setImage:image];
        return;

    }
    if (image != nil && tag ==3)
    {
        [self.imageDay setImage: image];
        return;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
