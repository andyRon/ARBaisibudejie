//
//  ARMainVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/4.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARMainVC.h"
#import "ARTabBar.h"
#import "ARNavigationVC.h"
#import "AREssenceVC.h"
#import "AREssenceNewVC.h"
#import "ARNewestVC.h"
#import "ARFriendTrendVC.h"
#import "ARMeVC.h"
#import "ARNewVC.h"
#import "ARPublishVC.h"


@interface ARMainVC ()

@end

@implementation ARMainVC

+ (void)load {
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:self.class];
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    attrsSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateNormal];
    
    NSMutableDictionary *attrsNormal = [NSMutableDictionary dictionary];
    attrsNormal[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attrsNormal forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildVC];
    [self setupAllTitleButton];
    [self setupTabBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:BackEssenceNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(across) name:AcrossEssenceNotification object:nil];
}

- (void)setupTabBar {
    ARTabBar *tabbar = [[ARTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
}

- (void)back {
    
}

- (void)across {
    
}

- (void)setupAllChildVC {
    ARNavigationVC *essenceVc = [[ARNavigationVC alloc] initWithRootViewController:[[AREssenceNewVC alloc] init]];
    ARNavigationVC *newVc = [[ARNavigationVC alloc] initWithRootViewController:[[ARNewestVC alloc] init]];
    ARNavigationVC *ftVc = [[ARNavigationVC alloc] initWithRootViewController:[[ARFriendTrendVC alloc] init]];
    ARNavigationVC *meVc = [[ARNavigationVC alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:NSStringFromClass([ARMeVC class]) bundle:nil] instantiateInitialViewController]];

    self.viewControllers = @[essenceVc,newVc,ftVc,meVc];
}

- (void)setupAllTitleButton{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    //    ARPublishVC *publishVc = self.childViewControllers[2];
    //    publishVc.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
    //    publishVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    //    publishVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}

- (void) dealloc{
    ARFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BackEssenceNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AcrossEssenceNotification object:nil];
}

@end
