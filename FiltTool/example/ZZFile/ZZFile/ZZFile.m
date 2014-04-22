/*********************************************************
 *  ZZFile.m
 *  
 *
 *  Created by zhangzhe on 13-4-22.
 *  Copyright (c) 2013年 zhangzhe. All rights reserved.
 **********************************************************/

#import "ZZFile.h"

@implementation ZZFile

#pragma mark-
#pragma mark- Basic Operation.

//Get Home/Document/Library/Cache/Temp  Directory
+ (NSString*) HomeDirectory
{
    return NSHomeDirectory();
}
+ (NSString*) BundleDirectory
{
   return  [[NSBundle mainBundle] resourcePath];
    
}
+ (NSString*) DocumentDirectory
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return  [docPaths objectAtIndex:0];
}
+ (NSString*) LibraryDirectory
{
    NSArray *cacPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return  [cacPaths objectAtIndex:0];
}
+ (NSString*) LibraryCacheDirectory
{
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return  [libPaths objectAtIndex:0];
}
+ (NSString*) TempDirectory
{
    //获取Tmp目录
    return NSTemporaryDirectory();
}

#pragma mark-
#pragma mark- Path Operation.
/**
 * @description   get file path base document.
 *
 * @param         fileName file name
 * @return        absolute path base document.
 */
+ (NSString *) DocumentFilePath:(NSString *) fileName
{
    NSString *documentsDirectory =  [ZZFile DocumentDirectory];
    
    if (documentsDirectory == nil)
    {
        return nil;
    }
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}
/**
 * @description   check absolute file whether exist
 * @param         fileName  absolute file path.
 * @return        BOOL
 */

+ (BOOL)  FileIsExist:(NSString*) fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return  [fileManager fileExistsAtPath:fileName];
}
/**
 * @description   check document file whether exist.
 *                  
 * @param         fileName Based HomeDocument() Path.
 * @return        BOOL
 */
+ (BOOL)  DocumentFileIsExist:(NSString*) fileName
{
    NSString *path = [ZZFile DocumentFilePath:fileName];
    return  [ZZFile FileIsExist:path];
}
#pragma mark-
#pragma mark- File Operation.
/**
 * @description   write objects to absolute file path.
 * @param         object   object to written
 *                path     absolute file path
 * @return        BOOL .
 */
+ (BOOL) WriteObject:(id) object filePath:(NSString*) fileName
{
    if ([object respondsToSelector:@selector(writeToFile:atomically:)] == YES)
    {
        return [object writeToFile:fileName atomically:YES];
    }
    return NO;
}
/**
 * @description   write objects to document file path.
 * @param         object   object to written
 *                path     file path base document
 * @return        BOOL.
 */
+ (BOOL)  WriteObject:(id) object DocumentFilePath:(NSString *) fileName
{
    NSString *path = [ZZFile DocumentFilePath:fileName];
    return [ZZFile WriteObject:object filePath:path];
}
/**
 * @description   delete object to absolute file path.
 * @param         object   object to delete
 *                path     absolute file path
 * @return        BOOL .
 */
+ (BOOL)  removeFileAtPath:(NSString*) fileName
{
    BOOL res;
    if ([ZZFile FileIsExist:fileName] == NO)
    {
        return YES;
    }
    
    NSError *error = nil;
    res  = [[NSFileManager defaultManager] removeItemAtPath:fileName error:&error];
    
    if (error == nil && res == YES)
    {
        return YES;
    }
    return NO;
}
/**
 * @description   delete objects to document file path.
 * @param         object   object to delete
 *                path     file path base document
 * @return        BOOL.
 */
