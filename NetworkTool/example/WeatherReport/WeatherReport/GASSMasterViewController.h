//
//  GASSMasterViewController.h
//  WeatherReport
//
//  Created by yinrunmin on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GASSDetailViewController;

#import <CoreData/CoreData.h>

@interface GASSMasterViewController : UITableViewController
@property (strong, nonatomic) GASSDetailViewController   *detailViewController;
@end
