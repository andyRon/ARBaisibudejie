//
//  ARNetworkTools.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNetworkTools.h"

@protocol HTTPProxy <NSObject>
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end


@interface ARNetworkTools ()<HTTPProxy>

@end

@implementation ARNetworkTools

+ (instancetype)sharedTools {
    static ARNetworkTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    });
    return tools;
}

- (void)netrequest:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished {
    [[ARNetworkTools sharedTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject,nil);
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ARLog(@"%@",error)
        finished(nil,error);
    };
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    [[self dataTaskWithHTTPMethod:methodName URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:nil success:successCallback failure:failureCallBack] resume];
}

- (void)request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished {
    [[ARNetworkTools sharedTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject,nil);
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ARLog(@"%@",error)
        finished(nil,error);
    };
    
    if (method == GET) {
        [self GET:urlString parameters:parameters progress:nil success:successCallback failure:failureCallBack];
    } else {
        [self POST:urlString parameters:parameters progress:nil success:successCallback failure:failureCallBack];
    }
}


@end
