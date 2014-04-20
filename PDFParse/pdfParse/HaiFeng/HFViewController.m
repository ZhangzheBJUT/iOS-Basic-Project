//**************************************************************/
//  HFViewController.m
//  HaiFeng
//
//  Created by zhangzhe on 13-12-26.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//**************************************************************/

#import "HFViewController.h"
#import "GASSBusyLoadingView.h"
#import "PDFShowDelegateImp.h"
#import "PDFView.h"
#import "PaginationView.h"
#import "HFIndexViewController.h"

#define  PDFName  @"haifeng"
#define  PositionY 685

@interface HFViewController ()
@property (nonatomic,strong) PaginationView *pageView;
@property (nonatomic,strong) NSMutableArray *indexList;
@end

@implementation HFViewController
@synthesize pdfView         = _pdfView;
@synthesize total           = _total;
@synthesize current         = _current;
@synthesize pageSlider      = _pageSlider;
@synthesize pageView        = _pageView;
@synthesize pageNumberShow  = _pageNumberShow;
@synthesize indexList       = _indexList;


#pragma mark -
#pragma mark Lazying Making
-(NSMutableArray*) indexList
{
    if (_indexList == nil) {
        _indexList = [[NSMutableArray alloc] init];
    }
    
    return _indexList;
}
#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"index02"
                                                       ofType:@"plist"]];
    [self.indexList addObjectsFromArray:array];
 
    
    self.current = 1;
    self.total   = 0;
    self.title = @"海丰通航";
    
    [self DrawPdfView];
    [self ShowPageSlider];
    [self ShowPageView];
    [self showPageNumber];
    
    UIBarButtonItem *index = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"index.png"]
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(showIndex)];
    NSArray *itemArray = @[index];
    [self.navigationItem setLeftBarButtonItems:itemArray animated:YES];
     self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self hiddenViews];
}

-(void) hiddenViews
{
    self.navigationController.navigationBar.hidden = YES;
    self.pageSlider.hidden = YES;
}
-(void) showViews
{
    self.navigationController.navigationBar.hidden = NO;
    self.pageSlider.hidden  = NO;
}
- (void) UpdateView:(NSInteger) PageNum
{
    self.current = PageNum;
    [self ShowPageSlider];
    [self showPageNumber];
}
#pragma mark -
#pragma mark Configure Views
- (void) DrawPdfView
{
    if (self.pdfView == nil)
	{
		self.pdfView = [[PDFView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024, 768)];
		self.pdfView.viewController = self;
	}
    [self.view addSubview:self.pdfView];
	
    self.pdfView.pdfShowDelegate = [[PDFShowDelegateImp alloc] initWithView:self.pdfView];
    self.total = self.pdfView.pdfShowDelegate.pageNumber;
    self.current = 1;
    [self.pdfView.pdfShowDelegate goToPage:1];
}
- (void) ShowPageView
{
    if (self.pageView == nil)
    {
        self.pageView = [[PaginationView alloc] initWithFrame:CGRectMake(1024/2-150, PositionY, 300, 42)];
        [self.view addSubview:self.pageView];
    }
    self.pageView.hidden = YES;
}
-(void) ShowPageSlider
{
    if (self.pageSlider == nil) {
        self.pageSlider = [[UISlider alloc] initWithFrame:CGRectMake(1024/2-400, PositionY+40, 800, 20)];
        self.pageSlider.minimumValue = 1;
        self.pageSlider.maximumValue = self.total;
        [self.view addSubview:self.pageSlider];
    }
	self.pageSlider.value = self.current;
	
	UIImage *image = [UIImage imageNamed:@"slider_14.png"];
	[self.pageSlider setThumbImage:image forState:UIControlStateNormal];
	[self.pageSlider setThumbImage:image forState:UIControlStateHighlighted];
	
    [self.pageSlider addTarget:self  action:@selector(updateValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSlider addTarget:self action:@selector(valueChange:)  forControlEvents: UIControlEventValueChanged];
    [self.pageSlider addTarget:self action:@selector(sliderPress) forControlEvents:UIControlEventTouchDown];
    [self.pageSlider addTarget:self action:@selector(sliderUp) forControlEvents:UIControlEventTouchUpInside];
    [self.pageSlider addTarget:self action:@selector(sliderUp) forControlEvents:UIControlEventTouchUpOutside];
    
}
- (void) showPageNumber
{
    if (self.pageNumberShow == nil) {
        
        self.pageNumberShow = [[GASSBusyLoadingView  alloc] initWithFrame:CGRectMake(1024/2-20, PositionY+60, 41, 20)];
        [self.view addSubview:self.pageNumberShow];
    }
    self.pageNumberShow.totalPage = self.total;
    [self.pageNumberShow updateShow:self.current];
}
#pragma mark -
#pragma mark Perform Segue && BarItem Action
- (void) showIndex
{
     [self performSegueWithIdentifier:@"myindex" sender:self];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UINavigationController *destination = (UINavigationController *)segue.destinationViewController;
    HFIndexViewController *indexViewController = (HFIndexViewController *)destination.viewControllers[0];
    
    if (destination != nil)
    {
        indexViewController.viewController = self;
    }
}
- (void) goToPage:(NSInteger) PageNum
{
    [self.pdfView.pdfShowDelegate goToPage:PageNum];
    [self hiddenViews];
    self.current = PageNum;
    [self ShowPageSlider];
    [self showPageNumber];
}
#pragma mark -
#pragma mark Slider Delegate
- (void)sliderPress
{
    self.pageView.hidden  = NO;
}
- (void)sliderUp
{
    self.pageView.hidden  = YES;
    
    UISlider *slider = self.pageSlider;
    int progressAsInt = (int)(slider.value);

    if (self.current != progressAsInt) {
        self.current = self.pageSlider.value;
        [self updateValue:self.pageSlider];
    }
}
-(void) valueChange:(UISlider *)slider
{
    int progressAsInt = (int)(slider.value);
    NSString *content = nil;
    
    if (self.indexList != nil) {
        content =   [self.indexList objectAtIndex:progressAsInt-1];
    }
    NSString *currentPageInfo = [[NSString alloc] initWithFormat:@"%@",content];
    NSString *currentPageNumber = [[NSString alloc] initWithFormat:@"第%d页",progressAsInt];
    
    self.pageView.totalPage.text = currentPageInfo;
    self.pageView.currentPage.text = currentPageNumber;
}
-(void) updateValue:(UISlider*) sender
{
	UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value);
    
    [self.pdfView.pdfShowDelegate goToPage:progressAsInt];
    self.current = progressAsInt;
    [self.pageNumberShow updateShow:self.current];

}
#pragma mark -
#pragma mark Memory Control
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void) dealloc
{
}
@end
