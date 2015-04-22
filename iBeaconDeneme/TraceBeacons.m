//
//  TraceBeacons.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 05/09/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import "TraceBeacons.h"
#import "Beacon.h"

@implementation TraceBeacons

@synthesize visitedBeacons;

+ (TraceBeacons *) sharedInstance
{
    static TraceBeacons *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TraceBeacons alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        visitedBeacons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) getVisitedBeacons
{
    return visitedBeacons;
}

- (void) addBeacon:(Beacon *) beacon
{
    if(beacon)
    {
        [visitedBeacons addObject:beacon];
    }
    
}

- (void) removeBeacon:(Beacon *) beacon
{
    if(beacon)
    {
        [visitedBeacons removeObject:beacon];
    }
}


@end