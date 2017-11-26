//
//  ARTextField.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARTextField.h"
#import "UITextField+placeholder.h"

@implementation ARTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    self.placeholderColor = [UIColor lightGrayColor];
}

- (void)textBegin{
    self.placeholderColor = [UIColor whiteColor];
}

- (void)textEnd{
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
