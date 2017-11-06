//
//  ARPushGuideV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/4.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARPushGuideV.h"

@implementation ARPushGuideV

+ (void)show{
    NSString *key = @"";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *sandoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandoxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        ARPushGuideV *guideView = [ARPushGuideV viewFromXIB];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
