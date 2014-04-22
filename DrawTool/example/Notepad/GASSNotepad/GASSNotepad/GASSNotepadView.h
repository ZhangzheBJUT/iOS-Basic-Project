//*********************************************************
//  GASSNotepadView.h
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-24.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*******************************************************/

#import <UIKit/UIKit.h>

@interface GASSNotepadView : UIView

@property (nonatomic, assign) CGLayerRef   layerRef;            //相当于一个画布
@property (nonatomic, assign) CGContextRef layerContextRef;     //图形上下文
@property (nonatomic, assign) id delegate;                      //绘图代理
@property (nonatomic, assign) NSUInteger blendModel;            //图形汇合模式
@property (nonatomic, assign) BOOL   isFirstLaunch;

- (void) clearView;

@end
