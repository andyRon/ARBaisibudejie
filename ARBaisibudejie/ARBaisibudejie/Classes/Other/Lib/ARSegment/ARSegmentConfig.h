//
//  ARSegmentConfig.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARSegmentConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *segmentBarBGColor;//标题栏 的背景色
@property (nonatomic, assign) CGFloat segmentBarH;//标题栏的高度
@property (nonatomic, assign) BOOL isShowMore;//是否显示更多
@property (nonatomic, assign) BOOL isCircleScroll;//是否支持循环滚动，即已经在第0个了，再向前滚动的话，那么滚到最后一个，如果在最后一个，再向后滚动，那么滚动到第0个
@property (nonatomic, assign) CGFloat circleScrollOffset;//循环滚动Offset,只有达到这个值，才进入循环滚动,默认50
@property (nonatomic, strong) UIColor *indicatorColor;//指示器颜色
@property (nonatomic, assign) CGFloat indicatorH;//指示器高度
@property (nonatomic, assign) CGFloat indicatorExtraW;//指示器左右扩展的宽度
@property (nonatomic, strong) UIColor *segNormalColor;//每个标签的正常颜色
@property (nonatomic, strong) UIColor *segSelectedColor;//每个标签选中的颜色
@property (nonatomic, strong) UIFont *segNormalFont;//每个标签的正常字体
@property (nonatomic, strong) UIFont *segSelectedFont;//每个标签的选中时的字体
@property (nonatomic, assign) CGFloat limitMargin;//标签间最小间距

@property (nonatomic, strong) UIColor *coverViewColor;//遮照颜色
@property (nonatomic, strong) UIColor *showMoreBGColor;//显示更多面板的背景色
@property (nonatomic, strong) UIColor *showMoreCellBGColor;//显示更多面板的每个单元格的背景色
@property (nonatomic, assign) NSInteger showMoreVCRowCount;//显示更多面板的每行个数
@property (nonatomic, assign) CGFloat showMoreCellMinH;//显示更多面板的每个单元格的最小高度
@property (nonatomic, strong) UIColor *showMoreCellTextColor;//显示更多面板的每个单元格的文本颜色
@property (nonatomic, strong) UIFont *showMoreCellFont;//显示更多面板的每个单元格的字体大小

@property (nonatomic, strong) UIColor *showMoreBtnBorderColor;//显示更多按钮的 边框颜色
@property (nonatomic, assign) CGFloat showMoreBtnborderW;//显示更多按钮的 边框宽度
@property (nonatomic, strong) UIColor *showMoreBtnTitleColor;//显示更多按钮的 标题颜色
@property (nonatomic, strong) UIColor *showMoreBtnBGColor;//显示更多按钮的 背景颜色
@property (nonatomic, strong) UIFont *showMoreBtnTitleFont;//显示更多按钮的 标题字体大小
@property (nonatomic, assign) BOOL isShowMoreBtnlineView;//是否显示更多按钮的 分割线
@property (nonatomic, assign) CGFloat showMoreBtnlineViewH;//显示更多按钮的 分割线的高度
@property (nonatomic, strong) UIColor *showMoreBtnlineViewColor;//显示更多按钮的 分割线的颜色

- (ARSegmentConfig *(^)(UIColor *color))barBGColor;
- (ARSegmentConfig *(^)(BOOL isShow))showMore;
- (ARSegmentConfig *(^)(BOOL isCircle))circleScroll;
- (ARSegmentConfig *(^)(UIColor *color))indicateColor;
- (ARSegmentConfig *(^)(CGFloat height))indicateH;
- (ARSegmentConfig *(^)(CGFloat width)) indicateExtraW;
- (ARSegmentConfig *(^)(UIColor *color))normalColor;
- (ARSegmentConfig *(^)(UIColor *color))selectedColor;
- (ARSegmentConfig *(^)(UIFont *font))normalFont;
- (ARSegmentConfig *(^)(UIFont *font))selectedFont;
- (ARSegmentConfig *(^)(CGFloat margin))margin;
- (ARSegmentConfig *(^)(CGFloat offset))circleOffset;
- (ARSegmentConfig *(^)(CGFloat height))barH;
- (ARSegmentConfig *(^)(UIColor *color))moreBGColor;
- (ARSegmentConfig *(^)(UIColor *color))moreCellBGColor;
- (ARSegmentConfig *(^)(CGFloat count))moreVCRowCount;
- (ARSegmentConfig *(^)(CGFloat height))moreCellMinH;
- (ARSegmentConfig *(^)(UIColor *color))moreBtnBorderColor;
- (ARSegmentConfig *(^)(CGFloat width)) moreBtnborderW;
- (ARSegmentConfig *(^)(UIColor *color))moreBtnTitleColor;
- (ARSegmentConfig *(^)(UIColor *color))moreBtnBGColor;
- (ARSegmentConfig *(^)(UIFont *font))moreBtnTitleFont;
- (ARSegmentConfig *(^)(BOOL isShow))showMoreBtnlineView;
- (ARSegmentConfig *(^)(CGFloat height))moreBtnlineViewH;
- (ARSegmentConfig *(^)(UIColor *color))moreBtnlineViewColor;
- (ARSegmentConfig *(^)(UIColor *color))coverColor;
- (ARSegmentConfig *(^)(UIColor *color))moreCellTextColor;
- (ARSegmentConfig *(^)(UIFont *font))moreCellFont;

@end
