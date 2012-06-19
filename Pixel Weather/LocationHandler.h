//
//  LocationHandler.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-18.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//


#import <uikit/UIKit.h>
#import <coreLocation/CoreLocation.h>

@protocol LocationGetterDelegate <NSObject>
@required
- (void) newPhysicalLocation:(CLLocation *)location;
@end

@interface LocationGetter : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id <LocationGetterDelegate> delegate;
}

- (void)startUpdates;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic , retain) id delegate;
@end