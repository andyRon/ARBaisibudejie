//
//  ARRecommendCategoryM.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARRecommendCategoryM : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;

@end
