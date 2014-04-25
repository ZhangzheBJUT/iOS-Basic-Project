//
//  GASSViewController.m
//  AnimationDemo01
//
//  Created by zhangzhe on 13-3-28.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

UIView *view = nil;
#import "GASSViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GASSView.h"
@interface GASSViewController ()

@end

CABasicAnimation *animation = nil;
@implementation GASSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];

    
    CGPoint toPos = CGPointMake(200, 200);
    
    
    /*
     使用Core Animation图层
     */
    
    animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //    animation.toValue = (id)[UIColor blueColor].CGColor;
    animation.toValue = [NSValue valueWithCGPoint:toPos];
    animation.duration = 3;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    //animation.autoreverses = YES;
    [view.layer addAnimation:animation forKey:@"position"];

   // view.layer.position = toPos;
    
    //[self performSelector:@selector(stop) withObject:nil afterDelay:1];
    //view.layer.backgroundColor = [UIColor blueColor].CGColor;

    
//    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    flip.toValue = [NSNumber numberWithDouble:-M_PI];
//    
//    
//    
//    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scale.toValue = [NSNumber numberWithDouble:.9];
//    scale.duration = .5;
//    scale.autoreverses = YES;
//    
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations =[NSArray arrayWithObjects:flip,scale, nil];
//    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    group.duration = 1;
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
//    
//    [view.layer addAnimation:group forKey:@"flip"];
    
    
//    /*
//     + (void)beginAnimations:(NSString *)animationID context:(void *)context
//     
//     
//     NOTE:Use of this method is discouraged in iOS 4.0 and later. 
//          You should use the block-based animation methods to specify your animations instead.
//     */
//    [UIView beginAnimations:@"Animation Demo" context:nil];
//    [UIView setAnimationDuration:1];
//    
//    view.backgroundColor = [UIColor blueColor];
//    view.frame = CGRectMake(50,50,100,100);
//    view.alpha = .5;
//    
//    [UIView commitAnimations];
//
//    view = nil;
    
    
    /*
     使用代码块
     */
    
//    [UIView animateWithDuration:5
//                         delay:0
//                       options:UIViewAnimationOptionCurveLinear
//                    animations:^(void)
//                              {
//                                  view.backgroundColor = [UIColor blueColor];
//                                  view.frame = CGRectMake(50,50,100,100);
//                                  view.alpha = .5;
//                              }
//                    completion:^(BOOL finished)
//                              {
//                                  NSLog(@"Animation Finished!");
//                              }];

    

    /*
     使用Core Animation图层的关键帧
     */
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//
//                  animation.values = [NSArray arrayWithObjects:(id)view.layer.backgroundColor,
//                                                               (id)[UIColor yellowColor].CGColor,
//                                                               (id)[UIColor greenColor].CGColor,
//                                                               (id)[UIColor blueColor].CGColor, nil];
//    animation.duration = 3;
//    animation.autoreverses = YES;
//    [view.layer addAnimation:animation forKey:@"backgroundColor"];

     /*关键帧动画2*/
//    CAKeyframeAnimation *ani = [CAKeyframeAnimation animation];
//    CGMutablePathRef aPath = CGPathCreateMutable();
//    CGPathMoveToPoint(aPath, nil, 20, 20);
//    CGPathAddCurveToPoint(aPath,nil,160,30,220,220,240,380);
//    
//    ani.path = aPath;
//    ani.duration = 1;
//    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    ani.rotationMode = @"auto";
//    [view.layer addAnimation:ani forKey:@"position"];
//    CFRelease(aPath);



}
-(void)stop
{
//    view.center = CGPointMake(200, 200);
//    NSLog(@"stop");
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
   if (flag == YES)
    {
        view.center = CGPointMake(200, 200);

       NSLog(@"animationDidStop.....");
       
        
    }
    
//    if ([theAnimation isEqual: animation]) {
//        view.layer.backgroundColor = [UIColor blueColor].CGColor;
//        view.center = CGPointMake(200, 200);
//        
//        NSLog(@"animationDidStop.....");
//    }
//   
}

-(void)viewWillAppear:(BOOL)animated
{
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.toValue = (id)[UIColor blueColor].CGColor
//    ;
//    animation.duration = 2;
//    animation.autoreverses = YES;
    //[self.view.layer addAnimation:animation forKey:@"backgroundColor"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
