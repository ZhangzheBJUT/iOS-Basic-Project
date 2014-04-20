//
//  PDFShowDelegate.h
//  PDFView01
//
//  Created by zhangzhe on 11-5-18.
//  Copyright 2011 zhangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFView;
@protocol PDFShowDelegate

@required
-(int ) pageNumber;
-(void) goUpPage;
-(void) goDownPage;
-(void) goToPage: (int) pageNumber;
-(void) updateView: (CGContextRef) context;
@end
