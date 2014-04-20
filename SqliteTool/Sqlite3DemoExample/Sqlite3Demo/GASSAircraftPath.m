/**************************************************************
 *  GASSAircraftPath.m
 *
 *  Airport路径
 *
 *  Created by zhangzhe  on 13-4-16.
 *  Copyright (c) 2013年 HaiFeng. All rights reserved.
 ***************************************************************/

#define INITIAL_POINT_SPACE 1000
#define MINIMUM_METERS_BETWEEN_PATH_POINTS 5.0

#import "GASSAircraftPath.h"
#import "ZZDBHandler.h"
@interface GASSAircraftPath()
@property(nonatomic,readonly) NSUInteger pointsSpace;  //数组的当前长度
@end

@implementation GASSAircraftPath
@synthesize pointsBase;
@synthesize pointsCount;
@synthesize pointsSpace;

/**********************************************************************
 * 函数描述：
 *         初始化 创建GASSAircraftPath数组
 *
 *********************************************************************/
- (id) initPath
{
    if(self = [super init])
    {
        // initialize point storage and place this first coordinate in it
        pointsSpace = INITIAL_POINT_SPACE;
        pointsBase = malloc(sizeof(MKMapPoint) * pointsSpace);
        pointsCount = 0;
    }
    return self;
}
/**********************************************************************
 * 函数描述：
 *         向数组中添加点轨迹
 *
 *********************************************************************/
- (void) addPoint:(MKMapPoint)newPoint
{
    if (pointsCount > 0)
    {
        MKMapPoint prevPoint = pointsBase[pointsCount - 1];
        
        // Get the distance between this new point and the previous point.
        CLLocationDistance metersApart = MKMetersBetweenMapPoints(newPoint, prevPoint);
        
        if (metersApart > MINIMUM_METERS_BETWEEN_PATH_POINTS)
        {
            // Grow the points array if necessary
            if (pointsSpace == pointsCount)
            {
                pointsSpace *= 2;
                pointsBase = realloc(pointsBase, pointsSpace  * sizeof(MKMapPoint));
            }
            else
            {
                // Add the new point to the points array
                pointsBase[pointsCount] = newPoint;
                pointsCount++;
            }
        }
    }//if
    else
    {
        // Add the new point to the points array
        pointsBase[pointsCount] = newPoint;
        pointsCount++;
    }
}
/**********************************************************************
 * 函数描述：
 *         向数组中添加点轨迹
 *
 *********************************************************************/
- (void) addCoordinate : (CLLocationCoordinate2D) coordinate
{
    [self addPoint:MKMapPointForCoordinate(coordinate)];
}
/**********************************************************************
 * 函数描述：
 *        返回最后一个坐标点
 *
 *********************************************************************/
- (MKMapPoint) getCoordinate:(NSUInteger) index
{
    return self.pointsBase[index];
    
}
- (CLLocationCoordinate2D) getCoordinateData:(NSInteger) index
{
    return  MKCoordinateForMapPoint(self.pointsBase[index-1]);
}
/**********************************************************************
 * 函数描述：
 *         析构函数 释放数组所占内存空间.
 *
 *********************************************************************/
- (void) dealloc
{
    if (pointsBase != nil)
    {
        free(pointsBase);
        pointsBase = nil;
    }
}
- (void) SaveToSqliteWithId:(NSString*) flightplanID
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    //首先删除原来的数据
    [self DeleteFromSqliteByID:flightplanID];
    for (int i=0; i<pointsCount; i++)
    {
        NSString *sql = [NSString stringWithFormat:@"insert into linecenter(flightplanid,serialnum,longitude,latitude) values ('%@','%d','%@','%@')",flightplanID,i,[NSNumber numberWithDouble:[self getCoordinateData:(i+1)].longitude ],[NSNumber numberWithDouble:[self getCoordinateData:(i+1)].latitude]];
        
        [_dbHandler Execude:sql];
    }
}
-(void) GetDataFromSqliteForFlightID:(NSString*)flightplanID
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    NSString *query = [NSString stringWithFormat:@"select * from linecenter where flightplanid='%@' order by serialnum;",flightplanID];
  
    NSArray * result = [_dbHandler Query:query];
    for (NSDictionary* dict  in result)
    {
       long laittude  =  [[dict objectForKey:@"latitude"] doubleValue];
       long longitude = [[dict objectForKey:@"longitude"] doubleValue];
        
       CLLocationCoordinate2D coordinate =  CLLocationCoordinate2DMake(laittude, longitude);
        [self addCoordinate:coordinate];
    }

}
- (void) DeleteFromSqliteByID:(NSString*) flightID
{
    ZZDBHandler *_dbHandler = [ZZDBHandler sharedDBInstance:DATABASENAME];
    
    //首先删除原来的数据
    NSString *sql = [NSString stringWithFormat:@"delete from linecenter where flightplanid='%@';",flightID];
    [_dbHandler Execude:sql];
    
}
@end;
