//**********************************************************
//  GASSNotepadViewController.m
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-24.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************

#import <QuartzCore/QuartzCore.h>

#import "GASSNotepadViewController.h"
#import "GASSNotepadView.h"
#import "GASSCalloutViewPanelController.h"
#import "GASSCalloutViewPanel.h"
#import "GASSDrawTools.h"
#import "GASSFileRW.h"
#import "GASSConstants.h"

@interface GASSNotepadViewController ()

@property (nonatomic, weak  ) IBOutlet UINavigationItem *myNavigationItem; //导航按钮面板
@property (nonatomic, strong) GASSCalloutViewPanel  *callOutViewPanel;     //设置按钮面板
@property (nonatomic, strong) GASSCalloutViewPanelController *calloutViewPanelController; //设置按钮面板控制器类

- (void) notepadClearAction;
- (void) notepadSettingAction;
- (void) notepadSaveAction;

@end


@implementation GASSNotepadViewController
@synthesize callOutViewPanel = _callOutViewPanel;
@synthesize calloutViewPanelController = _calloutViewPanelController;


/*******************************************************************
*
*   函数描述：
*          初始化控制器
*   
*******************************************************************/
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.drawTools = [[GASSDrawTools alloc] init];
    }
    return self;
}
/*******************************************************************
 *
 *   函数描述：
 *          视图的定制 初始化
 *
 *******************************************************************/
- (void) addNotepadView
{
    if (self.notepadView == nil)
    {
        self.notepadView = [[GASSNotepadView alloc] initWithFrame:CGRectMake(0, 44, 700, 700)];
        self.notepadView.backgroundColor = [UIColor clearColor];
        self.notepadView.delegate = self.drawTools;
        [self.view addSubview:self.notepadView];
    }
}
- (void) configureCalloutView
{
    if (self.calloutViewPanelController == nil)
    {
        self.calloutViewPanelController = [[GASSCalloutViewPanelController alloc]
                                           initWithNibName:@"GASSCalloutViewPanelController"
                                                    bundle:nil
                                            viewController:self];
        self.calloutViewPanelController.view.frame = CGRectMake(560, 35, 350, 150);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(backgroundCalloutView)
                                                     name:KHideCallOutViewPanelNotification
                                                   object:nil];
    }
    [self.view addSubview:self.calloutViewPanelController.view];
    self.calloutViewPanelController.view.hidden = YES;
}

- (void) configureView
{
    //清空
    UIBarButtonItem *clear   = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(notepadClearAction)];
    //设置
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"Setting"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(notepadSettingAction)];
    
    //保存
    UIBarButtonItem *save  = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(notepadSaveAction)];
    
    [self.myNavigationItem setRightBarButtonItems:@[save,clear,setting]];
    
    
    //添加背景图片
    UIImageView *backgroundImageView = (UIImageView*)self.view;    
    backgroundImageView.image = [UIImage imageNamed:@"e.jpg"];
    
    //添加画图板View
    [self addNotepadView];
    
    [self configureCalloutView];
    
}
- (void) backgroundCalloutView
{
    self.calloutViewPanelController.view.hidden = YES;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
    
    
    
    //注册监听事件 保存文件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notepadSaveAction)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notepadSaveAction)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}
/*******************************************************************
 *
 *   函数描述：
 *         控制 功能按钮的实现
 *
 *******************************************************************/
- (void) notepadClearAction
{
    self.calloutViewPanelController.view.hidden = YES;
    
    if (self.notepadView != nil)
    {
        [self.notepadView clearView];
    }
    
    BOOL isExist =  [GASSFileRW fileIsExist:KNotepadSavePath];
    if (isExist == YES)
        [GASSFileRW removeFileAtPath:KNotepadSavePath];
}
- (void) notepadSettingAction
{
    self.calloutViewPanelController.view.hidden = !self.calloutViewPanelController.view.hidden;
}
- (void) notepadSaveAction
{
    self.calloutViewPanelController.view.hidden = YES;

//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
      UIGraphicsBeginImageContext(self.notepadView.bounds.size);
      [self.notepadView.layer renderInContext:UIGraphicsGetCurrentContext()];


	  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	  UIGraphicsEndImageContext();
      UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    
      //将得到的视图保存到文件中
      NSData * binaryImageData = UIImagePNGRepresentation(viewImage);
     [binaryImageData writeToFile:[GASSFileRW getFilePath:KNotepadSavePath] atomically:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.notepadView)
    {
        [self.notepadView removeFromSuperview];
    }
    self.notepadView      = nil;
    self.myNavigationItem = nil;
    self.calloutViewPanelController = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
