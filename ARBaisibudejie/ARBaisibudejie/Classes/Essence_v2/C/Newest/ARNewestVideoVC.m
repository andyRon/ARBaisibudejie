//
//  ARNewestVideoVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNewestVideoVC.h"

@interface ARNewestVideoVC ()

@end

@implementation ARNewestVideoVC

-(NSString *) requesturl :(NSString *) nextpage{
    //http://s.budejie.com/topic/list/zuixin/41/bs0315-iphone-4.5.6/0-20.json
    return [NSString stringWithFormat:@"http://s.budejie.com/topic/list/zuixin/41/bs0315-iphone-4.5.6/%@-20.json",nextpage];
}

@end
