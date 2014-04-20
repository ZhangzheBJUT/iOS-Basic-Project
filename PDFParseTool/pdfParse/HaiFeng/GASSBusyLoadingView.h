//*********************************************************
//  GASSLoadingView.h
//  GASSPDFReader
//         自定义"忙"视图
//  Created by zhangzhe on 13-6-28.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*********************************************************/

#import <UIKit/UIKit.h>

@interface GASSBusyLoadingView : UIView
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger currentPage;

- (void) updateShow:(NSInteger) currentPage;

@end
