//
//  ARSegmentMoreBtn.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARSegmentMoreBtn.h"

@interface ARSegmentMoreBtn()

@property (nonatomic, assign) CGFloat radio;

@end

@implementation ARSegmentMoreBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;//UIViewContentModeScaleAspectFill
    }
    return self;
}

-(CGFloat)radio {
    return 0.86;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 1, contentRect.size.width * self.radio, contentRect.size.height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(contentRect.size.width * self.radio * self.radio, 4, contentRect.size.width * ( 1 - self.radio), contentRect.size.height -4);
}

@end
