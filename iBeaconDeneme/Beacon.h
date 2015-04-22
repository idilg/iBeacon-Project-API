//
//  Beacon.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 30/01/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Beacon : NSObject

@property (nonatomic) int majorId;
@property (nonatomic) int minorId;
@property (nonatomic) int rssi;
@property (nonatomic) NSDate *time;

- (Beacon*)  initWithCLBeacon:(CLBeacon*) beacon;

@end