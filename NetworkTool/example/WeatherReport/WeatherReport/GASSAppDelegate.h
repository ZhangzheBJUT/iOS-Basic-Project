//*******************************************************
//  GASSAppDelegate.h
//  WeatherReport
//
//  Created by zhangzhe on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*******************************************************/

#import <UIKit/UIKit.h>

@interface GASSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
