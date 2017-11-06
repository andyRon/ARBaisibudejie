//
//  UIImageView+download.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (download)

- (void)tg_setOriginImage:(NSString *_Nullable)originImageURL thumbnailImage:(NSString *_Nullable)thumbnailImageURL placeholder:(UIImage *_Nullable)placeholder progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock _Nullable )completedBlock;
- (void)tg_setHeader:(NSString *_Nonnull)headerUrl;
- (void)tg_setHeader:(NSString *_Nonnull)headerUrl borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nullable)borderColor;

@end
