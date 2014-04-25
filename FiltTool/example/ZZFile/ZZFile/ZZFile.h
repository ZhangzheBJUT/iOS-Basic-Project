/*********************************************************
*  ZZFile.h
*
*    File and Folder Operation.
*
*  Created by zhangzhe on 13-4-22.
*  Copyright (c) 2013年 zhangzhe. All rights reserved.
**********************************************************/

#import <Foundation/Foundation.h>

@interface ZZFile : NSObject


//Get Home/Bundle/Document/Library/Cache/Temp  Directory
+ (NSString*) HomeDirectory;
+ (NSString*) BundleDirectory;
+ (NSString*) DocumentDirectory;
+ (NSString*) LibraryDirectory;
+ (NSString*) LibraryCacheDirectory;
+ (NSString*) TempDirectory;

//File Path.
+ (NSString *) DocumentFilePath:(NSString *) fileName;
+ (BOOL)  FileIsExist:(NSString*) fileName;
+ (BOOL)  DocumentFileIsExist:(NSString*) fileName;


//File Operation.
+ (BOOL)  WriteObject:(id) object filePath:(NSString*) fileName;
+ (BOOL)  WriteObject:(id) object DocumentFilePath:(NSString *)fileName;
+ (BOOL)  removeFileAtPath:(NSString*) fileName;
+ (BOOL)  removeDocumentFileAtPath:(NSString *)fileName;
+ (BOOL)  RenameDocumentFile:(NSString*) oldName forName:(NSString*) newName;
+ (BOOL)  CopyDocumentFileFrom:(NSString*) source To:(NSString*)destination;

//Folder Operation.
+ (BOOL)  CreateDocumentFolder:(NSString*) folderName;
+ (BOOL)  RemoveDocumentFolder:(NSString*) folderName;
+ (BOOL)  RenameDocumentFolder:(NSString*) oldName forName:(NSString*) newName;
+ (BOOL)  CopyDocumentFolderFrom:(NSString*) source To:(NSString*)destination;
+ (NSArray*) TraverseDocumentFolder:(NSString*) folderName;


//Copy Bundle file To Document
+ (BOOL)  CopyBundleFile:(NSString*) fileName ToDocument:(NSString*) documentFileName;

//NSUserDefalut
+ (void) UserDefalutObject:(id)object forKey:(NSString*) key;
+ (id)   UserDefalutObjectForKye:(NSString*) key;
+ (void) Synchronize;



//Hash File
+ (NSString *)md5HashOfFileAtPath:(NSString *)filePath;
+ (NSString *)sha1HashOfFileAtPath:(NSString *)filePath;
+ (NSString *)sha512HashOfFileAtPath:(NSString *)filePath;
@end
