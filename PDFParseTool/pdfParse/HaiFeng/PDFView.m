//
//  PDFView.m
//  PDFView01
//
//  Created by iPhone on 11-3-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFView.h"
#import "PDFShowDelegate.h"
#import "PDFShowDelegateImp.h"
#import "HFViewController.h"

@implementation PDFView
@synthesize flag = _flag;
@synthesize pdfShowDelegate = _pdfShowDelegate;
@synthesize viewController = _viewController;
@synthesize isClick = _isClick;
@synthesize lastPreviousPoint = _lastPreviousPoint;
@synthesize lastCurrentPoint  = _lastCurrentPoint;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;
//----------------------------------------------------------------
//  -(id)initWithFrame:(CGRect)frame
//        Initializes and returns a newly allocated view object
//          with the specified frame rectangle.
//----------------------------------------------------------------

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if(self != nil)
	{
		self.backgroundColor = [UIColor clearColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = YES;
		self.isClick = YES;
        
       self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    
	return self;
}
- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    if (self.isClick == NO)
    {
        [self.viewController hiddenViews];
        self.isClick = YES;
    }
    else
    {
        [self.viewController showViews];
        self.isClick = NO;
    }

}
//----------------------------------------------------------------
// -(void)drawRect:(CGRect)rect
//     draw the content within the passed-in rectangle.
//----------------------------------------------------------------
-(void)drawRect:(CGRect)rect
{
	[self.pdfShowDelegate updateView:UIGraphicsGetCurrentContext()];
}

#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.lastPreviousPoint = point;
    self.lastCurrentPoint = point;

	self.flag = YES;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
	
	if (self.flag == NO)
		return;
	
//	if (self.lastCurrentPoint.x - point.x>5.0f && self.lastCurrentPoint.y - point.y > 20.0f)
//	{
//		[self.pdfShowDelegate goDownPage];
//		self.flag = NO;
//	}
//	if (point.x - self.lastCurrentPoint.x >5.0f && point.y-self.lastCurrentPoint.y > 20.0f)
//	{
//		[self.pdfShowDelegate goUpPage];
//		self.flag = NO;
//	}
//	else 
//	{
//        return;
//	}
    if (self.lastCurrentPoint.x - point.x>17.0f)
	{
		[self.pdfShowDelegate goDownPage];
		self.flag = NO;
	}
	if (point.x - self.lastCurrentPoint.x >17.0f)
	{
		[self.pdfShowDelegate goUpPage];
		self.flag = NO;
	}
	else
	{
	}

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    self.lastCurrentPoint = [touch locationInView:self];
	
	if (((self.lastPreviousPoint.x-self.lastCurrentPoint.x)*(self.lastPreviousPoint.x-self.lastCurrentPoint.x)
		+(self.lastPreviousPoint.y-self.lastCurrentPoint.y)*(self.lastPreviousPoint.y-self.lastCurrentPoint.y))<10.0f)
	{
    }
	self.flag = YES;
	
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc 
{	self.viewController = nil;	
}

@end
