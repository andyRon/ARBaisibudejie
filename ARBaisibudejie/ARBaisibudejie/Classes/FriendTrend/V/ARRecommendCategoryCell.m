//
//  ARRecommendCategoryCell.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARRecommendCategoryCell.h"
#import "ARRecommendCategoryM.h"

@interface ARRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation ARRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ARGrayColor(244);
    self.selectedIndicator.backgroundColor = ARColor(219, 21, 26);
    self.textLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setCategory:(ARRecommendCategoryM *)category{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : ARGrayColor(78);
}

@end
