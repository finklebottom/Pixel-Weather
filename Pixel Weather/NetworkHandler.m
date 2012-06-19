//
//  NetworkHandler.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-06-18.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "NetworkHandler.h"


#define EXTERNAL_HOST @"google.com"


@implementation UIDevice (DeviceConnectivity)

+(BOOL)cellularConnected{// EDGE or GPRS
    SCNetworkReachabilityFlags    flags = 0;
    SCNetworkReachabilityRef      netReachability = NULL;
    
    netReachability     = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [EXTERNAL_HOST UTF8String]);
    if(netReachability){
        SCNetworkReachabilityGetFlags(netReachability, &flags);
        CFRelease(netReachability);
    }
    if(flags & kSCNetworkReachabilityFlagsIsWWAN){
        return YES;
    }
    return NO;
}

+(BOOL)wiFiConnected{
    if([self cellularConnected]){
        return NO;
    }
    return [self networkConnected];
}

+(BOOL)networkConnected{
    SCNetworkReachabilityFlags     flags = 0;
    SCNetworkReachabilityRef       netReachability = NULL;
    BOOL                           retrievedFlags = NO;
    
    netReachability     = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [EXTERNAL_HOST UTF8String]);
    if(netReachability){
        retrievedFlags      = SCNetworkReachabilityGetFlags(netReachability, &flags);
        CFRelease(netReachability);
    }
    if (!retrievedFlags || !flags){
        return NO;
    }
    return YES;
}

+ (NSString *) getIPAddressForHost: (NSString *) theHost
{
	struct hostent *host = gethostbyname([theHost UTF8String]);
    if (!host) {herror("resolv"); return NULL; }
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
	return addressString;
}

+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
{
	if (!IPAddress || ![IPAddress length]) return NO;
	
	memset((char *) address, sizeof(struct sockaddr_in), 0);
	address->sin_family = AF_INET;
	address->sin_len = sizeof(struct sockaddr_in);
	
	int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
	if (conversionResult == 0) 
    {
		NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
		return NO;
	}
	
	return YES;
}

+ (BOOL) hostAvailable: (NSString *) theHost
{
	
    NSString *addressString = [self getIPAddressForHost:theHost];
    if (!addressString)
    {
        NSLog(@"Error recovering IP address from host name\n");
        return NO;
    }
	
    struct sockaddr_in address;
    BOOL gotAddress = [UIDevice addressFromString:addressString address:&address];
	
    if (!gotAddress)
    {
		NSLog(@"Error recovering sockaddr address from %@", addressString);
        return NO;
    }
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
    SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    return isReachable ? YES : NO;;
}


@end

