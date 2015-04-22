//
//  LocationManager.h
//  iBeaconDeneme
//
//  Created by İdil Gücüyener on 29/12/14.
//  Copyright (c) 2014 İdil Gücüyener. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@protocol LocationModelDelegate <NSObject>

- (void) modelUpdated;

@end

@interface LocationsManager : NSObject

@property (nonatomic, weak) id<LocationModelDelegate> delegate;

- (void) persist:(Location*)location;
- (id)init;

@end
