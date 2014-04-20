//
//  PDFShowDelegateImp.m
//  PDFView01
//
//  Created by zhangzhe on 11-5-18.
//  Copyright 2011 zhangzhe. All rights reserved.
//

#import "PDFShowDelegateImp.h"
#import "PDFView.h"
#import "HFViewController.h"

#define kTransitionDuration	0.30
#define  PDFName  @"haifeng"

@interface PDFShowDelegateImp()
-(void) MyGetPDFDocumentRef;
-(void) animationTransition: (UIViewAnimationTransition)transition  forView:(UIView*) aView;
@end

@implementation PDFShowDelegateImp
@synthesize  pdfView=_pdfView;
@synthesize  currentPageNumber=_currentPageNumber;
@synthesize  totalPageNumber=_totalPageNumber;
@synthesize  pdfDocument = _pdfDocument;
@synthesize  viewBounds = _viewBounds;


-(id) initWithView:(UIView *)aView;
{
	self = [super init];
	
    if (self != nil)
    {
		self.pdfView =  (PDFView*)aView;
		self.viewBounds = aView.bounds;
		[self MyGetPDFDocumentRef];
    }
    return self;
	
}
//----------------------------------------------------------------
//  -(void) MyGetPDFDocumentRef
//      Get the specific pdf file from main bundle.
//----------------------------------------------------------------
-(void) MyGetPDFDocumentRef
{
	CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("haifeng.pdf"), NULL, NULL);
	self.pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
	CFRelease(pdfURL);
	self.totalPageNumber  = CGPDFDocumentGetNumberOfPages(self.pdfDocument);
}
//----------------------------------------------------------------
//  -(void)drawInContext:(CGContextRef)context
//      draw the  pdf file in the graphic context
//----------------------------------------------------------------
-(void)drawInContext:(CGContextRef) context
{
	// Grab the first PDF page
	CGPDFPageRef pageRef = CGPDFDocumentGetPage(self.pdfDocument, self.currentPageNumber);
	
	CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
	
	CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFMediaBox);
	
	CGContextFillRect(context,pageRect);
	CGContextSaveGState(context);
	
	CGContextTranslateCTM(context,-13, self.viewBounds.size.width+77);
	CGContextScaleCTM(context,1.35, -1.4);
	//CGContextTranslateCTM(context, -15,0);
	// We're about to modify the context CTM to draw the PDF page where we want it, 
	//so save the graphics state in case we want to do more drawing
	CGContextSaveGState(context);
	// CGPDFPageGetDrawingTransform provides an easy way to get the transform for a PDF page. It will scale down to fit, including any
	// base rotations necessary to display the PDF page correctly. 
	CGRect frame = CGRectMake(0,0,self.viewBounds.size.height*1.0,self.viewBounds.size.width*1.0);
	
	CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(pageRef, kCGPDFCropBox, frame, 0, true);
	// And apply the transform.
	CGContextConcatCTM(context, pdfTransform);
	CGContextDrawPDFPage(context, pageRef);
	CGContextRestoreGState(context);
}
-(int) pageNumber
{
	return self.totalPageNumber;
}
//----------------------------------------------------------------
//  -(void) goUpPage
//      go to previous page
//----------------------------------------------------------------
-(void) goUpPage
{
	if (self.currentPageNumber == 1)
		return;
	
	self.currentPageNumber--;
	
	[self animationTransition:UIViewAnimationTransitionCurlDown forView:self.pdfView];
	[self.pdfView setNeedsDisplay];
    
    
    [self.pdfView.viewController UpdateView:self.currentPageNumber];
}
//----------------------------------------------------------------
//  -(void) goDownPage
//      go to next page
//----------------------------------------------------------------
-(void)goDownPage
{
	if (self.currentPageNumber == self.totalPageNumber)
		return;
	
	self.currentPageNumber++;
    
	[self animationTransition:UIViewAnimationTransitionCurlUp forView:self.pdfView];
	[self.pdfView setNeedsDisplay];
    
    [self.pdfView.viewController UpdateView:self.currentPageNumber];
}

//----------------------------------------------------------------
//  -(void) goToPage: (int) pageNumber
//      go to specific page
//----------------------------------------------------------------
-(void) goToPage: (int) pageNumber
{
	if (pageNumber>0 && pageNumber<=self.totalPageNumber)
		self.currentPageNumber = pageNumber;
    
    (self.pdfView.isClick==YES)?(self.pdfView.isClick=NO):(self.pdfView.isClick=YES);
    
	[self.pdfView setNeedsDisplay];
}
//----------------------------------------------------------------
//  -(void) updateView: (CGContextRef) context
//    to update the specificed view context.
//----------------------------------------------------------------
-(void) updateView: (CGContextRef) context
{
	[self drawInContext:context];
}
//----------------------------------------------------------------
//  -(void) animationTransition: (UIViewAnimationTransition)
//          transition  forView:(UIView*) aView
//     to set animation transition.
//----------------------------------------------------------------
-(void) animationTransition: (UIViewAnimationTransition)transition  forView:(UIView*) aView 
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: kTransitionDuration];
	[UIView setAnimationTransition:transition forView:aView cache:YES];
	[UIView commitAnimations];
}
-(void) dealloc
{
    self.pdfDocument = nil;
    self.pdfView = nil;
}
@end
