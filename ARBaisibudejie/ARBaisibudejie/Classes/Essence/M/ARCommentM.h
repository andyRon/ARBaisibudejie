//
//  ARCommentM.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARUserM;
@interface ARCommentM : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) ARUserM *user;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *voiceuri;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, assign, getter=is_voicePlaying) BOOL voicePlaying;


@end
