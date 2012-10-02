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
        forecastView   = [[WeatherView alloc] initWithFrame:rectFrame];
        forecastView.backgroundColor = color;
        forecastView.myController = self;
        forecastView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self loadWeatherForecast];
        
        if(weatherTableView == nil)
        {
            weatherTableView = [[WeatherTable alloc] init];
            
            weatherTableView.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
        }
        
        weatherTableView.tableView.backgroundColor = color;
        weatherTableView.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        weatherTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        weatherTableView.tableView.separatorColor = [UIColor redColor];
        
        //
        
        //self.view = weatherTableView.tableView;
        //[self.view addSubview:tableView.tableView];
        
        [forecastView addSubview:weatherTableView.tableView];
        
        self.view = forecastView;
        
    }
    else if(message == @"Hourly")
    {
        hourlyView   = [[WeatherView alloc] initWithFrame:rectFrame];
        hourlyView.backgroundColor = color;
        hourlyView.myController = self;
        hourlyView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self loadWeatherHourly];
        
        if(hourlyTable == nil)
        {
            hourlyTable = [[HourlyTableViewController alloc] init];
            
            hourlyTable.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 460) style:UITableViewStylePlain];
        }
        
        hourlyTable.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        hourlyTable.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        hourlyTable.tableView.separatorColor = [UIColor redColor];
        hourlyTable.tableView.backgroundColor = [UIColor clearColor];
        
       
        
        [hourlyView addSubview:hourlyTable.tableView];
        
        self.view = hourlyView;
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
    
    theView.currentTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , 0, 140, 60)];
    theView.currentTempLabel.text = @"[...]°C";
    theView.currentTempLabel.textColor = [UIColor  greenColor];
    theView.currentTempLabel.backgroundColor = theView.backgroundColor;
    theView.currentTempLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:100];
    
    theView.timeStamp = [[UILabel alloc] initWithFrame:CGRectMake(140 , 10, 180, 20)];
    theView.timeStamp.text = @"";
    theView.timeStamp.textColor = [UIColor  greenColor];
    theView.timeStamp.backgroundColor = theView.backgroundColor;
    theView.timeStamp.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    theView.timeStamp.textAlignment = NSTextAlignmentRight;
    
    theView.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(140 , 30, 180, 20)];
    theView.cityLabel.text = @"[...]";
    theView.cityLabel.textColor = [UIColor  greenColor];
    theView.cityLabel.backgroundColor = theView.backgroundColor;
    theView.cityLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    theView.cityLabel.textAlignment = NSTextAlignmentRight;
    
    theView.conditionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 60, 150, 25)];
    theView.conditionsLabel.text = @"[...]";
    theView.conditionsLabel.textColor = [UIColor  greenColor];
    theView.conditionsLabel.backgroundColor = theView.backgroundColor;
    theView.conditionsLabel.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:30];
    theView.conditionsLabel.textAlignment = NSTextAlignmentCenter;
    
    //sky view ... set color
    UIColor *skyColor = [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f];

    
    UIView *sky = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, 320)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 1.0f;
    [theView addSubview:sky];
    
    sky = [[UIView alloc] initWithFrame:CGRectMake(0, 90, 320, 10)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 0.1f;
    [theView addSubview:sky];
   
    
    sky = [[UIView alloc] initWithFrame:CGRectMake(0, 90, 320, 10)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 0.2f;
    [theView addSubview:sky];
    
    
    sky = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 15)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 0.5f;
    [theView addSubview:sky];
    
    sky = [[UIView alloc] initWithFrame:CGRectMake(0, 115, 320, 15)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 0.6f;
    [theView addSubview:sky];
    
    sky = [[UIView alloc] initWithFrame:CGRectMake(0, 130, 320, 20)];
    sky.backgroundColor  = skyColor;
    sky.alpha = 0.9f;
    [theView addSubview:sky];
    

    
    
    //atmosphere image
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
    NSString *imgFilepath = [[NSBundle mainBundle] pathForResource:@"PixelWeather_atmo" ofType:@"png"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgFilepath];
    //[imgView setImage:img];
    //[theView addSubview:imgView];
    
    //cat image
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280, 191, 175)];
    imgFilepath = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"png"];
    img = [[UIImage alloc] initWithContentsOfFile:imgFilepath];
    [imgView setImage:img];
    [theView addSubview:imgView];
    
    //sun image
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(210, 140, 161, 146)];
    imgFilepath = [[NSBundle mainBundle] pathForResource:@"sun1" ofType:@"png"];
    img = [[UIImage alloc] initWithContentsOfFile:imgFilepath];
    [imgView setImage:img];
    [theView addSubview:imgView];
    
    //city image
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 320, 255)];
    imgFilepath = [[NSBundle mainBundle] pathForResource:@"PixelWeather_city" ofType:@"png"];
    img = [[UIImage alloc] initWithContentsOfFile:imgFilepath];
    [imgView setImage:img];
    [theView addSubview:imgView];
    

    
    [theView addSubview:theView.currentTempLabel];
    [theView addSubview:theView.cityLabel];
    [theView addSubview:theView.conditionsLabel];
    [theView addSubview:theView.timeStamp];
    
    // Add timer to handle timestamp update
    [NSTimer scheduledTimerWithTimeInterval: 0.1f target:self
                                   selector:@selector(handleTimer_1:) userInfo:nil repeats:YES];
    
    // Do this in the background so we don't lock up the UI.
    [self performSelectorInBackground:@selector(showWeatherFor:) withObject:@"Canada/Toronto"];
    
    
}

