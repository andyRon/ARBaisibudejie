//
//  ARMoreLayout.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath , CGFloat width);

@interface ARMoreLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger cols;
@property (nonatomic, assign) CGFloat minCellH;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
- (void)computeIndexCellHeightWithWidthBlock:(HeightBlock)block;

@end
