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

@synthesize visitedBeacons;

+ (TraceBeacons *) sharedInstance{
    
    static TraceBeacons *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TraceBeacons alloc] init];
    });
    return _sharedInstance;
}

- (NSArray *) getVisitedBeacons{
    
    return visitedBeacons;
}

- (void) addBeacon:(id) beacon{
    
    if(visitedBeacons.count == 0){
        [visitedBeacons addObject:beacon];
        
    }else if(![visitedBeacons containsObject:beacon]){
        [visitedBeacons addObject:beacon];

    }else
        return;
}

@end