//
//  UIScrollView+ARRefreshOC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "UIScrollView+ARRefreshOC.h"
#import <objc/runtime.h>

@implementation UIScrollView (ARRefreshOC)

static const char ARRefreshOCHeaderKey = '\0';

- (void)setTg_header:(ARRefreshOC *)tg_header{
    if (tg_header != self.tg_header) {
        [self.tg_header removeFromSuperview];
        [self insertSubview:tg_header atIndex:0];
        [self willChangeValueForKey:@"tg_header"];
        objc_setAssociatedObject(self, &ARRefreshOCHeaderKey,tg_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"tg_header"];
    }
}

- (ARRefreshOC *)tg_header{
    return objc_getAssociatedObject(self, &ARRefreshOCHeaderKey);
}

@end
