/*********************************************************
*  GASSFileRW.h
*  GASSMap
*    
*       常用的有关文件读写操作辅助类
*
*  Created by zhangzhe on 13-4-22.
*  Copyright (c) 2013年 HaiFeng. All rights reserved.
**********************************************************/

#import <Foundation/Foundation.h>

@interface GASSFileRW : NSObject

+ (NSString *) getFilePath:(NSString *) fileName;
+ (BOOL)  fileIsExist:(NSString*) fileName;
+ (BOOL)  removeFileAtPath:(NSString*) fileName;
@end
