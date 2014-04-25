/*********************************************************
 *  ZZFile.m
 *  
 *
 *  Created by zhangzhe on 13-4-22.
 *  Copyright (c) 2013年 zhangzhe. All rights reserved.
 **********************************************************/

#import "ZZFile.h"
#include <CommonCrypto/CommonDigest.h>
#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>
#include <stdio.h>

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

#pragma mark -
#pragma mark - Hash File
//https://github.com/JoeKun/FileMD5Hash

// Constants
static const size_t FileHashDefaultChunkSizeForReadingData = 4096;

// Function pointer types for functions used in the computation
// of a cryptographic hash.
typedef int (*FileHashInitFunction)   (uint8_t *hashObjectPointer[]);
typedef int (*FileHashUpdateFunction) (uint8_t *hashObjectPointer[], const void *data, CC_LONG len);
typedef int (*FileHashFinalFunction)  (unsigned char *md, uint8_t *hashObjectPointer[]);

// Structure used to describe a hash computation context.
typedef struct _FileHashComputationContext {
    FileHashInitFunction initFunction;
    FileHashUpdateFunction updateFunction;
    FileHashFinalFunction finalFunction;
    size_t digestLength;
    uint8_t **hashObjectPointer;
} FileHashComputationContext;

#define FileHashComputationContextInitialize(context, hashAlgorithmName)                \
CC_##hashAlgorithmName##_CTX hashObjectFor##hashAlgorithmName;                          \
context.initFunction      = (FileHashInitFunction)&CC_##hashAlgorithmName##_Init;       \
context.updateFunction    = (FileHashUpdateFunction)&CC_##hashAlgorithmName##_Update;   \
context.finalFunction     = (FileHashFinalFunction)&CC_##hashAlgorithmName##_Final;     \
context.digestLength      = CC_##hashAlgorithmName##_DIGEST_LENGTH;                     \
context.hashObjectPointer = (uint8_t **)&hashObjectFor##hashAlgorithmName



+ (NSString *)hashOfFileAtPath:(NSString *)filePath withComputationContext:(FileHashComputationContext *)context
{
    NSString *result = nil;
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)filePath, kCFURLPOSIXPathStyle, (Boolean)false);
    CFReadStreamRef readStream = fileURL ? CFReadStreamCreateWithFile(kCFAllocatorDefault, fileURL) : NULL;
    BOOL didSucceed = readStream ? (BOOL)CFReadStreamOpen(readStream) : NO;
    if (didSucceed)
    {
        
        // Use default value for the chunk size for reading data.
        const size_t chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
        
        // Initialize the hash object
        (*context->initFunction)(context->hashObjectPointer);
        
        // Feed the data to the hash object.
        BOOL hasMoreData = YES;
        while (hasMoreData)
        {
            uint8_t buffer[chunkSizeForReadingData];
            CFIndex readBytesCount = CFReadStreamRead(readStream, (UInt8 *)buffer, (CFIndex)sizeof(buffer));
            if (readBytesCount == -1)
            {
                break;
            }
            else if (readBytesCount == 0)
            {
                hasMoreData = NO;
            }
            else
            {
                (*context->updateFunction)(context->hashObjectPointer, (const void *)buffer, (CC_LONG)readBytesCount);
            }
        }
        
        // Compute the hash digest
        unsigned char digest[context->digestLength];
        (*context->finalFunction)(digest, context->hashObjectPointer);
        
        // Close the read stream.
        CFReadStreamClose(readStream);
        
        // Proceed if the read operation succeeded.
        didSucceed = !hasMoreData;
        if (didSucceed)
        {
            char hash[2 * sizeof(digest) + 1];
            for (size_t i = 0; i < sizeof(digest); ++i)
            {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = [NSString stringWithUTF8String:hash];
        }
        
    }
    if (readStream)
        CFRelease(readStream);
    if (fileURL)
        CFRelease(fileURL);
    return result;
}

+ (NSString *)md5HashOfFileAtPath:(NSString *)filePath
{
    FileHashComputationContext context;
    FileHashComputationContextInitialize(context, MD5);
    return [self hashOfFileAtPath:filePath withComputationContext:&context];
}

+ (NSString *)sha1HashOfFileAtPath:(NSString *)filePath
{
    FileHashComputationContext context;
    FileHashComputationContextInitialize(context, SHA1);
    return [self hashOfFileAtPath:filePath withComputationContext:&context];
}

+ (NSString *)sha512HashOfFileAtPath:(NSString *)filePath
{
    FileHashComputationContext context;
    FileHashComputationContextInitialize(context, SHA512);
    return [self hashOfFileAtPath:filePath withComputationContext:&context];
}
@end
