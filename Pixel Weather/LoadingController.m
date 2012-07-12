//
//  Loading.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-17.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "LoadingController.h"

@implementation LoadingController

#define SITE @"www.google.com"

- (void) loadView
{
    //
    window = [[UIWindow alloc] initWithFrame:[[UIScreen  mainScreen] bounds]] ;
    
    // Create the view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] ];
    self.view.backgroundColor = [UIColor blackColor];
    
    // Initialize variables
    displayCount = 0;
    dosHeight = 20;
    
    UIDevice *device = [UIDevice currentDevice];
    
    // get our physical location
    locationGetter = [[LocationGetter alloc] init];
    [locationGetter setDelegate:self];
    [locationGetter startUpdates];
    
    
    // Loading text
    loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    loadingText.text = @"Loading";
    loadingText.textColor = [UIColor greenColor];
    loadingText.backgroundColor = [UIColor blackColor];
    loadingText.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
   
    
    // Device Info
    deviceInfo = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    deviceInfo.text = [[device.model stringByAppendingString:@" > "] stringByAppendingString:device.name];
    deviceInfo.textColor = [UIColor greenColor];
    deviceInfo.backgroundColor = [UIColor blackColor];
    deviceInfo.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    
    // Connection Info
    connectionInfo = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    connectionInfo.text = [[@"Connection Type " stringByAppendingString:@" > "] stringByAppendingString:
                           ([UIDevice cellularConnected] ? @"Celluar" :
                           ([UIDevice wiFiConnected] ? @"WiFi":@"No connection"))
                           ];
    connectionInfo.textColor = [UIColor greenColor];
    connectionInfo.backgroundColor = [UIColor blackColor];
    connectionInfo.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    // Site Available
    siteAvailable = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    siteAvailable.text = [[@"Google connectivity " stringByAppendingString:@" > "] stringByAppendingString:
                           ([UIDevice hostAvailable:SITE] ? @"available" : @"not available")
                           ];
    siteAvailable.textColor = [UIColor greenColor];
    siteAvailable.backgroundColor = [UIColor blackColor];
    siteAvailable.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    // Location Info
    locationInfo = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    locationInfo.text = [NSString stringWithFormat:@"Found physical location.  %f %f", lastKnownLocation.coordinate.latitude, lastKnownLocation.coordinate.longitude];
    locationInfo.textColor = [UIColor greenColor];
    locationInfo.backgroundColor = [UIColor blackColor];
    locationInfo.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    
    // Location Info
    weatherFromInfo = [[UILabel alloc] initWithFrame:CGRectMake(0 , 400, 320, 20)];
    weatherFromInfo.text = [NSString stringWithFormat:@"Source > Weather Underground"];
    weatherFromInfo.textColor = [UIColor greenColor];
    weatherFromInfo.backgroundColor = [UIColor blackColor];
    weatherFromInfo.font = [UIFont fontWithName:@"Alterebro Pixel Font" size:20];
    
    
    
    // Add item(s) to content view
    [self.view addSubview:loadingText];
    
    // Add timer to handle loading... dots
    [NSTimer scheduledTimerWithTimeInterval: 0.1f target:self
                                   selector:@selector(handleTimer_025:) userInfo:nil repeats:YES];
    
    // Add timer to mock DOS lag
    [NSTimer scheduledTimerWithTimeInterval: 0.2f target:self
                                   selector:@selector(handleTimer_050:) userInfo:nil repeats:YES];
    
}

- (void)newPhysicalLocation:(CLLocation *)location {
    
     //NSLog(@"newPhysicalLocation %f", location.coordinate.latitude);
    
    // Store for later use
    lastKnownLocation = location;
    
    locationInfo.text = [NSString stringWithFormat:@"Device latitude longitude >  %f %f", lastKnownLocation.coordinate.latitude, lastKnownLocation.coordinate.longitude];
    
}

- (void) handleTimer_025: (NSTimer *) timer
{

    // Add a dot
    loadingText.text = [loadingText.text stringByAppendingString:@"."];
    
    // Reset if get to four dots
    loadingText.text = [loadingText.text stringByReplacingOccurrencesOfString:@"...." withString:@""];
    
    
}

