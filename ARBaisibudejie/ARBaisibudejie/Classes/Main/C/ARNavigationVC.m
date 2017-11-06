//
//  ARNavigationVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNavigationVC.h"

@interface ARNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation ARNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;
}

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [navBar setTitleTextAttributes:attrs];
    
    CGSize imageSize = CGSizeMake(320, 64);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [NavTinColor set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [navBar setBackgroundImage:pressedColorImg forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    itemDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisableDict = [NSMutableDictionary dictionary];
    itemDisableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisableDict forState:UIControlStateDisabled];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}
@end
