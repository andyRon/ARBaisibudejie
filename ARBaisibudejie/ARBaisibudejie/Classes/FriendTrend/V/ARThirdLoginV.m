//
//  ARThirdLoginV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARThirdLoginV.h"

@implementation ARThirdLoginV

+ (instancetype)fastLoginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