- (void) handleTimer_050: (NSTimer *) timer
{
    
    // DOS lag effect
    displayCount++;
    
    // Switch to handle DOS effect
    switch (displayCount) {
        case 1:
            loadingText.frame =
                CGRectMake(loadingText.frame.origin.x,
                           loadingText.frame.origin.y - dosHeight,
                           loadingText.frame.size.width,
                           loadingText.frame.size.height);
            [self.view addSubview:deviceInfo];
            break;
        case 2:
            loadingText.frame =
            CGRectMake(loadingText.frame.origin.x,
                       loadingText.frame.origin.y - dosHeight,
                       loadingText.frame.size.width,
                       loadingText.frame.size.height);
            deviceInfo.frame =
            CGRectMake(deviceInfo.frame.origin.x,
                       deviceInfo.frame.origin.y - dosHeight,
                       deviceInfo.frame.size.width,
                       deviceInfo.frame.size.height);
            [self.view addSubview:connectionInfo];
            break;
            
        case 3:
            loadingText.frame =
            CGRectMake(loadingText.frame.origin.x,
                       loadingText.frame.origin.y - dosHeight,
                       loadingText.frame.size.width,
                       loadingText.frame.size.height);
            deviceInfo.frame =
            CGRectMake(deviceInfo.frame.origin.x,
                       deviceInfo.frame.origin.y - dosHeight,
                       deviceInfo.frame.size.width,
                       deviceInfo.frame.size.height);
            connectionInfo.frame =
            CGRectMake(connectionInfo.frame.origin.x,
                       connectionInfo.frame.origin.y - dosHeight,
                       connectionInfo.frame.size.width,
                       connectionInfo.frame.size.height);
            [self.view addSubview:siteAvailable];
            break;
        case 4:
            loadingText.frame =
            CGRectMake(loadingText.frame.origin.x,
                       loadingText.frame.origin.y - dosHeight,
                       loadingText.frame.size.width,
                       loadingText.frame.size.height);
            deviceInfo.frame =
            CGRectMake(deviceInfo.frame.origin.x,
                       deviceInfo.frame.origin.y - dosHeight,
                       deviceInfo.frame.size.width,
                       deviceInfo.frame.size.height);
            connectionInfo.frame =
            CGRectMake(connectionInfo.frame.origin.x,
                       connectionInfo.frame.origin.y - dosHeight,
                       connectionInfo.frame.size.width,
                       connectionInfo.frame.size.height);
            siteAvailable.frame =
            CGRectMake(siteAvailable.frame.origin.x,
                       siteAvailable.frame.origin.y - dosHeight,
                       siteAvailable.frame.size.width,
                       siteAvailable.frame.size.height);
            [self.view addSubview:locationInfo];
            break;
        case 5:
            loadingText.frame =
            CGRectMake(loadingText.frame.origin.x,
                       loadingText.frame.origin.y - dosHeight,
                       loadingText.frame.size.width,
                       loadingText.frame.size.height);
            deviceInfo.frame =
            CGRectMake(deviceInfo.frame.origin.x,
                       deviceInfo.frame.origin.y - dosHeight,
                       deviceInfo.frame.size.width,
                       deviceInfo.frame.size.height);
            connectionInfo.frame =
            CGRectMake(connectionInfo.frame.origin.x,
                       connectionInfo.frame.origin.y - dosHeight,
                       connectionInfo.frame.size.width,
                       connectionInfo.frame.size.height);
            siteAvailable.frame =
            CGRectMake(siteAvailable.frame.origin.x,
                       siteAvailable.frame.origin.y - dosHeight,
                       siteAvailable.frame.size.width,
                       siteAvailable.frame.size.height);
            locationInfo.frame =
            CGRectMake(locationInfo.frame.origin.x,
                       locationInfo.frame.origin.y - dosHeight,
                       locationInfo.frame.size.width,
                       locationInfo.frame.size.height);
            [self.view addSubview:weatherFromInfo];
            break;
        case 6:
            loadingText.frame =
            CGRectMake(loadingText.frame.origin.x,
                       loadingText.frame.origin.y - dosHeight,
                       loadingText.frame.size.width,
                       loadingText.frame.size.height);
            deviceInfo.frame =
            CGRectMake(deviceInfo.frame.origin.x,
                       deviceInfo.frame.origin.y - dosHeight,
                       deviceInfo.frame.size.width,
                       deviceInfo.frame.size.height);
            connectionInfo.frame =
            CGRectMake(connectionInfo.frame.origin.x,
                       connectionInfo.frame.origin.y - dosHeight,
                       connectionInfo.frame.size.width,
                       connectionInfo.frame.size.height);
            siteAvailable.frame =
            CGRectMake(siteAvailable.frame.origin.x,
                       siteAvailable.frame.origin.y - dosHeight,
                       siteAvailable.frame.size.width,
                       siteAvailable.frame.size.height);
            locationInfo.frame =
            CGRectMake(locationInfo.frame.origin.x,
                       locationInfo.frame.origin.y - dosHeight,
                       locationInfo.frame.size.width,
                       locationInfo.frame.size.height);
            weatherFromInfo.frame =
            CGRectMake(weatherFromInfo.frame.origin.x,
                       weatherFromInfo.frame.origin.y - dosHeight,
                       weatherFromInfo.frame.size.width,
                       weatherFromInfo.frame.size.height);
            break;
            
        default:
            break;
    }
    
    if(displayCount == 8)
    {
        // Load next view
        [self loadNextView];
    
    }
    
    
}

- (void) loadNextView
{
    viewController1 = [[WeatherViewController alloc] initWithMessage:@"Current"
                                                           withColor:[UIColor colorWithRed:135.0/255 green:206.0/255 blue:250.0/255 alpha:1.0]];
	viewController1.title =  @"Current";
    
	viewController3 = [[WeatherViewController alloc] initWithMessage:@"Forecast"
                                                           withColor:[UIColor yellowColor]];
	viewController3.title =  @"Forecast";
	tabHome = [[UITabBarController alloc] init];
	tabHome.viewControllers = [NSArray arrayWithObjects:
										viewController1,
										viewController3,
										nil];
	[window addSubview:tabHome.view];	
	[window makeKeyAndVisible];

    
}



@end
