//*********************************************************
//  GASSNotepadView.m
//  GASSNotepad
//
//  Created by zhangzhe on 13-6-24.
//  Copyright (c) 2013年 com.test. All rights reserved.
//*******************************************************/


#import "GASSNotepadView.h"
#import "GASSDrawTools.h"
#import "ZZFile.h"
#import "GASSConstants.h"

@interface GASSNotepadView()
@property(nonatomic,strong)  UIImage  *resultImage;    //图像缓存照片 用于保存结果
@property(nonatomic, assign) BOOL isFirst;          
@property(nonatomic, assign) CGPoint firstTouch;
@property(nonatomic, assign) CGPoint lastTouch;
@end

@implementation GASSNotepadView

@synthesize resultImage   = _resultImage;
@synthesize firstTouch    = _firstTouch;
@synthesize lastTouch     = _lastTouch;
@synthesize blendModel    = _blendModel;
@synthesize isFirstLaunch = _isFirstLaunch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.isFirstLaunch   = YES;
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        self.isFirstLaunch = YES;
    }
    return self;
}
#pragma mark -
#pragma makr - 触屏事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.firstTouch = [touch locationInView:self];
    self.lastTouch  = [touch locationInView:self];
    
    [[NSNotificationCenter defaultCenter]  postNotificationName:KHideCallOutViewPanelNotification object:nil];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.firstTouch = self.lastTouch;
    self.lastTouch = [touch locationInView:self];
    CGRect rect = [_delegate strokeView: self
                 drawFrom: self.firstTouch
                    andTo: self.lastTouch];
    [self setNeedsDisplayInRect:rect];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.lastTouch = [touch locationInView:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


//*********************************************************
//  
// 函数描述：
//
//   参数类型：
//       pixelsWide:  图片宽度
//       pixelsHigh:  图片高度
//
//    返回值：
//      新创建的位图
//
//*******************************************************/
CGContextRef MyCreateBitmapContext(int pixelsWide,int pixelsHigh)
{
    CGContextRef context = NULL;    //位图上下文指针
    CGColorSpaceRef colorSpace;     //颜色空间指针
    void    *bitmapData;            //存储内存位图的缓存区
    int     bitmapByteCount;        //内存位图占的字节总数
    int     bitmapBytesPerRow;      //内存位图每一行所占字节数
    
    bitmapBytesPerRow = pixelsWide * 4;
    bitmapByteCount   = bitmapBytesPerRow * pixelsHigh;
    
    colorSpace = CGColorSpaceCreateDeviceRGB(); //颜色空间
    bitmapData = calloc(bitmapByteCount, 8);    //开辟内存
    
    if (bitmapData == NULL)
    {
        NSLog(@"calloc memory failed!");
        return NULL;
    }
    
    context = CGBitmapContextCreate(bitmapData,
                                    pixelsWide,
                                    pixelsHigh,
                                    8,
                                    bitmapBytesPerRow,
                                    colorSpace,
                                    kCGBitmapAlphaInfoMask);
    if (context == NULL)
    {
        free(bitmapData);
        NSLog(@"Context create failed!");
        return  NULL;
    }
    CGColorSpaceRelease(colorSpace);
    return context;
}
 //*********************************************************
 //
 // 函数描述：
 //        创建CGLayer上下文，用于绘图使用。
 //
 //*******************************************************/
- (void)drawRect:(CGRect)rect
{
    //*********************创建CGLayer上下文 内存绘图板 *****************/
    CGContextRef contextRef  = UIGraphicsGetCurrentContext();
    if (_layerRef == NULL)
    {
        _layerRef        = CGLayerCreateWithContext(contextRef, CGSizeMake(768, 1024), NULL);
        _layerContextRef = CGLayerGetContext(_layerRef);
        CGContextSetBlendMode(_layerContextRef,kCGBlendModeNormal);
        CGContextSetShouldAntialias(_layerContextRef, YES);
        CGContextSetAllowsAntialiasing(_layerContextRef, YES);
    }
    
    //********************如果是第一次启动的话 加载上次保存的图片**********/
    if (self.isFirstLaunch == YES)
    {
        NSString *notepadPath = [ZZFile DocumentFilePath:KNotepadSavePath];
        BOOL isExist =  [ZZFile DocumentFileIsExist:KNotepadSavePath];
        
        if (isExist == YES)
        {
            [_delegate strokeView:self
                        drawImage:[UIImage imageWithContentsOfFile:notepadPath]];
        }
        
        self.isFirstLaunch = NO;
    }
    
    //**********************设置绘图模式****************************/
    CGContextSetBlendMode(_layerContextRef,_blendModel);
    
    //*********************将内存绘图板 现实到屏幕上 *****************/
    CGContextDrawLayerInRect(contextRef, CGRectMake(0,0,768, 1024), _layerRef);
    

    //    CGContextSetBlendMode(_layerContextRef,kCGBlendModeNormal);
    //    CGContextSetRGBFillColor(_layerContextRef, 1, 0, 0, 1);
    //    CGContextFillRect(_layerContextRef, CGRectMake(0, 0, 200, 100));
    //    CGContextSetRGBFillColor(_layerContextRef, 0, 0, 1, .5);
    //    CGContextFillRect(_layerContextRef, CGRectMake(0, 0, 100, 200));
    
    
    //UIGraphicsBeginImageContext([[UIScreen mainScreen] bounds].size);
    
    //*****************加载图片并获取宽和高的信息*******************
    /*UIImage *image = [UIImage imageNamed:@"01.png"];
    CGImageRef myImageRef = image.CGImage;
    float width  = image.size.width;
    float height = image.size.height;
    CGRect myBoundingBox = CGRectMake(0, 0, width, height);
    [image drawInRect:CGRectMake(0, 44, width, height)];
    
    
     ******************创建位图画布******************************
    CGContextRef bitmapContextRef = MyCreateBitmapContext(width, height);
    ******************在位图画布上自定义图形**********************
    CGContextDrawImage(bitmapContextRef, CGRectMake(0, 0, width, height), myImageRef);
    CGContextSetRGBFillColor(bitmapContextRef, 1, 0, 0, 1);
    CGContextFillRect(bitmapContextRef, CGRectMake(0, 0, 200, 100));
    CGContextSetRGBFillColor(bitmapContextRef, 0, 0, 1, .5);
    CGContextFillRect(bitmapContextRef, CGRectMake(0, 0, 100, 200));
    *******************显示图片********************************
    //CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGImageRef     imageRef = CGBitmapContextCreateImage(bitmapContextRef);
    self.resultImage = [UIImage imageWithCGImage:imageRef];
    //[myImage drawInRect:myBoundingBox];
    //CGContextDrawImage(contextRef, myBoundingBox, imageRef);
    *******************释放资源*******************************
    char *bitmapData = CGBitmapContextGetData(bitmapContextRef);
    CGContextRelease(bitmapContextRef);
    if (bitmapData)
    {
        free(bitmapData);
    }
    CGImageRelease(imageRef);
    // UIImageWriteToSavedPhotosAlbum(UIImage *image, id completionTarget, SEL completionSelector, void *contextInfo);
    
    
    [[UIColor redColor] setStroke];
    [self.path stroke];
    
    //[self.layer rederInContext:nil];
    //[layer renderInContext:ctx];
    
    //UIImage * = UIGraphicsGetImageFromCurrentImageContext();
    //self.resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();*/
    
}
//*********************************************************
//
// 函数描述：
//       清屏
//
//*******************************************************/
- (void) clearView
{
	CGLayerRelease(_layerRef);
	_layerRef = nil;
	[self setNeedsDisplay];
}
@end
