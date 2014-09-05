//
//  TraceBeacons.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 05/09/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import "TraceBeacons.h"
#import "AppDelegate.h"

@implementation TraceBeacons


//selam dünyanın en saçma metodu slm
- (void) locationManager: (CLLocationManager *)manager traceBeacons: (CLBeacon *)beacon inRegion: (CLRegion *)region{
    
    BOOL inRegion = YES;
    
    if(inRegion){
        [((AppDelegate*) [[UIApplication sharedApplication] delegate]) locationManager:manager didEnterRegion:region];
    }
    
}

@end
