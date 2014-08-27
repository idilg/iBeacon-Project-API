//
//  ViewController.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 19/08/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView * tableView;
@property (strong) NSArray *beacons;
@property double beaconRssi;
@property IBOutlet UILabel *positionLabel;
@property IBOutlet UILabel *distanceLabel;




@end
