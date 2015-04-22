//
//  Tools.h
//  PolyLingua
//
//  Created by Ozan Uysal on 1/24/12.
//  Copyright (c) 2012 uysalmo@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logging.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

@interface Tools : NSObject{
    
}

+ (void) saveUserDefaults:(NSString *)key andValue:(id)value;
+ (void) removeUserDefaults:(NSString *)key;
+ (id) retrieveUserDefaults:(NSString *) userKey;

+ (NSString *) getInfoString : (NSString *) key;

+ (NSString *) urlFriendly:(NSString *)unfriendlyString;

+ (BOOL) isIPhone5;

+ (void) listAllFonts;

+ (NSString*) sha256:(NSString *)key andData: (NSString *)data;
+ (NSString*)base64forData:(NSData*)theData;

+ (NSDate *) dateConverter: (NSString *) dateString;
+ (NSString *) dateFormatter: (NSDate *) date ;
+ (NSString *) getParams:(NSDictionary *) dictionary;

@end

