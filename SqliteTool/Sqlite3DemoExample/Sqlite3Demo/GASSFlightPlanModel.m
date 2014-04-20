//********************************************************
//  GASSFlightPlanModel.m
//  GASSEFB
//
//  Created by zhangzhe on 13-7-12.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//******************************************************/


#import "GASSFlightPlanModel.h"
#import "GASSAircraftPath.h"
#import "ZZDBHandler.h"

@implementation GASSFlightPlanModel

@synthesize flightPlanID  = _flightPlanID;
@synthesize takeoffairp   = _takeoffairp;
@synthesize takeoffairport=_takeoffairport;
@synthesize landingairp   = _landingairp;
@synthesize landingairport=_landingairport;
@synthesize flightTask    = _flightTask;
@synthesize planeType     = _planeType;
@synthesize planeNum        = _planeNum;
@synthesize estimateOnTime  = _estimateOnTime;
@synthesize estimateOffTime    = _estimateOffTime;
@synthesize airLineDescription = _airLineDescription;
@synthesize aircraftPath = _aircraftPath;
@synthesize planeID      = _planeID;
@synthesize pilotName    = _pilotName;
@synthesize planState    = _planState;
@synthesize midStopTime  = _midStopTime;
@synthesize midStopNum   = _midStopNum;
@synthesize planeradius  = _planeradius;
@synthesize taskMethod   = _taskMethod;
@synthesize taskType     = _taskType;
@synthesize altitude     = _altitude;

/**********************************************************************
 * 函数描述：
 *         初始化 创建GASSZonePath数组
 *
 *********************************************************************/
-(id) initFlightPlan
{
    if (self = [super init])
    {
        self.aircraftPath = [[GASSAircraftPath alloc] initPath];
    }
    
    return self;
}

- (void) SaveToSqlite
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    //注意在进行插入前要对一些字符进行转义处理
    //转移字符 ‘ ＝＝》 ’‘
    NSString *sqlStr = [NSString stringWithFormat:@"insert into flightplan(flightplanid,takeoffairp,takeoffairport,landingairp,landingairport,flighttask,planetype,planenum,estimateontime,estimateofftime,airlinedescription,planeid,pilotname,planstate,midstoptime,midstopnum ,planeradius,taskmethod,tasktype,altitude) values ('%@','%d','%@','%d','%@','%@','%@','%d','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@');",self.flightPlanID, self.takeoffairp,self.takeoffairport,self.landingairp,self.landingairport,self.flightTask,self.planeType,self.planeNum,self.estimateOnTime,self.estimateOffTime,self.airLineDescription,self.planeID,self.pilotName,self.planState,self.midStopTime,self.midStopNum,self.planeradius,self.taskMethod,self.taskType,self.altitude];
  
    [_dbHandler Execude:sqlStr];
    [self.aircraftPath SaveToSqliteWithId:self.flightPlanID];
}

- (void) GetDataFromSqlite:(NSDictionary*) dict
{
    self.flightPlanID = [dict objectForKey:@"flightplanid"];
    self.takeoffairp  = [[dict objectForKey:@"takeoffairp"] integerValue];
    
    self.takeoffairport = [dict objectForKey:@"takeoffairport"];
    self.landingairp    = [[dict objectForKey:@"landingairp"] integerValue];
    self.landingairport = [dict objectForKey:@"landingairport"];
    self.flightTask     = [dict objectForKey:@"flighttask"];
    self.planeType      = [dict objectForKey:@"planetype"];
    self.planeNum       = [[dict objectForKey:@"planenum"] integerValue];
    self.estimateOnTime = [dict objectForKey:@"estimateontime"];
    self.estimateOffTime= [dict objectForKey:@"estimateofftime"];
    
    self.airLineDescription = [dict objectForKey:@"airlinedescription"];
    
    self.planeID     = [dict objectForKey:@"planeid"];
    self.pilotName   = [dict objectForKey:@"pilotname"];
    self.planState   = [dict objectForKey:@"planstate"];
    self.midStopTime = [dict objectForKey:@"midstoptime"];
    self.midStopNum  = [[dict objectForKey:@"midstopnum"] integerValue];
    self.planeradius = [dict objectForKey:@"planeradius"];
    self.taskMethod  = [dict objectForKey:@"taskmethod"];
    self.taskType    = [dict objectForKey:@"tasktype"];
    self.altitude    = [dict objectForKey:@"altitude"];
    
    [self.aircraftPath  GetDataFromSqliteForFlightID:self.flightPlanID];
}

- (void) DeleteFromSqlite
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    NSString *sqlStr = [NSString stringWithFormat:@"delete from flightplan where flightplanid='%@';",self.flightPlanID];
    [_dbHandler Execude:sqlStr];
    [self.aircraftPath DeleteFromSqliteByID:self.flightPlanID];
}
- (void) dealloc
{
    self.aircraftPath  = nil;                  //飞行路径

}
@end
