//
//  ARNetworkTools.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum : NSUInteger {
    GET,
    POST,
} HTTPMethod;

@interface ARNetworkTools : AFHTTPSessionManager

+ (instancetype) sharedTools;
- (void) request:(HTTPMethod)method urlString:(NSString *)urlString  parameters:(id)parameters finished:(void(^)(id ,NSError *))finished;
- (void)netrequest:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished;

@end
