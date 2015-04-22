//
//  TraceBeacons.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 05/09/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TraceBeacons : NSObject{
    
    NSMutableArray *visitedBeacons;
}

@property (nonatomic, retain) NSArray *visitedBeacons;

+(TraceBeacons *) sharedInstance;
- (id) init;
- (void) addBeacon:(id) beacon;
- (void) removeBeacon:(id) beacon;
- (NSArray *) getVisitedBeacons;

@end
