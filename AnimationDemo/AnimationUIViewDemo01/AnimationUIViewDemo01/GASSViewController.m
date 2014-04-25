//
//  GASSViewController.m
//  AnimationUIViewDemo01
//
//  Created by zhangzhe on 13-4-8.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import "GASSViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GASSViewController ()
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation GASSViewController
@synthesize imageView = _imageView;


- (void) startAnimation
{
    UIImage *myImage1  = [UIImage imageNamed:@"aircraft_green"];
    UIImage *myImage2  = [UIImage imageNamed:@"aircraft_yellow"];
    UIImage *myImage3  = [UIImage imageNamed:@"aircraft_green"];
    UIImage *myImage4  = [UIImage imageNamed:@"aircraft_yellow"];

    CATransition *trans = [CATransition animation];
    trans.type = kCATransitionReveal;
	trans.subtype = kCATransitionFromLeft;
    trans.repeatCount = 5;
    trans.autoreverses = YES;
    //trans.repeatDuration = 0.8;
	trans.duration = .8;
	
    //Apply the transition to our box
	[self.imageView.layer addAnimation:trans forKey:@"transition"];
   // self.imageView.layer.backgroundColor = [UIColor blueColor].CGColor;
    self.imageView.image = myImage2;
    
//    UIImage *myImage1  = [UIImage imageNamed:@"aircraft_green"];
//    UIImage *myImage2  = [UIImage imageNamed:@"aircraft_yellow"];
//    UIImage *myImage3  = [UIImage imageNamed:@"aircraft_green"];
//    UIImage *myImage4  = [UIImage imageNamed:@"aircraft_yellow"];
//
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//	animation.values = [NSArray arrayWithObjects:
//						(id)myImage1.CGImage,
//						(id)myImage2.CGImage,
//						(id)myImage3.CGImage,
//						(id)myImage4.CGImage,nil];
//    
//	animation.duration = 4;
//	animation.autoreverses = YES;
//	[self.imageView.layer addAnimation:animation forKey:@"image"];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *myImage  = [UIImage imageNamed:@"aircraft_red"];
    self.imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(150, 200, 50, 50)];
    //[self.imageView setImage:image];
    self.imageView.image = myImage;
    [self.view addSubview:self.imageView];
    
    
    [self startAnimation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
