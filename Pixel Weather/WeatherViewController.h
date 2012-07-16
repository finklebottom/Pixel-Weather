//
//  WeatherViews.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherView.h"
#import "WeatherTable.h"
#import "WeatherParser.h"
#import "HourlyTableViewController.h"

@class WeatherView;
@class WeatherTable;
@class HourlyTableViewController;

@interface WeatherViewController : UIViewController
{
    WeatherView *theView;
    WeatherTable *tableView;
    HourlyTableViewController *hourlyTable;
    
	NSString    *message;
    UIColor     *color;
    
    NSMutableDictionary *objects, *objectForecast;
    
    NSDateFormatter *dateFormatter;
    
    
}

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSMutableDictionary *objects;  
@property (nonatomic, retain) NSMutableDictionary *objectForecast;

- (id)initWithMessage:(NSString *)theMessage withColor:(UIColor *)color;
- (void) loadWeather;
- (void) showWeatherFor:(NSString *)query;
- (void) updateUI:(WeatherParser *)weather ;
- (NSString *)getStringAtLocation:(NSString *)str atPosition:(int) x;
- (void)showWeatherForecast:(NSString *)query;
- (void)updateUIForecast:(WeatherParser *)weather;
- (void) loadWeatherForecast;



@end
