//
//  AddRequest.h
//  iBeaconProject
//
//  Created by İdil Gücüyener on 08/04/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import "BaseRequest.h"

@interface AddRequest : BaseRequest

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *deviceId;
@property(nonatomic, strong) NSString *majorid;
@property(nonatomic, strong) NSString *minorid;
@property(nonatomic, strong) NSString *timestamp;
@property(nonatomic, strong) NSString *rssi;




@end
