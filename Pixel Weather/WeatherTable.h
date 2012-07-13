//
//  WeatherTable.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherTableCell.h"


@interface WeatherTable : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData, *weekdayData, *highData, *lowData, *conditionData, *rainData, *snowData;
    UITableView *forecastTable;
}

@property(nonatomic, retain) NSArray* tableData;
@property(nonatomic, retain) NSArray* weekdayData;
@property(nonatomic, retain) NSArray* highData;
@property(nonatomic, retain) NSArray* lowData;
@property(nonatomic, retain) NSArray* conditionData;
@property(nonatomic, retain) NSArray* rainData;
@property(nonatomic, retain) NSArray* snowData;

@end
