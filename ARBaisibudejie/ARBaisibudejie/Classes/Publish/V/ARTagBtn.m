//
//  ARTagBtn.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARTagBtn.h"

@implementation ARTagBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = TagBgColor;
        [self setTitleColor:TagTitleColor forState:UIControlStateNormal];
        self.titleLabel.font = TagFont;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3  * TagMargin;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = TagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + TagMargin;
}

@end
