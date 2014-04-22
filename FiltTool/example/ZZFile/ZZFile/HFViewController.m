//
//  HFViewController.m
//  ZZFile
//
//  Created by zhangzhe on 14-4-23.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import "HFViewController.h"
#import "ZZFile.h"
@interface HFViewController ()

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self fileOperation];
//    [self WRFile];
//    [self userDefalut];
//    [self folderOperation];
//    [self copyBundleFileToDocument];
//    [self listFile];
//    [self writeMixData];
//    [self readMixData];
    
    
    
 
	// Do any additional setup after loading the view, typically from a nib.
}
- (void) fileOperation
{
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"path:%@", homeDirectory);
    
    //应用程序路径
    NSString*appPath  = [[NSBundle mainBundle] resourcePath];
     NSLog(@"path:%@", appPath);
    
    //document目录
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPaths = [docPaths objectAtIndex:0];
    NSLog(@"path:%@", documentPaths);
    
    
    //Cache目录
    NSArray *cacPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPaths objectAtIndex:0];
    NSLog(@"%@", cachePath);
    
    //获取Library目录
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [libPaths objectAtIndex:0];
    NSLog(@"%@", libraryPath);
    
    //获取Tmp目录
    NSString *tmpDir = NSTemporaryDirectory();
    NSLog(@"%@", tmpDir);
}

- (void) WRFile
{
    //写入
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir)
    {
        NSLog(@"Documents 目录未找到");
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"Hebie",@"BJUT",nil];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"zz.text"];
    [array writeToFile:filePath atomically:YES];

    
    //读取
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    NSArray *result = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSLog(@"%@", result);
}
- (void) userDefalut
{
    NSUserDefaults *defalut =  [NSUserDefaults standardUserDefaults];
    [defalut setObject:@"ZZBJUT" forKey:@"name"];
    [defalut setObject:[NSNumber numberWithInteger:25] forKey:@"age"];
    [defalut synchronize];
    
    defalut = nil;
    
    defalut =  [NSUserDefaults standardUserDefaults];
    NSString *name = [defalut  objectForKey:@"name"];
    NSInteger age  = [[defalut objectForKey:@"age"] integerValue];
    NSLog(@"name:%@  age:%d",name ,age);
    
}
- (void)createFolder:(NSString *)createDir
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:createDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
- (void) folderOperation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"first"];
    [self createFolder:dataPath];
    
    dataPath = [dataPath stringByAppendingPathComponent:@"second"];
    [self createFolder:dataPath];
    
    //创建文件
    NSString *testPath = [dataPath stringByAppendingPathComponent:@"zz.txt"];
    NSString *string = @"ZZBJUT 写入文件";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:testPath
                         contents:[string dataUsingEncoding:NSUTF8StringEncoding]
                       attributes:nil];
    
    //删除文件
    //[fileManager removeItemAtPath:testPath error:nil];
    dataPath  = [dataPath stringByAppendingPathComponent:@"third"];
    [self createFolder:dataPath];
}
- (void) copyBundleFileToDocument
{
    NSString *flieName = @"apple.jpg";
    NSString *fileToCopy = [[NSBundle mainBundle] pathForResource:@"apple.jpg" ofType:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingString:@"/first/second/third"];
    NSString * finalLocation = [dataPath stringByAppendingPathComponent:flieName];
    
    BOOL retVal = YES; // If the file already exists, we'll return success…
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:fileToCopy
                                                         toPath:finalLocation
                                                          error:NULL];
        NSLog(@"copy done!");
        NSLog(@"souce:%@",fileToCopy);
        NSLog(@"destination:%@",finalLocation);
    }
    
    //删除文件
