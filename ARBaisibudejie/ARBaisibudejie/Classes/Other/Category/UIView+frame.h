//
//  UIView+frame.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/4.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property CGFloat width;
@property CGFloat height;
@property CGFloat x;
@property CGFloat y;
@property CGFloat centerX;
@property CGFloat centerY;
@property CGSize size;
@property CGFloat left;
@property CGFloat right;
@property CGFloat top;
@property CGFloat bottom;
+ (instancetype)viewFromXIB;
- (BOOL)isShowingOnKeyWindow;

@end
