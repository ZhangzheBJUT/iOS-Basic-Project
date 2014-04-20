/**************************************************************
 *  GASSAircraftPath.h
 *
 *  Airport路径数组
 *
 *  Created by zhangzhe  on 13-4-16.
 *  Copyright (c) 2013年 HaiFeng. All rights reserved.
 ***************************************************************/

#import <MapKit/MapKit.h>

@interface GASSAircraftPath : NSObject
{
    MKMapPoint *pointsBase;      //数组的基地址
    NSUInteger pointsCount;      //数组元素个数
}
- (id)   initPath;
- (void) addCoordinate : (CLLocationCoordinate2D) coordinate;
- (void) addPoint:(MKMapPoint)newPoint;

- (MKMapPoint) getCoordinate:(NSUInteger) index;
- (CLLocationCoordinate2D) getCoordinateData:(NSInteger) index;

- (void) SaveToSqliteWithId:(NSString*) flightplanID;
- (void) GetDataFromSqliteForFlightID:(NSString*)flightID;
- (void) DeleteFromSqliteByID:(NSString*) flightID;

@property (readonly) MKMapPoint *pointsBase;
@property (readonly) NSUInteger pointsCount;

@end
