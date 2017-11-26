//
//  ARNewestVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARNewestVC.h"
#import "ARSegmentBarVC.h"
#import "ARTopicNewVC.h"
#import "ARNewestTotalVC.h"
#import "ARNewestVideoVC.h"
#import "ARNewestPictureVC.h"
#import "ARNewestJokesVC.h"
#import "ARNewestInteractVC.h"
#import "ARNewestAlbumVC.h"
#import "ARNewestRedNetVC.h"
#import "ARNewestVoteVC.h"
#import "ARNewestBeautyVC.h"
#import "ARNewestColdKnowledgeVC.h"
#import "ARNewestGameVC.h"
#import "ARNewestSoundsVC.h"

@interface ARNewestVC ()
@property (nonatomic, weak) ARSegmentBarVC *segmentBarVC;
@end

@implementation ARNewestVC

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//UIStatusBarStyleDefault;
}

- (ARSegmentBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        ARSegmentBarVC *vc = [[ARSegmentBarVC alloc] init];
        [self addChildViewController:vc];//成链
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    //设置segmentBarVC大小
    self.segmentBarVC.view.frame = self.view.bounds;
    //使用segmentBarVC
    [self.view addSubview:self.segmentBarVC.view];
    NSArray *items = @[@"全部", @"视频", @"图片", @"段子",@"互动区",@"相册",@"网红",@"投票",@"美女",@"冷知识",@"游戏",@"声音"];
    NSMutableArray* childVCs = [NSMutableArray array];
    [childVCs addObject:[[ARNewestTotalVC alloc] init]];
    [childVCs addObject:[[ARNewestVideoVC alloc] init]];
    [childVCs addObject:[[ARNewestPictureVC alloc] init]];
    [childVCs addObject:[[ARNewestJokesVC alloc] init]];
    [childVCs addObject:[[ARNewestInteractVC alloc] init]];
    [childVCs addObject:[[ARNewestAlbumVC alloc] init]];
    [childVCs addObject:[[ARNewestRedNetVC alloc] init]];
    [childVCs addObject:[[ARNewestVoteVC alloc] init]];
    [childVCs addObject:[[ARNewestBeautyVC alloc] init]];
    [childVCs addObject:[[ARNewestColdKnowledgeVC alloc] init]];
    [childVCs addObject:[[ARNewestGameVC alloc] init]];
    [childVCs addObject:[[ARNewestSoundsVC alloc] init]];
    
    [self.segmentBarVC setupWithItems:items childVCs:childVCs];
    
    [self.segmentBarVC.segmentBar updateViewWithConfig:^(ARSegmentConfig *config) {
        config.selectedColor([UIColor lightTextColor])
        .normalColor([UIColor lightTextColor])
        .selectedFont([UIFont systemFontOfSize:14])//选中字体大于其他正常标签的字体的情况下，根据情况稍微调大margin（默认8），以免选中的字体变大后挡住其他正常标签的内容
        .normalFont([UIFont systemFontOfSize:13])
        .indicateExtraW(8)
        .indicateH(2)
        .indicateColor([UIColor whiteColor])
        .showMore(YES)
        .moreCellBGColor([[UIColor grayColor] colorWithAlphaComponent:0.3])
        .moreBGColor([UIColor clearColor])
        .moreCellFont([UIFont systemFontOfSize:13])
        .moreCellTextColor(NavTinColor)
        .moreCellMinH(30)
        .showMoreBtnlineView(YES)
        .moreBtnlineViewColor([UIColor lightTextColor])
        .moreBtnTitleFont([UIFont systemFontOfSize:13])
        .moreBtnTitleColor([UIColor lightTextColor])
        .margin(18)
        .barBGColor(NavTinColor)
        ;
    }];
    
    [self setupNavBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNav) name:NavigationBarHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:NavigationBarShowNotification object:nil];
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"review_post_nav_icon" highImageName:@"review_post_nav_icon_click" target:self action:@selector(check)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_search_icon" highImageName:@"nav_search_icon_click" target:self action:@selector(search)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)check{
    ARFunc
}

- (void)search{
    ARFunc
}

-(void) hideNav{
    if (self.segmentBarVC.segmentBar.superview != self.segmentBarVC.view) return;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.segmentBarVC.segmentBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    ARFunc
}

-(void) showNav{
    if (self.segmentBarVC.segmentBar.superview == self.segmentBarVC.view) return;
    [self setupNavBar];
    self.segmentBarVC.segmentBar.backgroundColor = NavTinColor;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, NavMaxY, self.segmentBarVC.view.width, TitleVH);
    [self.segmentBarVC.view addSubview:self.segmentBarVC.segmentBar];
    ARFunc
}

- (void) dealloc{
    ARFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NavigationBarHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NavigationBarShowNotification object:nil];
}

@end
