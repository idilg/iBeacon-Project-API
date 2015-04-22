//
//  ViewController.m
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import "ViewController.h"
#import "TraceBeacons.h"
#import "ConnectionManager.h"
#import "AddRequest.h"
#import "Logging.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize positionLabel;
@synthesize distanceLabel;
@synthesize receivedData;
@synthesize tableArray;
@synthesize tableView;
@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[NSTimer timerWithTimeInterval:1 target:self selector:@selector(compareBeacons) userInfo:nil repeats:YES];
    

    
    
   /* NSString *json = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://bilmiyordum.com/poi.json"]];
    NSError *e;
    if(json){
        NSArray *myArray = [NSJSONSerialization JSONObjectWithData:json options:nil error:&e];
        
        tableArray = [[NSArray alloc] initWithArray:myArray];
        
        [tableView reloadData];

    }else{
        NSLog(@"data yok");
    }*/

    
    [self performSelector:@selector(compareBeacons) withObject:nil afterDelay:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
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
    
    CLBeacon *beacon  = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];
    CLBeacon *beacon2 = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];

    
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
    
    [self calculateProximityWithBeacon1:beacon andBeacon2:beacon2];
    
    return cell;    
}

-(void) calculateProximityWithBeacon1:(CLBeacon *)beacon andBeacon2:(CLBeacon*) beacon2 {
    
    double beacon1Rssi = beacon.rssi * -1;
    double beacon2Rssi = beacon2.rssi * -1;
    NSString * position= @"";
    BOOL oneBeacon = NO;
    
    if(beacon1Rssi == 0 || beacon2Rssi == 0){
        oneBeacon = YES;
    }
    
    if(beacon.major != beacon2.major) {
        
        if((beacon1Rssi <= beacon2Rssi+2 && beacon1Rssi >= beacon2Rssi-2) ||
           (beacon2Rssi <= beacon1Rssi+2 && beacon2Rssi >= beacon1Rssi-2)){
            //NSLog(@"eşit uzaklıkta/ortada");
            position = [NSString stringWithFormat:@"eşit uzaklıkta/ortada"];
            [positionLabel setText:position];
            
        }else if ((beacon1Rssi >= -50 || beacon1Rssi<= -30) && (beacon2Rssi >= -90 || beacon2Rssi <= -51 )){
            
            if([beacon.major intValue] == 1 && [beacon2.major intValue] ==2){
                
                if(beacon1Rssi < beacon2Rssi){
                    //NSLog(@"dışarda, beacon1'e yakın, major id: %@", beacon.major);
                    NSLog(@"%f %f", beacon1Rssi, beacon2Rssi);
                    position = [NSString stringWithFormat:@"dışarda, beacon1'e yakın, major id: %@", beacon.major];
                    [positionLabel setText:position];
                    
                }else if(beacon1Rssi > beacon2Rssi){
                    //NSLog(@"dışarda, beacon2'e yakın, major id: %@", beacon2.major);
                    NSLog(@"%f %f", beacon1Rssi, beacon2Rssi);
                    position = [NSString stringWithFormat:@"dışarda, beacon2'e yakın, major id: %@", beacon2.major];
                    [positionLabel setText:position];
                }
                
            }else if ([beacon.major intValue] == 2 && [beacon2.major intValue] == 1){
                
                if(beacon1Rssi < beacon2Rssi){
                    //NSLog(@"dışarda, beacon1'e yakın, major id: %@", beacon.major);
                    NSLog(@"%f %f", beacon1Rssi, beacon2Rssi);
                    position = [NSString stringWithFormat:@"dışarda, beacon1'e yakın, major id: %@", beacon.major];
                    [positionLabel setText:position];
                    
                }else if(beacon1Rssi > beacon2Rssi){
                    //NSLog(@"dışarda, beacon2'e yakın, major id: %@", beacon2.major);
                    NSLog(@"%f %f", beacon1Rssi, beacon2Rssi);
                    position = [NSString stringWithFormat:@"dışarda, beacon2'e yakın, major id: %@", beacon2.major];
                    [positionLabel setText:position];
                }
            }
        }
    }else if (oneBeacon){
            position = [NSString stringWithFormat:@"tek beacon"];
            [positionLabel setText:position];
    }else if (beacon2Rssi  < 0 && beacon1Rssi == 0 && oneBeacon){
            position = [NSString stringWithFormat:@"tek beacon"];
            [positionLabel setText:position];
    }else if (beacon1Rssi == 0 && beacon2Rssi ==0){
            position = [NSString stringWithFormat:@"range dışında"];
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
        return pow(ratio,10);
    }
    else {
        double accuracy =  (0.89976) * pow(ratio,7.7095) + 0.111;
        return accuracy;
    }
    
}

- (CLBeacon *) findBeaconMajorID: (int)majorId {
    
    int numOfElements = [self.beacons count];
    
    for (int i =0; i < numOfElements ; i++){
        
        CLBeacon *beacon = [self.beacons objectAtIndex:i];
        if([beacon.major intValue] == majorId)
            return beacon;
    }

    return nil;
}

- (void) compareBeacons{
    
    CLBeacon* beacon1 = [self findBeaconMajorID:1];
    CLBeacon* beacon2 = [self findBeaconMajorID:2];
    
    [self calculateProximityWithBeacon1:beacon1 andBeacon2:beacon2];

    distanceLabel.text = [NSString stringWithFormat:@"distance: %f", [self calculateAccuracy:beacon1]];
    
    [self performSelector:@selector(compareBeacons) withObject:nil afterDelay:1];
    
}

@end
