//
//  GASSFlightPlanManager.m
//  Sqlite3Demo
//
//  Created by zhangzhe on 14-4-21.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import "GASSFlightPlanManager.h"
#import "ZZDBHandler.h"
#import "GASSFlightPlanModel.h"

@implementation GASSFlightPlanManager
- (id) initGASSFlightPlanManager
{
    if (self = [super init])
    {
        //创建两个表flightplan和linecenter 其中flightplan组合了linecenter
        //lincenteter中包含一个外键指向flightplan
        NSString *createFlightPlanSql = @"CREATE TABLE  if not exists flightplan(_id integer primary key autoincrement,flightplanid text NOT NULL UNIQUE,takeoffairp integer,takeoffairport text,landingairp integer,landingairport text,flighttask text,planetype text,planenum integer,estimateontime text,estimateofftime text,airlinedescription text,planeid text,pilotname text,planstate text,midstoptime text,midstopnum integer,planeradius text,taskmethod text,tasktype text,altitude text)";
        
        NSString *createLineCenterSql = @"CREATE TABLE  if not exists linecenter(_id integer primary key autoincrement,flightplanid text NOT NULL,serialnum integer,longitude real,latitude real)";
       
        ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
        [_dbHandler Execude:createFlightPlanSql];
        [_dbHandler Execude:createLineCenterSql];
    }
    return self;
}
- (NSArray*) GetAllFlightPlanFromSqlite
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    NSString *query = @"select * from flightplan;";
    NSArray * result = [_dbHandler Query:query];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary* dict  in result)
    {
        GASSFlightPlanModel *model = [[GASSFlightPlanModel alloc] initFlightPlan];
        [model GetDataFromSqlite:dict];
        [array addObject:model];
    }
    return array;

}
- (void) SaveAllFlightPlanToSqlite:(NSArray*) allFlightPlans
{
    NSLog(@"%d",allFlightPlans.count);
    for (GASSFlightPlanModel* model in allFlightPlans)
    {
        [model SaveToSqlite];
    }
}
@end
