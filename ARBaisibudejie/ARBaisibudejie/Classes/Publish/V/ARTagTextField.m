//
//  ARTagTextField.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARTagTextField.h"
#import "UITextField+placeholder.h"

@implementation ARTagTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用换行或者逗号隔开！";
        self.placeholderColor = [UIColor lightGrayColor];
        [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = TagH;
    }
    return self;
}

- (void)deleteBackward{
    !_deleteBlock ? : _deleteBlock();
    [super deleteBackward];
}

@end
