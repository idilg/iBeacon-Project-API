//
//  AppDelegate.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property CLProximity lastProximity;



@end
