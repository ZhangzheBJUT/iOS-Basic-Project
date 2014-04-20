//*********************************************************
//  GASSLoadingView.m
//  GASSPDFReader
//            自定义"忙"视图
//  Created by zhangzhe on 13-6-28.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************/

#import <QuartzCore/QuartzCore.h>
#import "GASSBusyLoadingView.h"

@interface GASSBusyLoadingView()
@property (nonatomic,strong) UILabel *content;
@end

@implementation GASSBusyLoadingView
@synthesize currentPage = _currentPage;
@synthesize totalPage   = _totalPage;
@synthesize content     = _content;



- (id)initWithFrame:(CGRect)frame
{
    //CGRect frame = CGRectMake(point.x, point.y, 100, 60);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.layer.cornerRadius  = 12.0f;
        
        [self configureView];
    }
    return self;
}
-(void) configureView
{
    self.content = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 20)];
    [self addSubview:self.content];
}
- (void) updateShow:(NSInteger) currentPage
{
    NSString *show = [NSString stringWithFormat:@"%d/%d",currentPage,self.totalPage];
    self.content.text = show;
}
- (void) dealloc
{
    self.content = nil;
}
@end
