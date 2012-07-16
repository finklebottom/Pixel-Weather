//
//  HourlyTableViewController.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-15.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HourlyTableCell.h"

@interface HourlyTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *timeData, *tempData, *highData, *lowData, *conditionData, *rainData, *snowData;
    UITableView *forecastTable;
}

@property(nonatomic, retain) NSArray* timeData;
@property(nonatomic, retain) NSArray* tempData;
@property(nonatomic, retain) NSArray* highData;
@property(nonatomic, retain) NSArray* lowData;
@property(nonatomic, retain) NSArray* conditionData;
@property(nonatomic, retain) NSArray* rainData;
@property(nonatomic, retain) NSArray* snowData;

@end