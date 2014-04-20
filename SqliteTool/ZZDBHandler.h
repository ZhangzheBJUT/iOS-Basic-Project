//
//  ZZDBHandler.h
//  Sqlite3Demo
//
//  Created by zhangzhe on 14-4-21.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

enum errorCodes {
	kDBNotExists,
	kDBFailAtOpen,
	kDBFailAtCreate,
	kDBErrorQuery,
	kDBFailAtClose
};
@interface ZZDBHandler : NSObject
{
    sqlite3 *dbHandler;       //The SQLite db reference
    NSString *databaseName;   //The database name
}

@property (nonatomic,assign) sqlite3*  dbHandler;
@property (nonatomic,strong) NSString* databaseName;

// Class Method
+ (ZZDBHandler*) sharedDBInstance:(NSString*) databaseName;

// SQLite Operations
- (id) initWithDatabaseNamed:(NSString *)name;
- (NSError *)  OpenDatabase;
- (NSError *)  Execude:(NSString *)sql;
- (NSError *)  Update:(NSString *)sql withParams:(NSArray *)params;
- (NSArray *)  Query:(NSString *)sql;
- (NSError *)  CloseDatabase;
- (NSInteger)  GetLastInsertRowID;
- (NSString *) GetDatabaseDump;
@end
