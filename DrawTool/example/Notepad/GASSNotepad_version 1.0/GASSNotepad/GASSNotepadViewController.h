//**********************************************************
//  GASSNotepadViewController.h
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-24.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************

#import <UIKit/UIKit.h>

@class GASSDrawTools;
@class GASSNotepadView;

@interface GASSNotepadViewController : UIViewController

@property (nonatomic, strong) GASSNotepadView *notepadView;   //绘图板视图类
@property (nonatomic, strong) GASSDrawTools   *drawTools;     //绘图工具类


@end
