//
//  ARNewestTotalVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNewestTotalVC.h"

@interface ARNewestTotalVC ()

@end

@implementation ARNewestTotalVC

-(NSString *) requesturl :(NSString *) nextpage{
    //http://s.budejie.com/topic/list/zuixin/1/bs0315-iphone-4.5.6/0-20.json
    return [NSString stringWithFormat:@"http://s.budejie.com/topic/list/zuixin/1/bs0315-iphone-4.5.6/%@-20.json",nextpage];
}

-(BOOL) showAD{
    return YES;
}

@end
