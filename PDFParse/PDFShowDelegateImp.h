//
//  PDFShowDelegateImp.h
//  PDFView01
//
//  Created by zhangzhe on 11-5-18.
//  Copyright 2011 zhangzhe. All rights reserved.
//

#import "PDFShowDelegate.h"

@class PDFView;
@interface PDFShowDelegateImp : NSObject<PDFShowDelegate>
@property (nonatomic,assign) PDFView *pdfView;
@property (nonatomic,assign) CGPDFDocumentRef pdfDocument;
@property (nonatomic,assign) CGRect viewBounds;
@property int currentPageNumber;
@property int totalPageNumber;

-(id) initWithView:(UIView *)aView;
@end