-(void) loadWeatherForecast
{
    
    // Do this in the background so we don't lock up the UI.
    [self performSelectorInBackground:@selector(showWeatherForecast:) withObject:@"Canada/Toronto"];
    
    
}

-(void) loadWeatherHourly
{
    
    // Do this in the background so we don't lock up the UI.
    [self performSelectorInBackground:@selector(showWeatherHourly:) withObject:@"Canada/Toronto"];
    
    
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



// This will run in the background
- (void)showWeatherHourly:(NSString *)query
{
    
    //WeatherParser *weather = [[WeatherParser alloc] initWithQuery:query];
    WeatherParser *weather = [[WeatherParser alloc] fullParseWithQuery:query path:@"/response/current_observation"];
    
    objects = weather.object;
    
    [self performSelectorOnMainThread:@selector(updateUIHourly:) withObject:weather waitUntilDone:NO];
    
}


// This happens in the main thread
- (void)updateUIForecast:(WeatherParser *)weather
{

    
    for(NSString* strDate in weather.datee)
    {
        //NSLog(@"%@",strDate);
    }
    
    
    weatherTableView.tableData = weather.datee;
    weatherTableView.weekdayData = weather.weekday;
    weatherTableView.highData = weather.high;
    weatherTableView.lowData = weather.low;
    weatherTableView.conditionData = weather.cond;
    weatherTableView.rainData = weather.qpf;
    weatherTableView.snowData = weather.snow;
    
    //NSLog(@"%@",[tableView.tableData objectAtIndex:0]);
    
    [weatherTableView.tableView reloadData];
    
    
}

// This happens in the main thread
- (void)updateUI:(WeatherParser *)weather
{
    theView.currentTempLabel.text = [theView.currentTempLabel.text stringByReplacingOccurrencesOfString:@"[...]"
        withString:[NSString stringWithFormat:@"%i",
                    [[[objects valueForKey:@"temp_c"] objectForKey:@"value"] integerValue] 
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

// This happens in the main thread
- (void)updateUIHourly:(WeatherParser *)weather
{
    hourlyTable.timeData = weather.hourlyTime;
    hourlyTable.tempData = weather.hourlyTemp;
    hourlyTable.conditionData = weather.hourlyCondition;
    hourlyTable.rainData = weather.hourlyRain;
    
    //NSLog(@"%@",[tableView.tableData objectAtIndex:0]);
    
    [hourlyTable.tableView reloadData];
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
