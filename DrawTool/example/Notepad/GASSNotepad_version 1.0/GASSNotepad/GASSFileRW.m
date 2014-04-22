/*********************************************************
 *  GASSFileRW.m
 *  GASSMap
 *
 *  Created by zhangzhe on 13-4-22.
 *  Copyright (c) 2013年 HaiFeng. All rights reserved.
 **********************************************************/

#import "GASSFileRW.h"

@implementation GASSFileRW


+ (NSString *) getFilePath:(NSString *) fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     
    NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    if (documentsDirectory == nil)
    {
        return nil;
    }
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return appFile;
}

+ (BOOL)  fileIsExist:(NSString*) fileName
{
    //取得文件完整路径
    NSString *path = [GASSFileRW getFilePath:fileName];
    if (path == nil)
    {
        return NO;
    }
    
    return  [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}
+ (BOOL) removeFileAtPath:(NSString*) fileName
{
    NSString *path = [GASSFileRW getFilePath:fileName];
    if (path == nil)
    {
        return NO;
    }

    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:path
                                                      error:&error];
}

@end
