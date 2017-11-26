//
//  ARNewestAlbumVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNewestAlbumVC.h"

@interface ARNewestAlbumVC ()

@end

@implementation ARNewestAlbumVC


-(NSString *) requesturl :(NSString *) nextpage{
    return [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/50471/new/bs0315-iphone-4.5.6/%@-20.json",nextpage];
}

@end