//    if ([[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
//    {
//        retVal = [[NSFileManager defaultManager] removeItemAtPath:finalLocation error:NULL];
//        NSLog(@"delete file:%@",finalLocation);
//    }
    
}
- (void) listFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: documentsDirectory error:nil];
    NSLog(@"%@",file);
}
- (void) writeMixData
{
    NSString * fileName = @"mixtypedata.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
   
    //待写入的数据
    NSString *temp = @"Hello world!";
    int dataInt = 1234;
    float dataFloat = 3.14f;
    
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[temp dataUsingEncoding:NSUTF8StringEncoding]];
    //将其他数据添加到缓冲中
    [writer appendBytes:&dataInt length:sizeof(int)];
    [writer appendBytes:&dataFloat length:sizeof(float)];
    //将缓冲的数据写入到文件中  
    [writer writeToFile:path atomically:YES];
    
    //[self readMixData];
}
- (void) readMixData
{
    NSString * fileName = @"mixtypedata.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
 
    
    //读取数据：
    int intData;
    float floatData = 0.0;
    NSString *stringData;
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    stringData = [[NSString alloc] initWithData:
                  [reader subdataWithRange:NSMakeRange(0, [@"Hello world!" length])]
                                       encoding:NSUTF8StringEncoding];
    
    [reader getBytes:&intData range:NSMakeRange([@"Hello world!"length], sizeof(int))];
    [reader getBytes:&floatData range:NSMakeRange([@"Hello world!" length] + sizeof(int), sizeof(float))];
    NSLog(@"stringData:%@ intData:%d floatData:%f", stringData, intData, floatData);
}
- (void) WriteImgeToFile
{
    //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //并给文件起个文件名
    NSString *imageDir = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"first"] stringByAppendingPathComponent:@"images"];
    
    //存放图片的文件夹
    NSString *imagePath =[imageDir stringByAppendingPathComponent:@"0.png"];
    
    NSData *data = nil;
    
    //检查图片是否已经保存到本地
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        data=[NSData dataWithContentsOfFile:imagePath];
    }
    else
    {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://211.154.154.96:7071/press/163/songzi/0.jpg"]];
        
        //创建文件夹路径
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //创建图片
        [UIImagePNGRepresentation([UIImage imageWithData:data]) writeToFile:imagePath atomically:YES];
    }
}
- (IBAction)TestZZFile:(id)sender
{
    [self TestZZFileClass];
}

- (void) TestZZFileClass
{
    BOOL isExist;
    NSString *fileName = @"/first/second/third/apple.jpg";
    
    isExist = [ZZFile DocumentFileIsExist:fileName];
    NSLog(@"%@ is exist:%d",fileName,isExist);
    
    isExist = [ZZFile FileIsExist:fileName];
    NSLog(@"%@ is exist:%d",fileName,isExist);
    
    
    NSArray *array = @[@"zz2",@"bb2"];
    fileName = @"test.txt";
    isExist  =  [ZZFile WriteObject:array DocumentFilePath:fileName];
    isExist = [ZZFile removeDocumentFileAtPath:fileName];
    NSLog(@"write array:%d",isExist);
    
    
    
    isExist = [ZZFile CopyBundleFile:@"copyfile.txt" ToDocument:@"copyfile.txt"];
    NSLog(@"copy success:%d",isExist);
    
    
    isExist = [ZZFile CreateDocumentFolder:@"AA/BB"];
    NSLog(@"create folder:%d",isExist);
    
     //isExist = [ZZFile RemoveDocumentFolder:@"AA"];
     NSLog(@"delete folder:%d",isExist);
    
    isExist = [ZZFile CopyBundleFile:@"copyfile.txt" ToDocument:@"AA/BB/copyfile.txt"];
    NSArray *result = [ZZFile TraverseDocumentFolder:@"AA"];
    NSLog(@"traverse folder:%@",result);
    
    isExist = [ZZFile RenameDocumentFolder:@"AA/BB" forName:@"AA/CC"];
    NSLog(@"rename folder:%d",isExist);
    
    isExist = [ZZFile RenameDocumentFile:@"AA/BB/copyfile.txt" forName:@"AA/BB/newname1.txt"];
    NSLog(@"rename file:%d",isExist);
    
    isExist = [ZZFile CopyDocumentFileFrom:@"AA/BB/copyfile.txt" To:@"AA/BB/copyfile2.txt"];
    NSLog(@"copy file:%d",isExist);
    
    isExist = [ZZFile CopyDocumentFolderFrom:@"AA/BB" To:@"first/BB"];
    NSLog(@"copy folder:%d",isExist);
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
