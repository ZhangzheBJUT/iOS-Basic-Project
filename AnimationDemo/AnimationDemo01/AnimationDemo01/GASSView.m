//
//  GASSView.m
//  AnimationDemo01
//
//  Created by zhangzhe on 13-3-28.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import "GASSView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GASSView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


- (void) animation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.toValue = (id)[UIColor blueColor];
    animation.duration = 2;
    animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:@"backgroundColor"];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
