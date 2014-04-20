//
//  GASSFlightPlanManager.h
//  Sqlite3Demo
//
//  Created by zhangzhe on 14-4-21.
//  Copyright (c) 2014年 Haifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GASSFlightPlanManager : NSObject
- (id) initGASSFlightPlanManager;
- (NSArray*) GetAllFlightPlanFromSqlite;
- (void) SaveAllFlightPlanToSqlite:(NSArray*) allFlightPlans;
@end
