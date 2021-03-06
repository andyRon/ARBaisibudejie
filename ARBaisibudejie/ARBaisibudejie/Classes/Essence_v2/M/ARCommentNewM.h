//
//  ARCommentNewM.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARUserNewM;

@interface ARCommentNewM : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *data_id;
@property (strong , nonatomic)ARUserNewM *u;
@property (strong , nonatomic)ARUserNewM *user;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger hate_count;
@property (nonatomic, assign) NSInteger floor;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, assign) NSInteger video_width;
@property (nonatomic, assign) NSInteger video_height;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, copy) NSString *videouri;
@property (nonatomic, assign) BOOL avmixed;
@property (nonatomic, copy) NSString *video_thumbnail;

@property (nonatomic, copy) NSString *cmt_type;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger precid;
@property (nonatomic, assign) NSInteger preuid;
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger image_width;
@property (nonatomic, assign) NSInteger image_height;

@property (nonatomic, assign,readonly) CGFloat cellHeight;
@property (nonatomic, assign,readonly) CGRect middleFrame;

@property (strong , nonatomic) ARCommentNewM * precmt;
@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;
@property (nonatomic, assign,getter=is_videoPlaying) BOOL videoPlaying;

@property (nonatomic, assign,readonly) CGFloat topCommentCellHeight;
@property (nonatomic, assign,readonly) CGFloat topCommentWidth;
@property (nonatomic, copy,readonly) NSMutableAttributedString * attrStrM;

@property (nonatomic, assign, getter=isUpSelected) BOOL upSelected;
@property (nonatomic, assign, getter=isDownSelected) BOOL downSelected;

@end
