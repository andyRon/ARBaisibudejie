//
//  AREssenceNewVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "AREssenceNewVC.h"
#import "ARSegmentBarVC.h"
#import "ARTopicNewVC.h"
#import "ARRecommendedVC.h"
#import "ARVideoPlayVC.h"
#import "ARPictureVC.h"
#import "ARJokesVC.h"
#import "ARRankingVC.h"
#import "ARInteractVC.h"
#import "ARRedNetVC.h"
#import "ARSocietyVC.h"
#import "ARVoteVC.h"
#import "ARBeautyVC.h"
#import "ARColdKnowledgeVC.h"
#import "ARGameVC.h"
#import "ARLookingAroundVC.h"

@interface AREssenceNewVC ()

@property (nonatomic, weak) ARSegmentBarVC *segmentBarVC;

@end

@implementation AREssenceNewVC

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
    NSArray *items = @[@"推荐",@"随听", @"视频", @"图片", @"段子",@"排行",@"互动区",@"网红",@"社会",@"投票",@"美女",@"冷知识",@"游戏"];
    NSMutableArray* childVCs = [NSMutableArray array];
    [childVCs addObject:[[ARRecommendedVC alloc] init]];
    [childVCs addObject:[[ARLookingAroundVC alloc] init]];
    [childVCs addObject:[[ARVideoPlayVC alloc] init]];
    [childVCs addObject:[[ARPictureVC alloc] init]];
    [childVCs addObject:[[ARJokesVC alloc] init]];
    [childVCs addObject:[[ARRankingVC alloc] init]];
    [childVCs addObject:[[ARInteractVC alloc] init]];
    [childVCs addObject:[[ARRedNetVC alloc] init]];
    [childVCs addObject:[[ARSocietyVC alloc] init]];
    [childVCs addObject:[[ARVoteVC alloc] init]];
    [childVCs addObject:[[ARBeautyVC alloc] init]];
    [childVCs addObject:[[ARColdKnowledgeVC alloc] init]];
    [childVCs addObject:[[ARGameVC alloc] init]];
    
    [self.segmentBarVC setupWithItems:items childVCs:childVCs];
    
    [self.segmentBarVC.segmentBar updateViewWithConfig:^(ARSegmentConfig *config) {
        config.selectedColor([UIColor lightTextColor])
        .normalColor([UIColor lightTextColor])
        .selectedFont([UIFont systemFontOfSize:14])//选中字体大于其他正常标签的字体的情况下，根据情况稍微调大margin（默认8），以免选中的字体变大后挡住其他正常标签的内容
        .normalFont([UIFont systemFontOfSize:13])
        .indicateExtraW(8)
        .indicateH(2)
        .indicateColor([UIColor whiteColor])
        .showMore(NO)//是否显示更多面板
        .circleScroll(YES)//是否循环滚动，第0个再向前，那么到最后一个;最后一个向后，那么到第0个
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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon-1" highImageName:@"nav_item_game_click_icon-1" target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"RandomAcross" highImageName:@"RandomAcrossClick" target:self action:@selector(randomAcross)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)test{
    ARFunc
}

-(void)randomAcross{
    ARFunc
    [[NSNotificationCenter defaultCenter] postNotificationName:AcrossEssenceNotification object:nil userInfo:nil];
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
