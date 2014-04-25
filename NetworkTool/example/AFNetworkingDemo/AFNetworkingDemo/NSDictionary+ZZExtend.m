//
//  NSDictionary+ZZExtend.m
//  AFNetworkingDemo
//
//  Created by zhangzhe on 14-4-25.
//  Copyright (c) 2014年 com.test. All rights reserved.
//

#import "NSDictionary+ZZExtend.h"

@implementation NSDictionary (ZZExtend)

- (NSData*) dictionaryJSONData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted                                                          error:&error];
    if (error != nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSString*) dictionaryJSONString
{
    NSData *data = [self dictionaryJSONData];
    
    if (data == nil)
    {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}



@end
