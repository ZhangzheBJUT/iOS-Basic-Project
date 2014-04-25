//
//  NSString+ZZExtend.h
//  AFNetworkingDemo
//
//  Created by zhangzhe on 14-4-25.
//  Copyright (c) 2014年 com.test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZExtend)

- (NSString *) md5;
- (NSString *) sha1;

- (NSString *) base64StringFromData:(NSData *)data length:(int)length;

//- (NSString *) sha1_base64;
//- (NSString *) md5_base64;
//- (NSString *) base64;
@end
