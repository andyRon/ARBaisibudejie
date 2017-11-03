//
//  ARConst.m
//  ARBaisibudejie
//
//  Created by andyron on 2017/11/3.
//  Copyright © 2017年 andyron. All rights reserved.
//  Author: AndyRon <rongming.2008@163.com>
//      blog: http://andyron.com
//      jianshu: http://www.jianshu.com/u/efce1a2a95ab
//      github: https://github.com/andyRon
//

#import "ARConst.h"
#import <Foundation/Foundation.h>

CGFloat const TextHeightConstraint = 120;
CGFloat const Margin = 10;
CGFloat const TabBarH = 49;
CGFloat const NavMaxY = 64;
CGFloat const TitleVH = 35;
NSUInteger GIFCacheCountLimit = 30;

CGFloat const TagMargin = 5;
CGFloat const TagH = 25;

NSString  * const CommonURL = @"http://api.budejie.com/api/api_open.php";

//重复点击用于刷新
NSString  * const TabBarButtonDidRepeatClickNotification = @"TabBarButtonDidRepeatClickNotification";

NSString  * const TitleButtonDidRepeatClickNotification = @"TitleButtonDidRepeatClickNotification";

NSString  * const NavigationBarHiddenNotification = @"NavigationBarHiddenNotification";
NSString  * const NavigationBarShowNotification = @"NavigationBarShowNotification";
NSString  * const BackEssenceNotification = @"BackEssenceNotification";
NSString  * const AcrossEssenceNotification = @"AcrossEssenceNotification";

NSString  * const Boy = @"m";
NSString  * const Girl = @"f";
