//
//  WeatherTable.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "WeatherTable.h"

@implementation WeatherTable

@synthesize tableData,weekdayData,highData,lowData,conditionData,rainData,snowData;

-(void) loadView
{
    //NSLog(@"1");
    
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
    static NSString *simpleTableID = @"WeatherTableCell";
    
    WeatherTableCell *cell = (WeatherTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableID];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WeatherTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *degree = @"°C";
    
    cell.date.text = [tableData objectAtIndex:indexPath.row];
    cell.weekday.text = [weekdayData objectAtIndex:indexPath.row];
    cell.HILO.text = [NSString stringWithFormat:@"%@%@ >> %@%@",[lowData objectAtIndex:indexPath.row],degree,[highData objectAtIndex:indexPath.row],degree] ;
    cell.condition.text = [conditionData objectAtIndex:indexPath.row];
    cell.wet.text = [NSString stringWithFormat:@"Rain: %@mm",[rainData objectAtIndex:indexPath.row]] ;
    cell.snow.text = [NSString stringWithFormat:@"Snow: %@cm",[snowData objectAtIndex:indexPath.row]] ;
    
    
    
    
    cell.weekday.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    cell.wet.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:18];
    cell.snow.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:18];
    cell.condition.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    cell.HILO.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:28];
    cell.date.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    //NSLog(@"count = %i",[tableData count]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
