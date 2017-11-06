//
//  ARPlaceholderTextV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/5.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARPlaceholderTextV.h"

@interface ARPlaceholderTextV()

@property (weak , nonatomic)UILabel *placeholderLbl;

@end

@implementation ARPlaceholderTextV

- (UILabel *)placeholderLbl{
    if(!_placeholderLbl) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLbl = placeholderLabel;
        _placeholderLbl.x = 4;
        _placeholderLbl.y = 7;
    }
    return _placeholderLbl;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderLbl.font = self.font;
        self.placeholderColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange{
    self.placeholderLbl.hidden = self.hasText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLbl.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLbl.text = placeholder;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLbl.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLbl.width = self.width - 2 * self.placeholderLbl.x;
    [self.placeholderLbl sizeToFit];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
