//
//  WeatherParser.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherParser : NSObject
{
    NSString *condition, *location, *currentTemp, *lowTemp, *highTemp;
    NSURL *conditionImageURL;
    
    NSMutableDictionary *elementDictionary,*objectAttributes,*object;
    
    NSMutableArray *weekday,*datee, *qpf, *snow, *high, *low, *cond, *wind;
}

@property (nonatomic,retain) NSString *condition, *location, *currentTemp, *lowTemp, *highTemp;
@property (nonatomic,retain) NSURL *conditionImageURL;
@property (nonatomic,retain) NSMutableDictionary *elementDictionary,*objectAttributes,*object;
@property (nonatomic,retain) NSMutableArray *weekday,*datee, *qpf, *snow, *high, *low, *cond, *wind;

- (WeatherParser *)initWithQuery:(NSString *)query;
- (WeatherParser *)fullParseWithQuery:(NSString *)query path:(NSString *)nodePath;
- (void)parseWithQuery:(NSString *)query;

@end
