//
//  WeatherViews.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherView.h"
#import "WeatherParser.h"

@class WeatherView;

@interface WeatherViewController : UIViewController
{
    WeatherView *theView;
    
	NSString    *message;
    UIColor     *color;
    
    NSMutableDictionary *objects;
    
    NSDateFormatter *dateFormatter;
    
    
}

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSMutableDictionary *objects;

- (id)initWithMessage:(NSString *)theMessage withColor:(UIColor *)color;
- (void) loadWeather;
- (void) showWeatherFor:(NSString *)query;
- (void) updateUI:(WeatherParser *)weather;
- (NSString *)getStringAtLocation:(NSString *)str atPosition:(int) x;


@end
