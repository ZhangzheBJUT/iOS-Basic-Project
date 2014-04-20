//
//  PaginationView.m
//  FlowerGallery
//
//  Created by zhangzhe on 11-5-18.
//  Copyright 2011 zhangzhe. All rights reserved.
//

#import "PaginationView.h"
#import <QuartzCore/QuartzCore.h>
@interface PaginationView() 
-(void) configureView;
@end

@implementation PaginationView
@synthesize totalPage   = _totalPage;
@synthesize currentPage = _currentPage;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
		self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
		[self  configureView];
    }
    return self;
}
-(void) configureView
{
	CGRect rect01 = CGRectMake(1, 0, 300, 30);
	CGRect rect02 = CGRectMake(1, 29, 300, 10);
	
	self.totalPage = [[UILabel alloc] initWithFrame:rect01];
	self.currentPage = [[UILabel alloc] initWithFrame:rect02];
	
	self.totalPage.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	self.totalPage.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	
	self.currentPage.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	self.currentPage.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	
	self.totalPage.font = [UIFont boldSystemFontOfSize:13];
	self.currentPage.font = [UIFont boldSystemFontOfSize:13];
	
	self.layer.cornerRadius = 15;
	
    self.totalPage.textAlignment  = NSTextAlignmentCenter;
    self.currentPage.textAlignment  = NSTextAlignmentCenter;
    self.totalPage.font = [UIFont systemFontOfSize:19];
    
	[self addSubview:self.totalPage];
	[self addSubview:self.currentPage];
	
}
@end
