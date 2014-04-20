//**************************************************************/
//  HFViewController.h
//  HaiFeng
//
//  Created by zhangzhe on 13-12-26.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//************************************************************/

#import <UIKit/UIKit.h>
@class PDFView;
@class GASSBusyLoadingView;

@interface HFViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger current;
@property (nonatomic,strong) PDFView *pdfView;
@property (nonatomic,strong) UISlider *pageSlider;
@property (nonatomic,strong) GASSBusyLoadingView *pageNumberShow;

- (void) hiddenViews;
- (void) showViews;
- (void) goToPage:(NSInteger) PageNum;
- (void) UpdateView:(NSInteger) PageNum;
@end
