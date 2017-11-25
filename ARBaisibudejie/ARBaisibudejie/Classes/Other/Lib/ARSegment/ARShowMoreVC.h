//
//  ARShowMoreVC.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentConfig.h"

@interface ARShowMoreVC : UICollectionViewController

@property (nonatomic, strong) NSArray <NSString *>* items;
- (instancetype)initWithConfig : (ARSegmentConfig *)segmentConfig;

@end
