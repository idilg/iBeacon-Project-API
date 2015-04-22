//
//  ViewController.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//  ♥♥♥♥ Cem Sina Çetin ♥♥♥♥

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView * tableView;
@property (strong) NSArray *beacons;
@property double beaconRssi;
@property IBOutlet UILabel *positionLabel;
@property IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) NSArray *tableArray;
@property (strong, nonatomic) NSData *receivedData;
@property IBOutlet UILabel *label;

-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;


@end
