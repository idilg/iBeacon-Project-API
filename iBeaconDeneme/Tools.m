//
//  Tools.m
//  PolyLingua
//
//  Created by Ozan Uysal on 1/24/12.
//  Copyright (c) 2012 uysalmo@gmail.com. All rights reserved.
//

#import "Tools.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation Tools

+ (NSString*) sha256:(NSString *)key andData: (NSString *) data  {
    
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [Tools base64forData:hash];
}

+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {  value |= (0xFF & input[j]);  }  }  NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (BOOL) isIPhone5 {
    if ([[UIScreen mainScreen] bounds].size.height > 480 && [[UIScreen mainScreen] bounds].size.width == 320) {
        return YES;
    } else {
        return NO;
    }
}

+ (id) retrieveUserDefaults:(NSString *) userKey{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:userKey] != nil)
        return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:userKey]];
    else
        return nil;
}

+ (void) saveUserDefaults:(NSString *)key andValue:(id)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:key];
    [defaults synchronize];
}

+ (void) removeUserDefaults:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (NSString *) getInfoString : (NSString *) key{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:key];
}

+ (NSString *) urlFriendly:(NSString *) unfriendlyString{
    return [unfriendlyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSDate *) dateConverter: (NSString *) dateString {
    long timeZone = [[NSTimeZone localTimeZone] secondsFromGMT]; // server time is GMT +0
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [[dateFormatter dateFromString:dateString] dateByAddingTimeInterval:timeZone];
    if(!date) {
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        date = [[dateFormatter dateFromString:dateString] dateByAddingTimeInterval:timeZone];
    }
    return date;
}

+ (NSString *) dateFormatter: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) getParams:(NSDictionary *) dictionary {
    NSMutableArray *params = [NSMutableArray new];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([obj isKindOfClass:[NSString class]]) {
            [params addObject:[NSString stringWithFormat:@"%@=%@",key,[obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]]];
        } else {
            [params addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
    }];
    return [params componentsJoinedByString:@"&"];
}


+ (void) listAllFonts {
    // List all fonts on device
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        LogDebug(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            LogDebug(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
            
        }
    }
}

@end