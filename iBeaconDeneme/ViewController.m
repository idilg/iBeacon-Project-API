//
//  ViewController.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize positionLabel;
@synthesize distanceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return self.beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CLBeacon *beacon = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];
    CLBeacon *beacon2 = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];
    
    [self calculateProximityWithBeacon1:beacon andBeacon2:beacon2];
    [self calculateAccuracy:beacon];
    
    NSString *proximityLabel = @"";
    
    switch (beacon.proximity) {
        case CLProximityFar:
            proximityLabel = @"Far";
            break;
        case CLProximityNear:
            proximityLabel = @"Near";
            break;
        case CLProximityImmediate:
            proximityLabel = @"Immediate";
            break;
        case CLProximityUnknown:
            proximityLabel = @"Unknown";
            break;
    }
    
    cell.textLabel.text = proximityLabel;
    
    NSString *detailLabel = [NSString stringWithFormat:
                             @"Major: %d, Minor: %d, RSSI: %d, UUID: %@",
                             beacon.major.intValue,
                             beacon.minor.intValue,
                             (int)beacon.rssi,
                             beacon.proximityUUID.UUIDString];
    
    cell.detailTextLabel.text = detailLabel;
    return cell;    
}

-(void) calculateProximityWithBeacon1:(CLBeacon *)beacon andBeacon2:(CLBeacon*) beacon2 {
    
    //int majorv, minorv;
    double beacon1Rssi = beacon.rssi;
    double beacon2Rssi = beacon.rssi;
    NSString * position= @"";
    
    if(beacon.major != beacon2.major) {
        
        if(beacon1Rssi >= 20 && beacon1Rssi<= 60 && beacon2Rssi >= 20 && beacon2Rssi <= 60){
            
            NSLog(@"ortada");
            position = [NSString stringWithFormat:@"ortada"];
            [positionLabel setText:position];
        }else if ((beacon1Rssi >= 0 || beacon1Rssi<= 20) && (beacon2Rssi >= 20 || beacon2Rssi <= 60)){
            
            NSLog(@"solda");
            NSLog(@"%f %f", beacon1Rssi, beacon2Rssi);
            position = [NSString stringWithFormat:@"solda"];
            [positionLabel setText:position];
        }else if ((beacon1Rssi >= 20 || beacon1Rssi<= 60) && (beacon2Rssi >= 0 || beacon2Rssi <= 20)){
            
            NSLog(@"sağda");
            position = [NSString stringWithFormat:@"sağda"];
            [positionLabel setText:position];
        }else if ((beacon1Rssi >= 0 || beacon1Rssi<= 20) && (beacon2Rssi >= 0 || beacon2Rssi <= 20)){
            
            NSLog(@"range dışında");
            position = [NSString stringWithFormat:@"range dışında"];
            [positionLabel setText:position];
        }
    }else {
        
        position = [NSString stringWithFormat:@"tek beacon"];
        [positionLabel setText:position];
    }
    
}

- (double) calculateAccuracy: (CLBeacon*) beacon {
    
    if (beacon.rssi == 0) {
        return -1.0; // if we cannot determine accuracy, return -1.
    }
    
    double txPower = -70;
    double ratio = beacon.rssi*1.0/txPower;
    if (ratio < 1.0) {
        NSLog(@"ratiolara geldik");
        return pow(ratio,10);
    }
    else {
        double accuracy =  (0.89976) * pow(ratio,7.7095) + 0.111;
        NSLog(@"accuracylere geldik");
        NSString *num = [NSString stringWithFormat:@"%.20lf", accuracy];
        distanceLabel.text = [NSString stringWithFormat:@"distance: %@", num];
        return accuracy;
    }
    
}

@end
