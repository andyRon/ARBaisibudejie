//
//  NSDate+calendar.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (calendar)

- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end
