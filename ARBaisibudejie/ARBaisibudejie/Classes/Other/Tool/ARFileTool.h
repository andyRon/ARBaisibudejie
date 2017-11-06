//
//  ARFileTool.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARFileTool : NSObject

+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
