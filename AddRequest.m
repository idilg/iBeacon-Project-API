//
//  AddRequest.m
//  iBeaconProject
//
//  Created by İdil Gücüyener on 08/04/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import "AddRequest.h"
#import "BaseResponse.h"

@implementation AddRequest

- (NSString *) getPath {
    return @"/beacons/add";
}

- (NSString *) getMethod {
    return @"POST";
}

- (Class) getReponseClass {
    return [BaseResponse class];
}

@end
