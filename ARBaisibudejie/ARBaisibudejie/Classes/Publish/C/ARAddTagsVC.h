//
//  ARAddTagsVCViewController.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARAddTagsVC : UIViewController

@property (nonatomic, copy) void(^tagsBlock)(NSArray *tags);
@property (nonatomic, copy) NSArray *tags;

@end
