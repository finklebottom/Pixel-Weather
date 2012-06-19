//
//  Loading.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-17.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "LoadingController.h"

@implementation LoadingController

- (void) loadView
{
    // Create the view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] ];
    self.view.backgroundColor = [UIColor blackColor];
    
    // Initialize variables
    displayCount = 0;
    dosHeight = 20;
    
    UIDevice *device = [UIDevice currentDevice];
    
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
    
    
    // Add item(s) to content view
    [self.view addSubview:loadingText];
    
    // Add timer to handle loading... dots
    [NSTimer scheduledTimerWithTimeInterval: 0.25f target:self
                                   selector:@selector(handleTimer_025:) userInfo:nil repeats:YES];
    
    // Add timer to mock DOS lag
    [NSTimer scheduledTimerWithTimeInterval: 0.50f target:self
                                   selector:@selector(handleTimer_050:) userInfo:nil repeats:YES];
    
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
            break;
            
        default:
            break;
    }
    
    
    
    
}

@end
