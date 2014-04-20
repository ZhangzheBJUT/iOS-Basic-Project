//
//  ZZDBHandler.m
//  Sqlite3Demo
//
//  Created by zhangzhe on 14-4-21.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import "ZZDBHandler.h"
@interface ZZDBHandler()

- (NSString *)getDatabasePath;
- (NSError *)createDBErrorWithDescription:(NSString*)description andCode:(int)code;
@end


@implementation ZZDBHandler
@synthesize dbHandler     = _dbHandler;
@synthesize databaseName  = _databaseName;

- (id) initWithDatabaseNamed:(NSString *)name
{
    if (self = [super init])
    {
        self.databaseName = [NSString stringWithString:name];
        self.dbHandler    = nil;
        
    }
    return self;
}

// Class Method
+ (ZZDBHandler*) sharedDBInstance:(NSString*) databaseName
{
    static ZZDBHandler *_handler;
    static dispatch_once_t token;
    dispatch_once(&token,^(void){ _handler = [[ZZDBHandler alloc] initWithDatabaseNamed:databaseName];});
    return _handler;
}
/**
 *   @description   open the databse.
 *   @param         nil
 *   @return        NSError  error description.
 */
- (NSError *)  OpenDatabase
{
    NSError *error = nil;
    
    NSString *databasePath = [self getDatabasePath];
	const char *dbpath = [databasePath UTF8String];
    
    int result = sqlite3_open(dbpath, &_dbHandler);
    
	if (result != SQLITE_OK)
    {
        const char *errorMsg = sqlite3_errmsg(_dbHandler);
        NSString *errorStr = [NSString stringWithFormat:@"The database could not be opened: %@",
                              [NSString stringWithCString:errorMsg encoding:NSUTF8StringEncoding]];
        error = [self createDBErrorWithDescription:errorStr	andCode:kDBFailAtOpen];
	}
    
	return error;
}
/**
 * @description   execute sql.
 *                  you should use this method for everything
 *                  but SELECT statements.
 * @param         nil
 * @return        NSError  error description.
 */
- (NSError *)  Execude:(NSString *)sql
{
    NSError *openError  = nil;
	NSError *errorQuery = nil;
    
	//Check if database is open and ready.
	if (self.dbHandler == nil)
    {
		openError = [self OpenDatabase];
	}
    
	if (openError == nil)
    {
		sqlite3_stmt *statement;
		const char *query = [sql UTF8String];
		sqlite3_prepare_v2(_dbHandler, query, -1, &statement, NULL);
        
		if (sqlite3_step(statement) == SQLITE_ERROR)
        {
			const char *errorMsg = sqlite3_errmsg(_dbHandler);
			errorQuery = [self createDBErrorWithDescription:
                          [NSString stringWithCString:errorMsg encoding:NSUTF8StringEncoding]
													andCode:kDBErrorQuery];
		}
        //delete the prepared statement.
		sqlite3_finalize(statement);
		//errorQuery = [self closeDatabase];
	}
	else
    {
		errorQuery = openError;
	}
    
	return errorQuery;
}
/**
 * @description   Update operation.
 *                Update the specific Record.
 * @param         parms
 * @return        NSError  error description.
 */
- (NSError *)  Update:(NSString *)sql withParams:(NSArray *)params
{
    NSError *openError = nil;
	NSError *errorQuery = nil;
    
	//Check if database is open and ready.
	if (_dbHandler == nil)
    {
		openError = [self OpenDatabase];
	}
    
	if (openError == nil)
    {
		sqlite3_stmt *statement;
		const char *query = [sql UTF8String];
		sqlite3_prepare_v2(_dbHandler, query, -1, &statement, NULL);
        
        //BIND the params!
        int count =0;
        for (id param in params )
        {
            count++;
            if ([param isKindOfClass:[NSString class]] )
                sqlite3_bind_text(statement, count, [param UTF8String], -1, SQLITE_TRANSIENT);
            if ([param isKindOfClass:[NSNumber class]] )
            {
                if (!strcmp([param objCType], @encode(float)))
                    sqlite3_bind_double(statement, count, [param doubleValue]);
                else if (!strcmp([param objCType], @encode(int)))
                    sqlite3_bind_int(statement, count, [param intValue]);
                else if (!strcmp([param objCType], @encode(BOOL)))
                    sqlite3_bind_int(statement, count, [param intValue]);
                else
                    NSLog(@"unknown NSNumber");
            }
            if ([param isKindOfClass:[NSDate class]])
            {
                sqlite3_bind_double(statement, count, [param timeIntervalSince1970]);
            }
            if ([param isKindOfClass:[NSData class]] )
            {
                sqlite3_bind_blob(statement, count, [param bytes], [param length], SQLITE_STATIC);
            }
        }
        
		if (sqlite3_step(statement) == SQLITE_ERROR)
        {
			const char *errorMsg = sqlite3_errmsg(_dbHandler);
			errorQuery = [self createDBErrorWithDescription:
                          [NSString stringWithCString:errorMsg encoding:NSUTF8StringEncoding]
													andCode:kDBErrorQuery];
		}
		sqlite3_finalize(statement);
		errorQuery = [self CloseDatabase];
	}
	else
    {
		errorQuery = openError;
	}
    
	return errorQuery;
}
/**
 * @description   query the result.
 *
 * @param         sql  query condition.
 * @return        NSArray  result objects.
 */

