//
//  GASSViewController.m
//  AFNetworkingDemo
//
//  Created by zhangzhe on 13-6-17.
//  Copyright (c) 2013年 com.test. All rights reserved.
//
static NSString *const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/weather.php";

#import "GASSViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFPropertyListRequestOperation.h"
#import "AFHTTPClient.h"
#import "NSDictionary+ZZExtend.h"
#import "UIImageView+AFNetworking.h"    
#import <QuartzCore/QuartzCore.h>

@interface GASSViewController ()
@property(strong) NSDictionary *weather;
@end

@implementation GASSViewController

- (void) GetDataDone:(id)data
{
    NSString *str = [NSString stringWithUTF8String:[data bytes]];
   // NSDictionary* result = (NSDictionary*)data;
    NSLog(@"####result:%@",str);
}
- (void) XMLDataDone:(NSXMLParser *)parse
{
    if (parse ==nil)
    {
        return;
    }
    
    self.xmlWeather = [NSMutableDictionary dictionary];
    parse.delegate = self;
    [parse setShouldProcessNamespaces:YES];
    [parse parse];
}
- (void) ImageDataDone:(UIImage *)image withTag:(NSInteger)tag
{
    if (tag ==1 && image !=nil)
    {
        self.imageview.image = image;
    }
}
- (void)viewDidLoad
{
    //**************GetJSON Data
    //NSDictionary *params = @{@"Accept": @"application/json"};
    //[ZZUtilNetwork JSONDataWithBasedURL:BaseURLString Path:@"?format=json" Params:params Object:self];

    
    NSString *weatherUrl = [NSString stringWithFormat:@"%@/?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     //username
    [request addValue:@"XXX" forHTTPHeaderField:@"username"];
     //appkey
    [request addValue:@"XXXX" forHTTPHeaderField:@"appkey"];
    //[ZZUtilNetwork JSonDataWithRequest:request Object:self];
    
     //**************GetXML Data
    //NSDictionary *params01 = @{@"Accept": @"text/xml"};
    //[ZZUtilNetwork GetDataWithBasedURL:BaseURLString Path:@"?format=xml" Params:params01 Object:self];
    //[ZZUtilNetwork XMLDataWithBasedURL:BaseURLString Path:@"?format=xml" Params:params01 Object:self];

    //weatherUrl = [NSString stringWithFormat:@"%@?format=xml",BaseURLString];
    //url = [NSURL URLWithString:weatherUrl];
    //NSURLRequest *request01 = [NSURLRequest requestWithURL:url];
    //[ZZUtilNetwork XMLDataWithRequest:request01 Object:self];
    
    
//    AFXMLRequestOperation *operation =
//    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request01
//                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser)
//     {
//         NSLog(@"%@",response);
//         XMLParser.delegate = self;
//         [XMLParser setShouldProcessNamespaces:YES];
//         self.xmlWeather = [NSMutableDictionary dictionary];
//         [XMLParser parse];
//     }
//                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser)
//     {
//         UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                      message:[NSString stringWithFormat:@"%@",error]
//                                                     delegate:nil
//                                            cancelButtonTitle:@"OK"
//                                            otherButtonTitles:nil];
//         [av show];
//     }];
//    [operation start];

    
    //**************plist data*************
    //weatherUrl = [NSString stringWithFormat:@"%@?format=plist",BaseURLString];
    //url = [NSURL URLWithString:weatherUrl];
    //NSURLRequest *request02 = [NSURLRequest requestWithURL:url];
    //[ZZUtilNetwork ProperListDataWithRequest:request02 Object:self];
    
//    AFPropertyListRequestOperation *operation =
//    [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:request02
//     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList)
//     {
//         self.weather  = (NSDictionary *)propertyList;
//         NSLog(@"##########:%@",self.weather);
//         
//     }
//     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList)
//     {
//         UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                    message:[NSString stringWithFormat:@"%@",error]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//         [av show];
//     }];
//    
//    [operation start];

    
    //***************HTTPRequest
    NSDictionary *info = @{@"username": @"haifeng",@"password":@"123",@"system":[NSNumber numberWithInteger:8]};
    NSString *jsonString = [info dictionaryJSONString];
    
    NSString *url01 = [NSString stringWithFormat:@"%@/login",@"http://218.241.209.20:60022"];
    NSURL *urlServer = [NSURL URLWithString:url01];
    
    NSMutableURLRequest *request03 = [NSMutableURLRequest requestWithURL:urlServer];
    [request03 setHTTPMethod:@"PUT"];
    NSString *msgLength  = [NSString stringWithFormat:@"%d",[jsonString length]];
    [request03 addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request03 setHTTPBody: [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request03 addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[ZZUtilNetwork HttpReques:request03 Object:self];
    
    
    //AFImageRequestOperation 是继承自 AFHTTPRequestOperation -- 所以 - 方法大同小异 --
    
    NSString * url04 = @"http://c.hiphotos.baidu.com/album/w=2048/sign=1d7ca85bac345982c58ae29238cc30ad/f2deb48f8c5494ee7abe33362cf5e0fe99257e04.jpg";
    // 这是一个大美女
    
    //创建 request
    NSURLRequest * request04 = [NSURLRequest requestWithURL:[NSURL URLWithString:url04]
                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval:30];
    
//    AFImageRequestOperation * operation = [AFImageRequestOperation imageRequestOperationWithRequest:request04
//                    imageProcessingBlock:^UIImage *(UIImage *image)
//    {
//        CGImageRef ref =  CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width, image.size.height));
//        UIImage * tempImage = [UIImage imageWithCGImage:ref];
//        return tempImage;
//                                                                                   
//    }
//    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
//    {
//        NSLog(@"reload image success ");
//        self.imageview.image = image;
//    }
//    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
//    {
//        NSLog(@"reload image faild , error == %@ ",error);
//    }];
//    
//    [operation start];

    [ZZUtilNetwork ImageDataWithRequest:request04
                                   Size:CGSizeMake(1, 1)
                                    Tag:1
                                 Object:self];


    [super viewDidLoad];

}
- (void) demo
{
    
    /*********************图片上传处理，监测上传状态*********/
    NSURL *url = [NSURL URLWithString:@"http://api-base-url.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"avatar.jpg"], 0.5);
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:@"/upload"
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData)
                                    {
                                        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
                                    }];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
     {
         NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
     }];
    [operation start];
    
    //***在线流媒体请求**********
    NSURLRequest *request01 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/encode"]];
    AFHTTPRequestOperation *operation01 = [[AFHTTPRequestOperation alloc] initWithRequest:request01];
    /**
     The input stream used to read data to be sent during the request.
     This property acts as a proxy to the `HTTPBodyStream` property of `request`.
     */
    operation01.inputStream = [NSInputStream inputStreamWithFileAtPath:[[NSBundle mainBundle] pathForResource:@"large-image" ofType:@"tiff"]];
    /*An initialized output stream that will write stream data to memory.*/
    operation01.outputStream = [NSOutputStream outputStreamToMemory];
    [operation01 start];
    
    /******图片请求：********/
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    [imageView setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];

}
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    self.previousElementName = self.elementName;
    
    if (qName)
    {
        self.elementName = qName;
    }
    if([qName isEqualToString:@"current_condition"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    else if([qName isEqualToString:@"weather"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    else if([qName isEqualToString:@"request"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    
    self.outstring = [NSMutableString string];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!self.elementName)
    {
        return;
    }
    
    [self.outstring appendFormat:@"%@", string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    // 1
    if([qName isEqualToString:@"current_condition"] || [qName isEqualToString:@"request"])
    {
        [self.xmlWeather setObject:[NSArray arrayWithObject:self.currentDictionary] forKey:qName];
        self.currentDictionary = nil;
    }
    // 2
    else if([qName isEqualToString:@"weather"])
    {
        // Initalise the list of weather items if it dosnt exist
        NSMutableArray *array = [self.xmlWeather objectForKey:@"weather"];
        if(!array)
            array = [NSMutableArray array];
        
        [array addObject:self.currentDictionary];
        [self.xmlWeather setObject:array forKey:@"weather"];
        
        self.currentDictionary = nil;
    }
    // 3
    else if([qName isEqualToString:@"value"])
    {
        //Ignore value tags they only appear in the two conditions below
    }
    // 4
    else if([qName isEqualToString:@"weatherDesc"] ||
            [qName isEqualToString:@"weatherIconUrl"])
    {
        [self.currentDictionary setObject:[NSArray arrayWithObject:[NSDictionary dictionaryWithObject:self.outstring forKey:@"value"]] forKey:qName];
    }
    // 5
    else
    {
        [self.currentDictionary setObject:self.outstring forKey:qName];
    }
    
	self.elementName = nil;
}
-(void) parserDidEndDocument:(NSXMLParser *)parser
{
    //self.weather = [NSDictionary dictionaryWithObject:self.xmlWeather forKey:@"data"];
    NSLog(@"###########%@",self.xmlWeather);
    self.title = @"XML Retrieved";
   // [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
