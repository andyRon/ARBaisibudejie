//
//  ARCommentHeaderFooterV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARCommentHeaderFooterV.h"

@implementation ARCommentHeaderFooterV

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = [ARGrayColor(244) colorWithAlphaComponent:0.6];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.x = Margin;
}

@end
