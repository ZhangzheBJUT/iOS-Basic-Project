//
//  HFViewController.m
//  Sqlite3Demo
//
//  Created by zhangzhe on 14-4-21.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import "HFViewController.h"
#import "GASSFlightPlanModel.h"
#import "GASSAircraftPath.h"
#import "GASSFlightPlanManager.h"

@interface HFViewController ()
@end
@implementation HFViewController

- (IBAction)dbaction:(id)sender
{
    NSMutableArray *array = [NSMutableArray array];
    //准备数据
    GASSFlightPlanModel* model = [[GASSFlightPlanModel alloc ] initFlightPlan];
    model.flightPlanID = @"RS0234";
    model.takeoffairp  = 101;
    
    model.takeoffairport = @"密云机场";
    model.landingairp    = 123;
    model.landingairport = @"华斌机场";
    model.flightTask     = @"观光";
    model.planeType      = @"da40d";
    
    model.estimateOnTime     = @"2014-03-09";
    model.estimateOffTime    = @"2-14-04-06";
    model.airLineDescription = @"A->B-D";
    
    model.planeID   = @"ER405";
    model.pilotName = @"Zhangzhe";
    model.planState = @"启动";
    model.planeNum  = 20;
    
    model.midStopTime=@"1009-09-09";
    model.midStopNum = 3;
    model.planeradius = @"20";
    model.taskMethod  = @"taskmethod";
    
    model.taskType = @"tasktype";
    model.altitude = @"2000";
       //创建组合对象
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(10.2, 10.3)];
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(20.4, 20.5)];
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(20.6, 20.7)];
    
    //保持数据到Sqlite
    [array addObject:model];
    //[model SaveToSqlite];
    
    
    model = [[GASSFlightPlanModel alloc ] initFlightPlan];
    model.flightPlanID = @"RS06789";
    model.takeoffairp  = 101;
    
    model.takeoffairport = @"密云机场";
    model.landingairp    = 123;
    model.landingairport = @"华斌机场";
    model.flightTask     = @"观光";
    model.planeType      = @"da40d";
    
    model.estimateOnTime     = @"2014-03-09";
    model.estimateOffTime    = @"2-14-04-06";
    model.airLineDescription = @"A->B-D";
    
    model.planeID   = @"ER405";
    model.pilotName = @"Zhangzhe";
    model.planState = @"启动";
    model.planeNum  = 20;
    
    model.midStopTime=@"1009-09-09";
    model.midStopNum = 3;
    model.planeradius = @"20";
    model.taskMethod  = @"taskmethod";
    
    model.taskType = @"tasktype";
    model.altitude = @"2000";
    //创建组合对象
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(10.2, 10.3)];
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(20.4, 20.5)];
    [model.aircraftPath addCoordinate:CLLocationCoordinate2DMake(20.6, 20.7)];
    
    //保持数据到Sqlite
    //[model SaveToSqlite];
    [array addObject:model];

    //保持数据
    GASSFlightPlanManager *manager = [[GASSFlightPlanManager alloc] initGASSFlightPlanManager];
    [manager SaveAllFlightPlanToSqlite:array];
    
    
    //查询数据
    NSArray * result = [manager GetAllFlightPlanFromSqlite];
    int i  = 0;
    for (GASSFlightPlanModel *model  in result)
    {
        NSLog(@"第%d个%@",++i,model.flightPlanID);
    }
}
- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
