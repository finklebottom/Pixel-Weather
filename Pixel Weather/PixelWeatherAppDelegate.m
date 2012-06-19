//
//  PixelWeatherAppDelegate.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-17.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "PixelWeatherAppDelegate.h"
#import "LoadingController.h"

@implementation PixelWeatherAppDelegate

- (void) applicationDidFinishLaunching:(UIApplication *)application
{

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoadingController alloc] init]];
    UIViewController *view = [[LoadingController alloc] init];
    window.rootViewController = view;
    [window makeKeyAndVisible];
    
}

//
-(void) applicationWillResignActive:(UIApplication *)application
{
    // Exit app when put in background
    exit(0);
}

@end
