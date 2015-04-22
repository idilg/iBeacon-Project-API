//
//  ConnectionManager.m
//  iBeaconProject
//
//  Created by İdil Gücüyener on 08/04/15.
//  Copyright (c) 2015 İdil Gücüyener. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"
#import "Tools.h"

#define BASE_URL @"http://172.17.194.195:3000"
#define CONNECTION_TIMEOUT 20

@interface ConnectionManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *httpManager;

@end

@implementation ConnectionManager

@synthesize httpManager;

+ (id)sharedManager {
    static ConnectionManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
    });
    return sharedMyManager;
}

- (id) init {
    if (self = [super init]) {
        httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [httpManager.requestSerializer setValue:[NSString stringWithFormat:@"Beacon iOS %@",[Tools getInfoString:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"User-Agent"];
    }
    return self;
}

- (void) request : (BaseRequest *) request
          success:(void (^)(id response)) success
          failure:(void (^)(NSError *error)) failure {
    
    
    id successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LogDebug(@"responseObject : %@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            id remoteResponse = [[[request getReponseClass] alloc] initWithDictionary:responseObject error:nil];
            success(remoteResponse);
            
        } else if([responseObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (id item in responseObject) {
                id remoteItem = [[[request getReponseClass] alloc] initWithDictionary:item error:nil];
                [tempArray addObject:remoteItem];
            }
            success([tempArray copy]);
        } else {
            failure([NSError errorWithDomain:@"ConnectionManager" code:101 userInfo:[NSDictionary dictionaryWithObject:@"Unexpected response from server" forKey:NSLocalizedDescriptionKey]]);
        }
        
        
    };
    
    id failBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        LogDebug(@"Request failure to %@ Error : %@ Body : %@ Server response : %@",operation.request.URL,error,[NSString stringWithUTF8String:[operation.request.HTTPBody bytes]],operation.responseString);
        
        failure(error);
        
    };
    
    AFHTTPRequestOperation *operation = nil;
    if([request.getMethod isEqualToString:@"POST"]) {
        operation = [httpManager POST:request.getPath parameters:request.toDictionary success:successBlock failure:failBlock];
    } else if([request.getMethod isEqualToString:@"GET"]) {
        operation = [httpManager GET:request.getPath parameters:request.toDictionary success:successBlock failure:failBlock];
    } else if([request.getMethod isEqualToString:@"PUT"]) {
        operation = [httpManager PUT:request.getPath parameters:request.toDictionary success:successBlock failure:failBlock];
    }
    
    //[operation start];
}

@end

