//*********************************************************
//  GASSAppDelegate.h
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-24.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************

#import <UIKit/UIKit.h>

@class GASSNotepadViewController;

@interface GASSAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GASSNotepadViewController *viewController;

@end
