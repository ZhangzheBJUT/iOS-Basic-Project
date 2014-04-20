//
//  PDFView.h
//  PDFView01
//
//  Created by iPhone on 11-3-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFShowDelegate.h"

@class HFViewController;
@interface PDFView : UIView
@property (nonatomic, strong) id<PDFShowDelegate> pdfShowDelegate;
@property (nonatomic, assign) CGPoint   lastPreviousPoint;
@property (nonatomic, assign) CGPoint   lastCurrentPoint;
@property (nonatomic, assign) BOOL      flag;
@property (nonatomic, assign) BOOL      isClick;
@property (nonatomic, retain) HFViewController *viewController;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;
@end
