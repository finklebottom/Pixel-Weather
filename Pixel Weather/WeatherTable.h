//
//  WeatherTable.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WeatherTable : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    UITableView *forecastTable;
}

@property(nonatomic, retain) NSArray* tableData;

@end
