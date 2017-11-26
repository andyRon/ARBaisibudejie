//
//  ARTopicNewCell.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARTopicNewM;

typedef void (^ReloadRowsAtIndexPathBlock)();

@interface ARTopicNewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *spreadV;

@property (nonatomic, strong) ARTopicNewM *topic;
@property (nonatomic, copy) ReloadRowsAtIndexPathBlock block;
@property (nonatomic, copy) void (^upBlock)(NSString * topicId);
@property (nonatomic, copy) void (^downBlock)(NSString * topicId);
@property (nonatomic, copy) void (^repostBlock)(NSString * topicId);
@property (nonatomic, copy) void (^commentBlock)(NSString * topicId);

@end
