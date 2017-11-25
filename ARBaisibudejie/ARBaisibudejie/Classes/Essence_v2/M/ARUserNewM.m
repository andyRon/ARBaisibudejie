//
//  ARUserNewM.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARUserNewM.h"

@implementation ARUserNewM

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"header" : @"header[0]",
             };
}

@end
