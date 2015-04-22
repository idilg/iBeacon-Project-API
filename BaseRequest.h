//
//  BaseRequest.h
//  iBeaconProject
//
//  Created by İdil Gücüyener on 08/04/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface BaseRequest : JSONModel

- (NSString *) getPath;
- (NSString *) getMethod;
- (Class) getReponseClass;

@end
