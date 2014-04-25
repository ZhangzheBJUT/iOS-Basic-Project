//***************************************************************
//  GASSDetailViewController.h
//  WeatherReport
//
//  Created by zhangzhe on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//***************************************************************/

#import <UIKit/UIKit.h>

@interface GASSDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSString* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *city;

@end
