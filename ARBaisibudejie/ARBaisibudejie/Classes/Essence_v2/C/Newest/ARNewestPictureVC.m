//
//  ARNewestPictureVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNewestPictureVC.h"

@interface ARNewestPictureVC ()

@end

@implementation ARNewestPictureVC

-(NSString *) requesturl :(NSString *) nextpage{
    return [NSString stringWithFormat:@"http://s.budejie.com/topic/list/zuixin/10/bs0315-iphone-4.5.6/%@-20.json",nextpage];
}

@end