- (NSArray *) Query:(NSString *)sql
{
    NSMutableArray *resultsArray = [[NSMutableArray alloc] initWithCapacity:1];
    
	if (_dbHandler == nil)
    {
		[self OpenDatabase];
	}
    
	sqlite3_stmt *statement;
	const char *query = [sql UTF8String];
	int returnCode = sqlite3_prepare_v2(_dbHandler, query, -1, &statement, NULL);
    
	if (returnCode == SQLITE_ERROR)
    {
		const char *errorMsg = sqlite3_errmsg(_dbHandler);
		NSError *errorQuery = [self createDBErrorWithDescription:
                               [NSString stringWithCString:errorMsg encoding:NSUTF8StringEncoding]
                                                         andCode:kDBErrorQuery];
		NSLog(@"%@", errorQuery);
	}
    
	while (sqlite3_step(statement) == SQLITE_ROW)
    {
		int columns = sqlite3_column_count(statement);
		NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:columns];
        
		for (int i = 0; i<columns; i++)
        {
			const char *name = sqlite3_column_name(statement, i);
			NSString *columnName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
			int type = sqlite3_column_type(statement, i);
            
			switch (type)
            {
				case SQLITE_INTEGER:
				{
					int value = sqlite3_column_int(statement, i);
					[result setObject:[NSNumber numberWithInt:value] forKey:columnName];
					break;
				}
				case SQLITE_FLOAT:
				{
					float value = sqlite3_column_double(statement, i);
					[result setObject:[NSNumber numberWithFloat:value] forKey:columnName];
					break;
				}
				case SQLITE_TEXT:
				{
					const char *value = (const char*)sqlite3_column_text(statement, i);
					[result setObject:[NSString stringWithCString:value
                                                         encoding:NSUTF8StringEncoding]
                               forKey:columnName];
					break;
				}
                    
				case SQLITE_BLOB:
                {
                    int bytes = sqlite3_column_bytes(statement, i);
                    if (bytes > 0)
                    {
                        const void *blob = sqlite3_column_blob(statement, i);
                        if (blob != NULL)
                        {
                            [result setObject:[NSData dataWithBytes:blob length:bytes] forKey:columnName];
                        }
                    }
					break;
                }
                    
				case SQLITE_NULL:
					[result setObject:[NSNull null] forKey:columnName];
					break;
                    
				default:
				{
					const char *value = (const char *)sqlite3_column_text(statement, i);
					[result setObject:[NSString stringWithCString:value
                                                         encoding:NSUTF8StringEncoding]
                               forKey:columnName];
					break;
				}
                    
			} //end switch
		} //end for
        
		[resultsArray addObject:result];
	} //end while
	sqlite3_finalize(statement);
	//[self closeDatabase];
	return resultsArray;
}
/**
 * @description   close data base.
 *                you should close database after you have done all work.
 * @param         nil
 * @return        NSError  error description.
 */
- (NSError *)  CloseDatabase
{
    NSError *error = nil;
    
	if (_dbHandler != nil)
    {
		if (sqlite3_close(_dbHandler) != SQLITE_OK)
        {
			const char *errorMsg = sqlite3_errmsg(_dbHandler);
			NSString *errorStr = [NSString stringWithFormat:@"The database could not be closed: %@",[NSString stringWithCString:errorMsg encoding:NSUTF8StringEncoding]];
			error = [self createDBErrorWithDescription:errorStr andCode:kDBFailAtClose];
		}
        
		_dbHandler = nil;
	}
    
	return error;
}

/**
 * @description   execute sql.
 *                  you should use this method for everything
 *                  but SELECT statements.
 * @param         nil
 * @return        NSError  error description.
 */

