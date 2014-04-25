//***************************************************************
//  GASSDetailViewController.m
//  WeatherReport
//
//  Created by zhangzhe on 13-5-29.
//  Copyright (c) 2013年 com.test. All rights reserved.
//***************************************************************/

#import "GASSDetailViewController.h"
#import "GASSWeatherForSixDays.h"
#import "GASSWeatherContentViewController.h"
#import "GASSParseWeatherData.h"

@interface GASSDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) GASSWeatherForSixDays *obj;
@property (strong, nonatomic) NSMutableArray *subViews;
- (void)configureView;

@end

@implementation GASSDetailViewController
@synthesize obj = _obj;
@synthesize subViews = _subViews;

#pragma mark - Managing the detail item
-(NSMutableArray*) mutableArray
{
    if (nil == _subViews) {
        _subViews = [NSMutableArray array];
    }
    
    return _subViews;
}
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        [self configureView];
    }

    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}
- (void)configureView
{
    if (self.detailItem == nil)
    {
        return;
    }
    
    // Update the user interface for the detail item.
    void (^Success)(GASSWeatherForSixDays* result) = ^(GASSWeatherForSixDays* result)
    {
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
        if (result == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WeatherReport"
                                                            message:@"No Data."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
            [alert show];

        }
        //self.obj = [[GASSWeatherForSixDays alloc] init];
        self.obj = result;
        self.city.text = [NSString stringWithFormat:@"%@ 天气预报",self.obj.city ];
        

        for (int i=0; i<self.subViews.count; i++)
        {
            [[self.subViews objectAtIndex:i] removeFromSuperview];
        }
        [self.subViews removeAllObjects];
            
        for(int i=0; i<self.obj.temp.count; ++i)
        {
            
            GASSWeatherContentViewController *contentViewController =
            [[GASSWeatherContentViewController alloc]initWithNibName:@"GASSWeatherContentViewController"
                                                              bundle:nil
                                                          withObject:self.obj
                                                            andIndex:i];
            contentViewController.url = self.detailItem;
            
            CGSize size = CGSizeMake(contentViewController.view.bounds.size.width,
                                     contentViewController.view.bounds.size.height);
            contentViewController.view.frame = CGRectMake(0.0, 50+size.height*i, size.width, size.height);
            
            [self.subViews addObject:contentViewController.view];
            [self.view addSubview:contentViewController.view];
        }
            
      });
        
    };
    
    void (^Fail) (NSString *errorMsg) = ^(NSString *errorMsg)
    {
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WeatherReport"
                                                            message:errorMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
            [alert show];});
    };
    
    
    GASSParseWeatherData *parse = [[GASSParseWeatherData alloc] initWithPath:self.detailItem completionBlock:Success failBlock:Fail];
    parse = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
