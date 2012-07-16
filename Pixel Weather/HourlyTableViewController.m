//
//  HourlyTableViewController.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-15.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "HourlyTableViewController.h"

@implementation HourlyTableViewController

@synthesize timeData,tempData,highData,lowData,conditionData,rainData,snowData;

-(void) loadView
{
    //NSLog(@"1");
    
    [forecastTable setDataSource:self];
    [forecastTable setDelegate:self];
    
    //NSLog(@"2");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [timeData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableID = @"HourlyTableCell";
    
    HourlyTableCell *cell = (HourlyTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableID];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HourlyTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *degree = @"°C";
    
    cell.hour.text = [timeData objectAtIndex:indexPath.row];
    cell.temp.text = [NSString stringWithFormat:@"%@%@",[tempData objectAtIndex:indexPath.row],degree];
    cell.condition.text = [conditionData   objectAtIndex:indexPath.row];
    cell.wet.text = [rainData objectAtIndex:indexPath.row];
    
    
    cell.hour.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    cell.temp.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    cell.condition.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:17];
    cell.wet.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    //cell.condition.textAlignment = UITextAlignmentLeft;
    
   
    //NSLog(@"count = %i",[tableData count]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end
