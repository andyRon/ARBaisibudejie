//
//  UIBarButtonItem+item.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithColor:(UIColor *)color highColor:(UIColor *)highColor target:(id)target action:(SEL)action title:(NSString *)title;

@end
