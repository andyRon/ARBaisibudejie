//
//  AREssenceVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "AREssenceVC.h"
#import "ARTitleBtn.h"
#import "ARVoiceVC.h"
#import "ARAllVC.h"
#import "ARVideoVC.h"
#import "ARPicVC.h"
#import "ARWordVC.h"

@interface AREssenceVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollV;
@property (nonatomic, strong) UIView *titlesV;
@property (nonatomic, weak) UIView *titleUnderline;
@property (nonatomic, weak) ARTitleBtn *previousClickedTitleBtn;

@end

@implementation AREssenceVC

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildVcs];
    [self setupNavBar];
    [self setupScrollView];
    [self.view addSubview:self.titlesV];
    [self addChildVcViewIntoScrollView:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNav) name:NavigationBarHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNav) name:NavigationBarShowNotification object:nil];


}
- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon-1" highImageName:@"nav_item_game_click_icon-1" target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"RandomAcross" highImageName:@"RandomAcrossClick" target:self action:@selector(back)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)hideNav {
    if (self.titlesV.superview != self.view) return;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.titlesV.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = self.titlesV;
    ARFunc
}

- (void)showNav {
    if (self.titlesV.superview == self.view) return;
    [self setupNavBar];
    self.titlesV.backgroundColor = NavTinColor;
    self.titlesV.frame = CGRectMake(0, NavMaxY, self.view.width, TitleVH);
    [self.view addSubview:self.titlesV];
    ARFunc
}

- (void)setupAllChildVcs{
    [self addChildViewController:[[ARAllVC alloc] init]];
    [self addChildViewController:[[ARVideoVC alloc] init]];
    [self addChildViewController:[[ARVoiceVC alloc] init]];
    [self addChildViewController:[[ARPicVC alloc] init]];
    [self addChildViewController:[[ARWordVC alloc] init]];
}

- (void)setupScrollView {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    //MARK:6个scrollView，设置其中一个为YES才能滚动，多于一个则不会滚动
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    _scrollV = scrollView;
    
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
}

- (UIView *)titlesV {
    if (!_titlesV){
        UIView *titlesView = [[UIView alloc] init];
        titlesView.backgroundColor = NavTinColor;
        titlesView.frame = CGRectMake(0, NavMaxY, self.view.width, TitleVH);
        _titlesV = titlesView;
        [self setupTitleButtons];
        [self setupTitleUnderline];
    }
    return _titlesV;
}

- (void)setupTitleButtons {
    NSArray *titles = @[ @"全部", @"视频",@"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleBtnW = self.titlesV.width / count;
    CGFloat titleBtnH = self.titlesV.height;
    for (NSUInteger i = 0; i < count; i++) {
        ARTitleBtn *titleBtn = [[ARTitleBtn alloc] init];
        titleBtn.tag = i;
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesV addSubview:titleBtn];
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
}

- (void)setupTitleUnderline {
    ARTitleBtn *firstTitleBtn = self.titlesV.subviews.firstObject;
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.height = 2;
    titleUnderline.y = self.titlesV.height - titleUnderline.height - 1;
    titleUnderline.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    [self.titlesV addSubview:titleUnderline];
    _titleUnderline = titleUnderline;
    
    firstTitleBtn.selected = YES;
    self.previousClickedTitleBtn = firstTitleBtn;
    [firstTitleBtn.titleLabel sizeToFit];//因为处于viewdidload才需要
    self.titleUnderline.width = firstTitleBtn.titleLabel.width + Margin*2;
    self.titleUnderline.centerX = firstTitleBtn.centerX;
}

-(void) titleBtnClick:(ARTitleBtn *) titleBtn {
    if (self.previousClickedTitleBtn == titleBtn) {//重复点击用于刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:TitleButtonDidRepeatClickNotification object:nil];
    }
    [self dealTitleButtonClick:titleBtn];
}

- (void)dealTitleButtonClick:(ARTitleBtn *)titleBtn{
    self.previousClickedTitleBtn.selected = NO;
    titleBtn.selected = YES;
    self.previousClickedTitleBtn = titleBtn;
    
    NSUInteger index = titleBtn.tag;
    [UIView animateWithDuration:0.25 animations:^{
        self.titleUnderline.width = titleBtn.titleLabel.width + Margin * 2;
        self.titleUnderline.centerX = titleBtn.centerX;
        self.scrollV.contentOffset = CGPointMake(self.scrollV.width * index, self.scrollV.contentOffset.y);//MARK: 联动1
    } completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView:index];
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) continue;//因为view是懒加载，所以不能用view，而要用VC。如果view没有被创建则不处理
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        scrollView.scrollsToTop = (i == index);//MARK:6个scrollView，设置其中一个为YES才能滚动，多于一个则不会滚动（方式一，双击顶部状态栏，让显示在当前屏幕上的uiscrollview滚动到头部）
    }
}

- (void)addChildVcViewIntoScrollView:(NSUInteger)index {
    //...
}

// MARK: - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    ARTitleBtn *titleBtn = self.titlesV.subviews[index];
    [self dealTitleButtonClick:titleBtn];
}

- (void) dealloc{
    ARFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NavigationBarHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NavigationBarShowNotification object:nil];
}

@end
