//
//  ARTopicM.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARCommentM;

typedef NS_ENUM(NSUInteger, ARTopicType) {
    ARTopicTypeAll = 1,
    ARTopicTypePicture = 10,
    ARTopicTypeWord = 29,
    ARTopicTypeVoice = 31,
    ARTopicTypeVideo = 41
};

@interface ARTopicM : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;//u name
@property (nonatomic, copy) NSString *profile_image;//u header[0]
@property (nonatomic, copy) NSString *text;//text
@property (nonatomic, copy) NSString *passtime;//passtime
@property (nonatomic, assign) NSInteger ding;//up
@property (nonatomic, assign) NSInteger cai;//down
@property (nonatomic, assign) NSInteger repost;//forward
@property (nonatomic, assign) NSInteger comment;//comment

@property (nonatomic, assign) NSInteger type;//type

@property (nonatomic, assign) NSInteger width;//image width
@property (nonatomic, assign) NSInteger height;//image height
//@property (nonatomic, strong) NSArray<ARCommentM*> *top_cmt;//top_comments
@property (nonatomic, strong) ARCommentM *top_cmt;

@property (nonatomic, copy) NSString *image0;//小图 image small[]
@property (nonatomic, copy) NSString *image2;//中图 image medium[]
@property (nonatomic, copy) NSString *image1;//大图 image big[0]

@property (nonatomic, copy) NSString *videouri;
@property (nonatomic, copy) NSString *voiceuri;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, assign,readonly) CGFloat cellHeight;
@property (nonatomic, assign,readonly) CGRect middleFrame;

@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
@property (nonatomic, assign) CGFloat picProgress;

@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;
@property (nonatomic, assign,getter=is_videoPlaying) BOOL videoPlaying;

//@property (strong , nonatomic) ARCommentM *top_cmt;

@property (nonatomic, assign,readonly) CGFloat commentVH;
@property (nonatomic, assign,readonly) CGFloat commentBtnX;

@end
