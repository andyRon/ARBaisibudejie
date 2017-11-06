//
//  ARAddToolBar.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARAddToolBar.h"


@interface ARAddToolBar()

@property (weak, nonatomic) IBOutlet UIView *topV;
@property (weak, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) NSMutableArray *tagLabls;

@end

@implementation ARAddToolBar

- (NSMutableArray *)tagLabls{
    if (!_tagLabls) {
        _tagLabls = [NSMutableArray array];
    }
    return _tagLabls;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = Margin;
    [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topV addSubview:addButton];
    _addBtn = addButton;
//    [self ]
}

- (void)addBtnClick{
    
}
@end
