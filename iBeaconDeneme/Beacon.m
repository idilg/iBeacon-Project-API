//
//  Beacon.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 30/01/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import "Beacon.h"

#define safeSet(d,k,v) if (v) d[k] = v;

@interface Beacon ()

@end

@implementation Beacon

- (Beacon*)  initWithCLBeacon:(CLBeacon*) beacon
{
    self.majorId = beacon.major.intValue;
    self.minorId = beacon.minor.intValue;
    self.rssi = beacon.rssi;
    self.time = [[NSDate alloc] init];
    
    return self;
}


@end
