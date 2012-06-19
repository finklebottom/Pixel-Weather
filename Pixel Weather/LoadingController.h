//
//  Loading.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-17.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkHandler.h"
#import "LocationHandler.h"



@interface LoadingController : UIViewController <LocationGetterDelegate>
{

    UILabel *loadingText;
    UILabel *deviceInfo;
    UILabel *connectionInfo;
    UILabel *siteAvailable;
    UILabel *locationInfo;
    
    
    int displayCount;
    int dosHeight;
    
    CLLocation *lastKnownLocation;
    LocationGetter *locationGetter;

}


@end
