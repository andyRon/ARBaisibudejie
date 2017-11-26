//
//  ARLookingAroundV.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARTopicNewM;

@interface ARLookingAroundV : UICollectionViewCell

@property (nonatomic, strong) ARTopicNewM *topic;
@property (nonatomic, copy) void (^commentBlock)(NSString * topicId);
@property (nonatomic, copy) void (^nextBlock)(NSString * topicId);
-(void) play;
-(void) replacePlayerItem:(ARTopicNewM *)topic;

@end
