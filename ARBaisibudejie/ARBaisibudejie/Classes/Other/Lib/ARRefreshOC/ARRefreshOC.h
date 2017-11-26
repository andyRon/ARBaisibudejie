//
//  ARRefreshOC.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ARRefreshKind) {
    RefreshKindQQ,
    RefreshKindNormal,
};

typedef NS_ENUM(NSInteger,ARRefreshAlignment) {
    ARRefreshAlignmentTop,
    ARRefreshAlignmentMidden,
    ARRefreshAlignmentBottom,
};

@interface ARRefreshOC : UIControl

/** 类型，默认为QQ弹簧 皮筋效果 */
@property(nonatomic,assign) ARRefreshKind kind;
/** 背景色（在有contentInset时为scrollview等背景色） */
@property(nonatomic,strong) UIColor * bgColor;
/** 主题色（刷新文字颜色、ActivityIndicator颜色、橡皮筯颜色） */
@property(nonatomic,strong) UIColor * tinColor;
/** 垂直对齐，默认顶部 */
@property(nonatomic,assign) ARRefreshAlignment verticalAlignment;
/** 刷新成功时的提示文字 */
@property(nonatomic,copy) NSString * refreshSuccessStr;
/** 准备刷新时的提示文字 */
@property(nonatomic,copy) NSString * refreshNormalStr;
/** 即将刷新时的提示文字 */
@property(nonatomic,copy) NSString * refreshPullingStr;
/** 正在刷新时的提示文字 */
@property(nonatomic,copy) NSString * refreshingStr;
/** 更新结果的回显文字 */
@property(nonatomic,copy) NSString * refreshResultStr;
/** 更新结果的回显背景色 */
@property(nonatomic,strong) UIColor * refreshResultBgColor;
/** 更新结果的回显文字颜色 */
@property(nonatomic,strong) UIColor * refreshResultTextColor;
/** 更新结果的回显高度 */
@property(nonatomic,assign) CGFloat refreshResultHeight;
/** 自动改变透明度，默认已做优化 */
@property(nonatomic,assign) BOOL automaticallyChangeAlpha;

-(ARRefreshOC * (^)(ARRefreshKind))tg_kind;
-(ARRefreshOC * (^)(UIColor *))tg_bgColor;
-(ARRefreshOC * (^)(UIColor *))tg_tinColor;
-(ARRefreshOC * (^)(ARRefreshAlignment))tg_verticalAlignment;
-(ARRefreshOC * (^)(NSString *))tg_refreshSuccessStr;
-(ARRefreshOC * (^)(NSString *))tg_refreshNormalStr;
-(ARRefreshOC * (^)(NSString *))tg_refreshPullingStr;
-(ARRefreshOC * (^)(NSString *))tg_refreshingStr;
-(ARRefreshOC * (^)(NSString *))tg_refreshResultStr;
-(ARRefreshOC * (^)(UIColor *))tg_refreshResultBgColor;
-(ARRefreshOC * (^)(UIColor *))tg_refreshResultTextColor;
-(ARRefreshOC * (^)(CGFloat))tg_refreshResultHeight;
-(ARRefreshOC * (^)(BOOL))tg_automaticallyChangeAlpha;

-(instancetype) initWithConfig:(void(^)(ARRefreshOC * refresh)) block;
+(instancetype) refreshWithTarget:(id)target action:(SEL)action config:(void(^)(ARRefreshOC * refresh)) block;

-(void)beginRefreshing;
-(void)endRefreshing;

@end
