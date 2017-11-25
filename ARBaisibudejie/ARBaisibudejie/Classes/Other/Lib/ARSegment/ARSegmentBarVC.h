//
//  ARSementBarVC.h
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentBar.h"

@interface ARSegmentBarVC : UIViewController

@property (nonatomic, weak) ARSegmentBar *segmentBar;//供外界修改其父view
@property (nonatomic,assign) NSInteger defaultSelectedIndex;
- (void)setupWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;

@end