+ (BOOL)  removeDocumentFileAtPath:(NSString *)fileName
{
    NSString *path= [ZZFile DocumentFilePath:fileName];
    return     [ZZFile removeFileAtPath:path];
}
+ (BOOL)  RenameDocumentFile:(NSString*) oldName forName:(NSString*) newName
{
    NSString *filePath = [ZZFile DocumentFilePath:oldName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    
    if (existed == YES && isDir == NO)
    {
        NSError *error = nil;
        BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:[ZZFile DocumentFilePath:newName] error:&error];
        
        if (isSuccess == YES && error ==nil)
        {
            return YES;
        }
    }
    return NO;
}
+ (BOOL)  CopyDocumentFileFrom:(NSString*) source To:(NSString*)destination;
{
    NSString *src   = [ZZFile DocumentFilePath:source];
    NSString *dst   = [ZZFile DocumentFilePath:destination];
    
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:src isDirectory:&isDir];
    if (isExist == NO && isDir==YES)
    {
        return NO;
    }
    
    isExist= [fileManager fileExistsAtPath:dst isDirectory:&isDir];
    if (isExist==YES)
    {
        return NO;
    }
    
    NSError *error = nil;
    BOOL isSuccess = [fileManager copyItemAtPath:src toPath:dst error:&error];
    
    if (isSuccess == YES && error ==nil)
    {
        return YES;
    }
    return NO;

}
#pragma mark-
#pragma mark- Copy Bundle file To Document.
+ (BOOL)  CopyBundleFile:(NSString*) fileName ToDocument:(NSString*) documentFileName
{
    NSString *source = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *destination = [ZZFile DocumentFilePath:documentFileName];

    if (![[NSFileManager defaultManager] fileExistsAtPath:destination])
    {
        NSError *error = nil;
        BOOL    retVal = NO;
        
        retVal = [[NSFileManager defaultManager] copyItemAtPath:source
                                                         toPath:destination
                                                          error:&error];
        if (error == nil&&retVal==YES)
        {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark-
#pragma mark- Folder Operation.
+ (BOOL) CreateDocumentFolder:(NSString*) folderName
{
    NSString *folderPath = [ZZFile DocumentFilePath:folderName];

    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
        return YES;
    }
    return NO;
}
+ (BOOL)  RemoveDocumentFolder:(NSString*) folderName
{
    NSString *folderPath = [ZZFile DocumentFilePath:folderName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if (existed == YES && isDir == YES)
    {
        BOOL retVal = [fileManager removeItemAtPath:folderPath error:NULL];
        if (retVal == YES)
        {
            return YES;
        }
    }
    return NO;
 
}
+ (NSArray*) TraverseDocumentFolder:(NSString*) folderName
{
    NSString *folderPath = [ZZFile DocumentFilePath:folderName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if (existed == YES && isDir == YES)
    {
        NSError *error = nil;
        NSArray *result = [fileManager subpathsOfDirectoryAtPath: folderPath error:&error];
        
        if (error == nil)
        {
            return result;
        }
    }
    return nil;
}
+ (BOOL)  CopyDocumentFolderFrom:(NSString*) source To:(NSString*)destination
{
    NSString *src   = [ZZFile DocumentFilePath:source];
    NSString *dst   = [ZZFile DocumentFilePath:destination];
    
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:src isDirectory:&isDir];
    if (isExist == NO && isDir== NO)
    {
        return NO;
    }
    
    isExist= [fileManager fileExistsAtPath:dst isDirectory:&isDir];
    if (isDir == NO&&isExist==NO)
    {
        return NO;
    }
    NSError *error = nil;
    BOOL isSuccess = [fileManager copyItemAtPath:src toPath:dst error:&error];
    
    if (isSuccess == YES && error ==nil)
    {
        return YES;
    }
    return NO;

}
+ (BOOL)  RenameDocumentFolder:(NSString*) oldName forName:(NSString*) newName
{
    NSString *folderPath = [ZZFile DocumentFilePath:oldName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if (existed == YES && isDir == YES)
    {
        NSError *error = nil;
        BOOL isSuccess = [fileManager moveItemAtPath:folderPath toPath:[ZZFile DocumentFilePath:newName] error:&error];
        
        if (isSuccess == YES && error ==nil)
        {
            return YES;
        }
    }
    return NO;
}
#pragma mark -
#pragma mark - NSUserDefalut

+ (void) UserDefalutObject:(id)object forKey:(NSString*) key
{
    NSUserDefaults *defalut =  [NSUserDefaults standardUserDefaults];
    [defalut setObject:object forKey:key];
}
+ (id)   UserDefalutObjectForKye:(NSString*) key
{
    NSUserDefaults *defalut =  [NSUserDefaults standardUserDefaults];
    return  [defalut  objectForKey:@"name"];
}
+ (void) Synchronize
{
    NSUserDefaults *defalut =  [NSUserDefaults standardUserDefaults];
    [defalut synchronize];
}
@end
