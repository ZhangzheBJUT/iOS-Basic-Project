//**********************************************************/
//  ZZUtilNetwork.h
//  GASSEFB
//
//  Created by zhangzhe on 13-9-26.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//**********************************************************/

#import <Foundation/Foundation.h>

@protocol ZZUtilNetworkDelete;

@interface ZZUtilNetwork : NSObject

+ (void) GetDataWithBasedURL:(NSString*) url
                        Path:(NSString*) path
                       Params:(NSDictionary*) params
                       Object:(id<ZZUtilNetworkDelete>) delegate;

+ (void) JSonDataWithRequest:(NSURLRequest*) request
                      Object:(id<ZZUtilNetworkDelete>) delegate;

+ (void) JSONDataWithBasedURL:(NSString*) url
                         Path:(NSString*) path
                       Params:(NSDictionary*) params
                       Object:(id<ZZUtilNetworkDelete>) delegate;

+ (void) XMLDataWithBasedURL:(NSString*) url
                        Path:(NSString*) path
                      Params:(NSDictionary*) params
                      Object:(id<ZZUtilNetworkDelete>) delegate;

+ (void) XMLDataWithRequest:(NSURLRequest*) request
                      Object:(id<ZZUtilNetworkDelete>) delegate;

+ (void) ProperListDataWithRequest:(NSURLRequest*) request
                            Object:(id<ZZUtilNetworkDelete>) delegate;


+ (void) HttpReques:(NSURLRequest*) request
             Object:(id<ZZUtilNetworkDelete>) delegate;


+ (void) ImageDataWithRequest:(NSURLRequest*) request
                         Size:(CGSize) size
                          Tag:(NSInteger) tag
                       Object:(id<ZZUtilNetworkDelete>) delegate;
@end

@protocol ZZUtilNetworkDelete

@optional

- (void) GetDataDone:(id) data;
- (void) XMLDataDone:(NSXMLParser*) parse;
- (void) ImageDataDone:(UIImage*) image withTag:(NSInteger) tag;
@end