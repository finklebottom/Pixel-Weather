//
//  WeatherViews.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-23.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "WeatherViewController.h"

@implementation WeatherViewController

@synthesize objects,message, color, objectForecast;

- (id)initWithMessage:(NSString *)theMessage withColor:(UIColor *)theColor
{
	if (self = [super initWithNibName:nil bundle:nil])
    {
		self.message = theMessage;
        self.color = theColor;
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
		//self.tabBarItem.image  = image;
	}	
	return self;
}



- (void)loadView
{
    //NSLog(@"1 > WeatherViewController.loadView ");
    
	CGRect	rectFrame = [UIScreen mainScreen].applicationFrame;
    
    if(message == @"Forecast")
    {
        if(tableView == nil)
        {
            tableView = [[WeatherTable alloc] init];
            
            tableView.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
        }
        
        tableView.tableView.backgroundColor = color;
        tableView.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self loadWeatherForecast];
        self.view = tableView.tableView;
        //[self.view addSubview:tableView.tableView];
        
    }
    else
    {
        theView   = [[WeatherView alloc] initWithFrame:rectFrame];
        theView.backgroundColor = color;
        theView.myController = self;
        theView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self loadWeather];
        self.view = theView;
    }
    
    
    
}

-(void) loadWeather
{
    //NSLog(@"2 > WeatherView.loadView ");
    
    theView.currentTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , 0, 100, 50)];
    theView.currentTempLabel.text = @"[...]°C";
    theView.currentTempLabel.textColor = [UIColor blackColor];
    theView.currentTempLabel.backgroundColor = theView.backgroundColor;
    theView.currentTempLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:80];
    
    theView.timeStamp = [[UILabel alloc] initWithFrame:CGRectMake(120 , 8, 220, 20)];
    theView.timeStamp.text = @"";
    theView.timeStamp.textColor = [UIColor blackColor];
    theView.timeStamp.backgroundColor = theView.backgroundColor;
    theView.timeStamp.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    
    theView.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 , 28, 220, 20)];
    theView.cityLabel.text = @"[...]";
    theView.cityLabel.textColor = [UIColor blackColor];
    theView.cityLabel.backgroundColor = theView.backgroundColor;
    theView.cityLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    
    theView.conditionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 , 50, 320, 20)];
    theView.conditionsLabel.text = @"[...]";
    theView.conditionsLabel.textColor = [UIColor blackColor];
    theView.conditionsLabel.backgroundColor = theView.backgroundColor;
    theView.conditionsLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    
    [theView addSubview:theView.currentTempLabel];
    [theView addSubview:theView.cityLabel];
    [theView addSubview:theView.conditionsLabel];
    [theView addSubview:theView.timeStamp];
    
    // Add timer to handle timestamp update
    [NSTimer scheduledTimerWithTimeInterval: 0.1f target:self
                                   selector:@selector(handleTimer_1:) userInfo:nil repeats:YES];
    
    // Do this in the background so we don't lock up the UI.
    [self performSelectorInBackground:@selector(showWeatherFor:) withObject:@"Toronto"];
    
    
}

-(void) loadWeatherForecast
{
    
    // Do this in the background so we don't lock up the UI.
    [self performSelectorInBackground:@selector(showWeatherForecast:) withObject:@"Toronto"];
    
    
}


// This will run in the background
- (void)showWeatherFor:(NSString *)query
{
    
    //WeatherParser *weather = [[WeatherParser alloc] initWithQuery:query];
    WeatherParser *weather = [[WeatherParser alloc] fullParseWithQuery:query path:@"/response/current_observation"];
    
    objects = weather.object;
    
    //WeatherParser *weatherForecast = [[WeatherParser alloc] parseWithQuery:query path:@"/response/forecast/simpleforecast/forecastdays/forecastday/date"];
    
    //objects = weather.object;
    
    //objectForecast = weatherForecast.object;
    
    
    
    //[objectForecast enumerateKeysAndObjectsUsingBlock:^(id key,id objec, BOOL *stop)
     //{
     //    NSLog(@"%@ = %@", key, objec);
     //}];
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:weather waitUntilDone:NO];
    

    
}


// This will run in the background
- (void)showWeatherForecast:(NSString *)query
{
    
    //WeatherParser *weather = [[WeatherParser alloc] initWithQuery:query];
    WeatherParser *weather = [[WeatherParser alloc] fullParseWithQuery:query path:@"/response/current_observation"];

    [self performSelectorOnMainThread:@selector(updateUIForecast:) withObject:weather waitUntilDone:NO];
    
    
    
}

// This happens in the main thread
- (void)updateUIForecast:(WeatherParser *)weather
{

    
    for(NSString* strDate in weather.datee)
    {
        //NSLog(@"%@",strDate);
    }
    
    
    tableView.tableData = weather.datee;
    
    NSLog(@"%@",[tableView.tableData objectAtIndex:0]);
    
    [tableView.tableView reloadData];
    
    
}

// This happens in the main thread
- (void)updateUI:(WeatherParser *)weather
{
    theView.currentTempLabel.text = [theView.currentTempLabel.text stringByReplacingOccurrencesOfString:@"[...]"
        withString:[NSString stringWithFormat:@"%@",
                    [[objects valueForKey:@"temp_c"] objectForKey:@"value"]
                    ]];
    
    //NSDate* currentDate = [NSDate date];
    //theView.timeStamp.text = [dateFormatter stringFromDate:currentDate];
    
    theView.cityLabel.text = [theView.cityLabel.text stringByReplacingOccurrencesOfString:@"[...]"
        withString:[NSString stringWithFormat:@"%@",
                    [self getStringAtLocation:[[objects valueForKey:@"display_location"] objectForKey:@"value"] atPosition:1]
                    ]];
    
    theView.conditionsLabel.text = [theView.conditionsLabel.text stringByReplacingOccurrencesOfString:@"[...]"
        withString:[NSString stringWithFormat:@"%@",
                    [[objects valueForKey:@"weather"] objectForKey:@"value"]
                    ]];
    
    //[currentTempLabel setText:[NSString stringWithFormat:@"%d", weather.currentTemp]];
    //[highTempLabel setText:[NSString stringWithFormat:@"%d", weather.highTemp]];
    //[lowTempLabel setText:[NSString stringWithFormat:@"%d", weather.lowTemp]];
    //[conditionsLabel setText:weather.condition];
    //[cityLabel setText:weather.location];
    
    for(NSString* strDate in weather.datee)
    {
        //NSLog(@"%@",strDate);
    }
    
}

- (NSString *)getStringAtLocation:(NSString *)str atPosition:(int) x
{
    NSString *found;
    NSString *set;
    NSArray *split;
    
    set = @"\n\t\t";
    
    split = [str componentsSeparatedByString:set];
    
    found = [split objectAtIndex:x];
    
    return found;
}

- (void) handleTimer_1: (NSTimer *) timer
{
    NSDate* currentDate = [NSDate date];
    theView.timeStamp.text = [dateFormatter stringFromDate:currentDate];
}


@end
