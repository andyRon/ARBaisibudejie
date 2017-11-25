//
//  ARMoreCell.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARMoreCell.h"

@implementation ARMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.backgroundColor = selected ? self.segmentConfig.segSelectedColor: self.segmentConfig.showMoreCellBGColor ;
}

-(void)setSegmentConfig:(ARSegmentConfig *)segmentConfig{
    _segmentConfig = segmentConfig;
    self.menuLabel.textColor = self.segmentConfig.showMoreCellTextColor;
    self.menuLabel.font = self.segmentConfig.showMoreCellFont;
}

@end
