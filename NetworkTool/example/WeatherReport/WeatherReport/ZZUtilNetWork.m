//*************************************************************/
//  ZZUtilNetwork.m
//  GASSEFB
//
//  Created by zhangzhe on 13-9-26.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//*************************************************************/

#import "ZZUtilNetwork.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFPropertyListRequestOperation.h"
#import "UIImageView+AFNetworking.h"

@implementation ZZUtilNetwork

/**
 * @description   get arbitrarily data.
 * @param         url      Base url
 *                path     specific location
 *                params   arguments appended the url+path
 *                delegate delegate object.
 * @return        void
 */
+ (void) GetDataWithBasedURL:(NSString*) url
                        Path:(NSString*) path
                      Params:(NSDictionary*) params
                      Object:(id<ZZUtilNetworkDelete>) delegate
{
    NSURL *baseURL  = [NSURL URLWithString:url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [httpClient getPath:path
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *res  =  [NSString stringWithUTF8String:[responseObject bytes]];
         NSData   *data =  [res dataUsingEncoding:NSUTF8StringEncoding];
         
         [delegate GetDataDone:data];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [delegate GetDataDone:nil];
     }];
}
/**
 * @description   get json data.
 * @param         request
 *                delegate  delegate object.
 * @return        void
 */
+ (void) JSonDataWithRequest:(NSURLRequest*) request
                      Object:(id<ZZUtilNetworkDelete>) delegate
{
    __block NSDictionary  *result = nil;
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             result  = (NSDictionary *)JSON;
                                             [delegate GetDataDone:result];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             [delegate GetDataDone:nil];
                                         }];
    [operation  start];
    

}
/**
 * @description   get json data.
 * @param         url      Base url
 *                path     specific location
 *                params   arguments appended the url+path
 *                delegate delegate object.
 * @return        void
 */

+ (void) JSONDataWithBasedURL:(NSString*) url
                         Path:(NSString*) path
                       Params:(NSDictionary*) params
                       Object:(id<ZZUtilNetworkDelete>) delegate;
{
    __block NSDictionary  *dict = nil;
    NSURL *baseURL  = [NSURL URLWithString:url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    

    [httpClient getPath:path
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *res  =  [NSString stringWithUTF8String:[responseObject bytes]];
         NSData   *data =  [res dataUsingEncoding:NSUTF8StringEncoding];
         
         NSError *error = nil;
         dict = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
         if (error != nil)
         {
             [delegate GetDataDone:nil];
         }
         [delegate GetDataDone:dict];
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [delegate GetDataDone:nil];
     }];
}
+ (void) XMLDataWithBasedURL:(NSString*) url
                        Path:(NSString*) path
                      Params:(NSDictionary*) params
                      Object:(id<ZZUtilNetworkDelete>) delegate
{
    __block  NSXMLParser *parse = nil;
    
    NSURL *baseURL  = [NSURL URLWithString:url];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [httpClient getPath:path
             parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *res  =  [NSString stringWithUTF8String:[responseObject bytes]];
         NSData   *data =  [res dataUsingEncoding:NSUTF8StringEncoding];
      
         parse = [[NSXMLParser alloc] initWithData:data];
    
         [delegate XMLDataDone:parse];
         
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [delegate XMLDataDone:nil];
     }];

}
+ (void) XMLDataWithRequest:(NSURLRequest*) request
                     Object:(id<ZZUtilNetworkDelete>) delegate
{
    AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser)
     {
         [delegate XMLDataDone:XMLParser];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser)
     {
         [delegate XMLDataDone:nil];
     }];
    [operation start];

}
+ (void) ProperListDataWithRequest:(NSURLRequest*) request
                            Object:(id<ZZUtilNetworkDelete>) delegate
{
    AFPropertyListRequestOperation *operation =
    [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:request
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList)
     {
         [delegate GetDataDone:propertyList];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList)
     {
         [delegate GetDataDone:nil];
     }];
    
    [operation start];
}
+ (void) HttpReques:(NSURLRequest*) request
             Object:(id<ZZUtilNetworkDelete>) delegate
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[request URL]];
    AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:request
                success:^(AFHTTPRequestOperation *operation, id responseObject)
                {
                    [delegate GetDataDone:responseObject];
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error)
                {
                    [delegate GetDataDone:nil];
                }];
    
    [operation start];

}
+ (void) ImageDataWithRequest:(NSURLRequest*) request
                         Size:(CGSize) size
                          Tag:(NSInteger) tag
                       Object:(id<ZZUtilNetworkDelete>) delegate
{
    
    AFImageRequestOperation * operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
        imageProcessingBlock:^UIImage *(UIImage *image)
        {
            
            CGFloat width = size.width;
            CGFloat height= size.height;
            
            //进行缩放
            if ((width>0 && width <=1)&&(height>0 && height <=1))
            {
                width  = image.size.width * width;
                height = image.size.height* height;
            }
                
            CGImageRef ref =  CGImageCreateWithImageInRect(image.CGImage,CGRectMake(0, 0, width, height));
            UIImage * temp = [UIImage imageWithCGImage:ref];

            return temp;
       }
       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
       {
           [delegate ImageDataDone:image withTag:tag];
       }
      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
      {
          [delegate ImageDataDone:nil withTag:-1];
      }];
    
    [operation start];
   
}
@end