- (NSInteger)  GetLastInsertRowID
{
    NSError *openError = nil;
    sqlite3_int64 rowid = 0;
    
	//Check if database is open and ready.
	if (_dbHandler == nil)
    {
		openError = [self OpenDatabase];
	}
    
	if (openError == nil)
    {
        rowid = sqlite3_last_insert_rowid(_dbHandler);
    }
    
    return (NSInteger)rowid;
}


/**
 * @description   creates an SQL dump of the database.
 *                This method could get a csv format dump with a few changes.
 *                But i prefer working with sql dumps.
 * @param         nil
 * @return        an NSString containing the dump.
 */
- (NSString *) GetDatabaseDump
{
    NSMutableString *dump = [[NSMutableString alloc] initWithCapacity:256];
    
	// info string ;) please do not remove it
	[dump appendString:@";\n; Dump generated with ZZDBHandler5iOS \n;\n; By Misato (2014)\n"];
	[dump appendString:[NSString stringWithFormat:@"; database %@;\n", [self.databaseName lastPathComponent]]];
    
	// first get all table information
	NSArray *rows = [self Query:@"SELECT * FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';"];
	// last sql query returns something like:
	// {
	// name = users;
	// rootpage = 2;
	// sql = "CREATE TABLE users (id integer primary key autoincrement, user text, password text)";
	// "tbl_name" = users;
	// type = table;
	// }
    
	//loop through all tables
	for (int i = 0; i<[rows count]; i++)
    {
        
		NSDictionary *obj = [rows objectAtIndex:i];
		//get sql "create table" sentence
		NSString *sql = [obj objectForKey:@"sql"];
		[dump appendString:[NSString stringWithFormat:@"%@;\n",sql]];
        
		//get table name
		NSString *tableName = [obj objectForKey:@"name"];
        
		//get all table content
		NSArray *tableContent = [self Query:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
        
		for (int j = 0; j<[tableContent count]; j++)
        {
			NSDictionary *item = [tableContent objectAtIndex:j];
            
			//keys are column names
			NSArray *keys = [item allKeys];
            
			//values are column values
			NSArray *values = [item allValues];
            
			//start constructing insert statement for this item
			[dump appendString:[NSString stringWithFormat:@"insert into %@ (",tableName]];
            
			//loop through all keys (aka column names)
			NSEnumerator *enumerator = [keys objectEnumerator];
			id obj;
			while (obj = [enumerator nextObject])
            {
				[dump appendString:[NSString stringWithFormat:@"%@,",obj]];
			}
            
			//delete last comma
			NSRange range;
			range.length = 1;
			range.location = [dump length]-1;
			[dump deleteCharactersInRange:range];
			[dump appendString:@") values ("];
            
			// loop through all values
			// value types could be:
			// NSNumber for integer and floats, NSNull for null or NSString for text.
            
			enumerator = [values objectEnumerator];
			while (obj = [enumerator nextObject])
            {
				//if it's a number (integer or float)
				if ([obj isKindOfClass:[NSNumber class]])
                {
					[dump appendString:[NSString stringWithFormat:@"%@,",[obj stringValue]]];
				}
				//if it's a null
				else if ([obj isKindOfClass:[NSNull class]])
                {
					[dump appendString:@"null,"];
				}
				//else is a string ;)
				else
                {
					[dump appendString:[NSString stringWithFormat:@"'%@',",obj]];
				}
                
			}
            
			//delete last comma again
			range.length = 1;
			range.location = [dump length]-1;
			[dump deleteCharactersInRange:range];
            
			//finish our insert statement
			[dump appendString:@");\n"];
            
		}
        
	}
    
	return dump;
}
/**
 *   @description   get database path.
 *   @param         nil
 *   @return        NSError  error description.
 */
- (NSString *)getDatabasePath
{
    if([[NSFileManager defaultManager] fileExistsAtPath:self.databaseName])
    {
		// Already Full Path
		return databaseName;
	}
    else
    {
        // Get the documents directory
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        
        //Get Full Path
        return [docsDir stringByAppendingPathComponent:self.databaseName];
	}
}
/**
 *   @description   generate error code.
 *   @param         code     error code
 *   @return        NSError  error info
 */

- (NSError *)createDBErrorWithDescription:(NSString*)description andCode:(int)code
{
    NSDictionary *userInfo = [[NSDictionary alloc]
                              initWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil];
	NSError *error = [NSError errorWithDomain:@"SQLite Error" code:code userInfo:userInfo];
    
	return error;
}

@end
