//
//  GASSViewController.h
//  AFNetworkingDemo
//
//  Created by zhangzhe on 13-6-17.
//  Copyright (c) 2013年 com.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZUtilNetWork.h"

@interface GASSViewController : UIViewController<ZZUtilNetworkDelete,NSXMLParserDelegate>
@property(strong) NSMutableDictionary *xmlWeather; //package containing the complete response
@property(strong) NSMutableDictionary *currentDictionary; //current section being parsed
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@end
