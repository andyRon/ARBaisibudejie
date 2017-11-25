//
//  ARSegmentBar.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentConfig.h"

@class ARSegmentBar;

@protocol ARSegmentBarDelegate <NSObject>

- (void)segmentBar: (ARSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end

@interface ARSegmentBar : UIView

@property (nonatomic, weak) id<ARSegmentBarDelegate> delegate;//代理的定义 2
+ (instancetype)segmentBarWithFrame: (CGRect)frame config: (ARSegmentConfig *)config parentView: (UIView *)parentV;
- (void)updateViewWithConfig: (void(^)(ARSegmentConfig *config))configBlock;
@property (nonatomic, strong,readonly) ARSegmentConfig * segmentConfig;
@property (nonatomic, strong) NSArray<NSString *> *segmentModels;
@property (nonatomic, assign) NSInteger selectedIndex;//供外界赋值，反向修改头部选中的标签
@property (nonatomic,weak) UIView * parentV;//ARSementBarVC的view，可以通过类方法（20行）通过参数传入，若是通过对象方法创建，那么还需单独设置parentV，如果不设置，那么当bar在titleview时collectionview的cell不能响应点击

@end
