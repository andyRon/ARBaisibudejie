//
//  CarouselImageManager.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARCarouselImageManager : NSObject

@property (nonatomic, assign) NSUInteger repeatCountWhenDownloadFailed;
@property (nonatomic, copy) void(^downloadImageSuccess)(UIImage *image, NSInteger imageIndex);
@property (nonatomic, copy) void(^downloadImageFailure)(NSError *error, NSString *imageURLString);
- (void)downloadImageURLString:(NSString *)imageURLString imageIndex:(NSInteger)imageIndex;
+ (void)clearCachedImages;

@end
