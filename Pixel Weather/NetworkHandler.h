//
//  NetworkHandler.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-18.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <sys/socket.h>
#include <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <unistd.h>
#import <dlfcn.h>
#import <notify.h>


@interface UIDevice (DeviceConnectivity)

+(BOOL)cellularConnected; 
+(BOOL)wiFiConnected;
+(BOOL)networkConnected;

+ (BOOL) hostAvailable: (NSString *) theHost;
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;
+ (NSString *) getIPAddressForHost: (NSString *) theHost;

@end
