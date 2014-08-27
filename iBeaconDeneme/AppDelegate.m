//
//  AppDelegate.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

        // Override point for customization after application launch.
    
    // UUID for first 2 beacons
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:@"824C42CF-ECFF-4045-A632-014FF08DF948"];
    //NSString *beaconIdentifier = @"myBeacon";
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:beaconUUID
                                                                      identifier:@"myBeaconIdentifier"];
    
    //UUID for third beacon
    NSUUID *beacon2UUID = [[NSUUID alloc] initWithUUIDString:@"70EE9563-EC34-489F-897C-79A3D0D41481"];
    //NSString *beacon2Identifier = @"myBeacon2";
    CLBeaconRegion *beacon2Region = [[CLBeaconRegion alloc] initWithProximityUUID:beacon2UUID
                                                                       identifier:@"myBeaconIdentifier2"];

    
        self.locationManager = [[CLLocationManager alloc] init];
        // New iOS 8 request for Always Authorization, required for iBeacons to work!
        /*if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }*/
        self.locationManager.delegate = self;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
    
        [self.locationManager startMonitoringForRegion:beaconRegion]; // first 2 beacon
        [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    
        [self.locationManager startMonitoringForRegion:beacon2Region]; //third beacon
        [self.locationManager startRangingBeaconsInRegion:beacon2Region];
    
        [self.locationManager startUpdatingLocation];
        
        return YES;
}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:

    (NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
        ViewController *viewController = (ViewController*)self.window.rootViewController;
        viewController.beacons = beacons;
        [viewController.tableView reloadData];
    
        NSString *message = @"";
    
        if(beacons.count > 0) {
            CLBeacon *nearestBeacon = beacons.firstObject;
            
            if(nearestBeacon.proximity == self.lastProximity ||
               nearestBeacon.proximity == CLProximityUnknown) {
                return;
            }
            self.lastProximity = nearestBeacon.proximity;
            
            switch(nearestBeacon.proximity) {
                case CLProximityFar:
                    message = @"You are far away from the beacon";
                    break;
                case CLProximityNear:
                    message = @"You are near the beacon";
                    break;
                case CLProximityImmediate:
                    message = @"You are in the immediate proximity of the beacon";
                    break;
                case CLProximityUnknown:
                    return;
        }
            
        } else {
            message = @"No beacons are nearby";
        }
    
        NSLog(@"%@", message);
        [self sendLocalNotificationWithMessage:message];
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
        [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
        [self.locationManager startUpdatingLocation];
    
        NSLog(@"You entered the region.");
        [self sendLocalNotificationWithMessage:@"You entered the region."];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
        [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
        [self.locationManager stopUpdatingLocation];
    
        NSLog(@"You exited the region.");
        [self sendLocalNotificationWithMessage:@"You exited the region."];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
