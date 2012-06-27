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
}

@property (nonatomic,retain) NSString *condition, *location, *currentTemp, *lowTemp, *highTemp;
@property (nonatomic,retain) NSURL *conditionImageURL;
@property (nonatomic,retain) NSMutableDictionary *elementDictionary,*objectAttributes,*object;

- (WeatherParser *)initWithQuery:(NSString *)query;
- (WeatherParser *)fullParseWithQuery:(NSString *)query;

@end
