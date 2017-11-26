//
//  ARRankingVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARRankingVC.h"

@interface ARRankingVC ()

@end

@implementation ARRankingVC

-(NSString *) requesturl :(NSString *) nextpage{
    return [NSString stringWithFormat:@"http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.6/%@-20.json",nextpage];
}

@end
