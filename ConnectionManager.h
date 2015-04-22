//
//  ConnectionManager.h
//  iBeaconProject
//
//  Created by İdil Gücüyener on 08/04/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface ConnectionManager : NSObject

+ (id) sharedManager;

- (void) request : (BaseRequest *) request
          success:(void (^)(id response)) success
          failure:(void (^)(NSError *error)) failure;

@end