//
//  GASSWeatherContentViewController.h
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZUtilNetWork.h"

@class GASSWeatherForSixDays;
@interface GASSWeatherContentViewController : UIViewController<ZZUtilNetworkDelete>

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           withObject:(GASSWeatherForSixDays*) object
             andIndex:(NSUInteger) aIndex;



@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay;
@property (weak, nonatomic) IBOutlet UIImageView *imageNight;
@property (weak, nonatomic) IBOutlet UILabel *weatherDay;
@property (weak, nonatomic) IBOutlet UILabel *weatherNight;
@property (weak, nonatomic) IBOutlet UILabel *tempDay;
@property (weak, nonatomic) IBOutlet UILabel *tempNight;
@property (weak, nonatomic) IBOutlet UILabel *windDay;
@property (weak, nonatomic) IBOutlet UILabel *windNight;


@property (strong,nonatomic) NSString *url;
@end
