//********************************************************
//  GASSFlightPlanModel.h
//  GASSEFB
//
//  Created by zhangzhe on 13-7-12.
//  Copyright (c) 2013年 Haifeng. All rights reserved.
//******************************************************/

#import <MapKit/MapKit.h>

//计划状态
typedef enum
{
    PERMITTED = 0,        //已经批准
    TASKON,               //执行中
    START,                //开车
    TAKEOFF,              //起飞
    LANDED,               //降落
    STOP,                 //停车
    COMPLETE              //完成
}PLANSTATE;


//任务类型
typedef enum
{
    SAMEAIRPORT = 0,      //本场飞行
    DIFFERENTAIRPORT      //转场飞行
}TASKTYPE;

//飞行方法
typedef enum
{
    FLIGHTUSINGDEVICE = 0, //仪表飞行
    FLIGHTUSINGEYES        //转场飞行
}TASKMETHOD;


@class GASSAircraftPath;

@interface GASSFlightPlanModel : NSObject

@property (strong, nonatomic) NSString  *flightPlanID;       //日飞行计划的编号
@property (assign, nonatomic) NSInteger takeoffairp;         //起飞机场的ID
@property (strong, nonatomic) NSString  *takeoffairport;     //起飞机场的名字
@property (assign, nonatomic) NSInteger landingairp;         //降落机场的ID
@property (strong, nonatomic) NSString  *landingairport;     //降落机场的名字
@property (strong, nonatomic) NSString  *flightTask;         //飞行的任务
@property (strong, nonatomic) NSString  *planeType;          //飞机机型
@property (assign, nonatomic) NSInteger planeNum;            //飞机的数量
@property (strong, nonatomic) NSString  *estimateOnTime;     //预计起飞时间
@property (strong, nonatomic) NSString  *estimateOffTime;    //预计降落时间
@property (strong, nonatomic) NSString  *airLineDescription; //航线描述
@property (strong, nonatomic) GASSAircraftPath *aircraftPath;//航线中心点
@property (strong, nonatomic) NSString  *planeID;            //飞机注册号
@property (strong, nonatomic) NSString  *pilotName;          //飞行员名称
@property (strong, nonatomic) NSString  *planState;          //计划的状态
@property (assign, nonatomic) NSString  *midStopTime;        //中途起降时间
@property (assign, nonatomic) NSInteger midStopNum;          //中途起降次数
@property (strong, nonatomic) NSString  *planeradius;        //飞行半径
@property (strong, nonatomic) NSString  *taskMethod;         //飞行方法
@property (strong, nonatomic) NSString  *taskType;           //任务类型
@property (strong, nonatomic) NSString  *altitude;           //飞行高度

-(id) initFlightPlan;

- (void) SaveToSqlite;
- (void) GetDataFromSqlite:(NSDictionary*) dict;
- (void) DeleteFromSqlite;
@end
