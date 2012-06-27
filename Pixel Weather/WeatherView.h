//
//  WeatherView.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherViewController.h"
#import "WeatherParser.h"

@class WeatherViewController;

@interface WeatherView : UIView
{
    
	WeatherViewController *myController;
    
    UILabel *currentTempLabel;
    UILabel *highTempLabel;
    UILabel *lowTempLabel;
    UILabel *conditionsLabel;
    UILabel *cityLabel;
    UILabel *timeStamp;
    
}

@property(nonatomic, retain) WeatherViewController* myController;
@property(nonatomic, retain) UILabel* currentTempLabel;
@property(nonatomic, retain) UILabel* cityLabel;
@property(nonatomic, retain) UILabel* conditionsLabel;
@property(nonatomic, retain) UILabel* timeStamp;



@end