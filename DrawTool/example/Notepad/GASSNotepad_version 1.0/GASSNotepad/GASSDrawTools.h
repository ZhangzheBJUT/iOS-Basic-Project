//***********************************************************
//  GASSDrawTools.h
//  GASSNotepad
//              绘图的核心类
//  Created by zhangzhe on 13-6-25.
//  Copyright (c) 2013年 com.test. All rights reserved.
//**********************************************************/

#import <Foundation/Foundation.h>

@interface GASSDrawTools : NSObject

@property (nonatomic,assign) float   strokeWidth;   //线条宽度
@property (nonatomic,strong) UIColor *strokeColor;  //线条颜色

- (id)init;

- (CGRect)drawLineFrom : (CGPoint)aStart
				 andTo : (CGPoint)aEnd;

- (void)strokeView : (UIView *)aStrokeView
		    drawFrom : (CGPoint)aFrom
			   andTo : (CGPoint)aTo;

- (void)strokeView : (UIView*)aStrokeView
         drawImage : (UIImage *)aImage;
@end
