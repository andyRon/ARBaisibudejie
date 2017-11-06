//
//  ARSquareCell.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARSquareCell.h"
#import "ARSquareM.h"
#import <UIImageView+WebCache.h>

@interface ARSquareCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *nameV;

@end

@implementation ARSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(ARSquareM *)item {
    _item = item;
    [_iconV sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameV.text = item.name;
}

@end
