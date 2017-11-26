//
//  ARLayout.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARLayout;

@protocol ARLayoutDelegate <NSObject>

@required
- (CGFloat)layout:(ARLayout *)layout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInLayout:(ARLayout *)layout;
- (CGFloat)columnMarginInLayout:(ARLayout *)layout;
- (CGFloat)rowMarginInLayout:(ARLayout *)layout;
- (UIEdgeInsets)edgeInsetsInLayout:(ARLayout *)layout;

@end

@interface ARLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ARLayoutDelegate> delegate;

@end
