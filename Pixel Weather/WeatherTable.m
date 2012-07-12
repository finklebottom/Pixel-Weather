//
//  WeatherTable.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "WeatherTable.h"

@implementation WeatherTable

@synthesize tableData;

-(void) loadView
{
    NSLog(@"1");
    
    [forecastTable setDataSource:self];
    [forecastTable setDelegate:self];
    
    //NSLog(@"2");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableID = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableID];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    //NSLog(@"count = %i",[tableData count]);
    return cell;
}

@end
