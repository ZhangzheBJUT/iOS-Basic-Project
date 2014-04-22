//*******************************************************
//  GASSCalloutViewPanelController.m
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-25.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*******************************************************/

#import "GASSCalloutViewPanelController.h"
#import "GASSNotepadViewController.h"
#import "GASSDrawTools.h"
#import "GASSNotepadView.h"

#define KRedString     @"red.png"
#define KRedTag        0

#define KGreenString   @"green.png"
#define KGreenTag      1

#define KBlueString    @"blue.png"
#define KBlueTag       2

#define KYellowString  @"yellow.png"
#define KYellowTag     3

#define KPinkString    @"pink.png"
#define KPinkTag       4

#define KEraseString   @"eraser.png"
#define KEraseTag      5

@interface GASSCalloutViewPanelController ()

@property (nonatomic,weak) GASSNotepadViewController *notepadViewController;

- (void) sliderChange:(UISlider*)slider;
- (void) colorBtnPress:(UIButton*)btn;

@end

@implementation GASSCalloutViewPanelController
@synthesize notepadViewController = _notepadViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       viewController:(GASSNotepadViewController*) notepadViewController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.notepadViewController = notepadViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景颜色
    UIButton *bkView = (UIButton*)self.view;
    bkView.bounds = CGRectMake(0, 0, 350, 150);
    [bkView setImage:[UIImage imageNamed:@"calloutBackground02.png"]
            forState:UIControlStateNormal];bkView.alpha = .8f;
    //定制视图
    [self configureView];
}
- (void) configureView
{
    int tempColorButtonLength  = 43;
    int tempColorButtonY       = 66;
    int tempColorButtonBetween = tempColorButtonLength + 14;
    int firstColorButtonX      = 10;
    
    //****************UISlider*********************
    UISlider *slider= [[UISlider alloc] initWithFrame: CGRectMake(10,20,270, 30)];
    slider.minimumValue = -8;
    slider.maximumValue = 20;
    slider.value = self.notepadViewController.drawTools.strokeWidth;
    [slider addTarget: self action: @selector(sliderChange:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    //****************Red Button*********************
    UIButton *btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX, tempColorButtonY, tempColorButtonLength, tempColorButtonLength)];
    [btn setImage:[UIImage imageNamed:KRedString]
                             forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KRedTag;
	[self.view addSubview:btn];
    
     //****************Green Button*********************
    btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX+4*tempColorButtonBetween, tempColorButtonY, tempColorButtonLength, tempColorButtonLength)];
    [btn setImage:[UIImage imageNamed:KGreenString]
         forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KGreenTag;
	[self.view addSubview:btn];
    
    //****************Green Button*********************
    btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX+3*tempColorButtonBetween, tempColorButtonY, tempColorButtonLength, tempColorButtonLength)];
    [btn setImage:[UIImage imageNamed:KBlueString]
         forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KBlueTag;
	[self.view addSubview:btn];
    
    //****************Yelow Button*********************
    btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX+2*tempColorButtonBetween, tempColorButtonY, tempColorButtonLength, tempColorButtonLength)];
    [btn setImage:[UIImage imageNamed:KYellowString]
         forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KYellowTag;
	[self.view addSubview:btn];
    
    //****************Pink Button*********************
    btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX+tempColorButtonBetween, tempColorButtonY, tempColorButtonLength, tempColorButtonLength)];
    [btn setImage:[UIImage imageNamed:KPinkString]
         forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KPinkTag;
	[self.view addSubview:btn];
    
    //****************Erase Button*********************
    btn= [[UIButton alloc]  initWithFrame: CGRectMake(firstColorButtonX+5*tempColorButtonBetween, tempColorButtonY, 40, 50)];
    [btn setImage:[UIImage imageNamed:KEraseString]
         forState:UIControlStateNormal];
	[btn addTarget: self
            action: @selector(colorBtnPress:)
  forControlEvents: UIControlEventTouchUpInside];
	btn.tag = KEraseTag;
	[self.view addSubview:btn];
}
- (void) sliderChange:(UISlider*)slider
{
    self.notepadViewController.drawTools.strokeWidth = slider.value;
}
-(void) colorBtnPress:(UIButton*)btn
{
    self.notepadViewController.notepadView.blendModel = kCGBlendModeNormal;
	switch (btn.tag)
	{
		case 0:
	        self.notepadViewController.drawTools.strokeColor = [UIColor redColor];
			break;
		case 1:
            self.notepadViewController.drawTools.strokeColor = [UIColor greenColor];
            break;
		case 2:
	        self.notepadViewController.drawTools.strokeColor = [UIColor blueColor];
			break;
		case 3:
	        self.notepadViewController.drawTools.strokeColor = [UIColor yellowColor];
			break;
		case 4:
	        self.notepadViewController.drawTools.strokeColor = [UIColor colorWithRed: 0.95 green: 0.5
                                                                                blue: 0.92 alpha: 1];
			break;
		case 5:
            self.notepadViewController.notepadView.blendModel = kCGBlendModeClear;
            self.notepadViewController.drawTools.strokeColor = [UIColor clearColor];
			break;
		default:
			break;
	}

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.notepadViewController  = nil;
}
- (void) dealloc
{
    self.notepadViewController  = nil;
}
@end
