//
//  ARTopicVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARTopicVC.h"
#import "ARTopicVC.h"
#import "ARTopicM.h"
#import "ARTopicCell.h"
#import "ARCommentVC.h"
#import "ARNewVC.h"
#import "ARCarouselImageView.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <SDImageCache.h>
#import <MJRefresh.h>
#import "ARNetworkTools.h"

static NSString * const ARTopicCellID = @"ARTopicCellID";

@interface ARTopicVC ()

@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray<ARTopicM *> *topics;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation ARTopicVC
{
    CGFloat _contentOffsetY;//上次的offset
    CGFloat _contentOffsetSpeed;//与上次的滚差，用于判断速度
}

- (NSMutableArray<ARTopicM *> *)topics{
    if(!_topics){
        _topics = [NSMutableArray array];
    }
    return _topics;
}

-(BOOL) showAD{
    return NO;
}

-(ARTopicType) type{
    //    return ARTopicTypeVoice;
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ARGrayColor(206);//ARRandomColor;
    //全屏cell活动时，头顶需要有内边距，从而可以看到头尾部分，不然没有边距填充，默认开始内容会在导航栏后面和tabbar后面
    //    self.tableView.contentInset = UIEdgeInsetsMake( NavMaxY + TitleVH, 0, TabBarH, 0);
    //    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.rowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARTopicCell class]) bundle:nil] forCellReuseIdentifier:ARTopicCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:TabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:TitleButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustTableViewContentInsetWithHidden) name:NavigationBarHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustTableViewContentInsetWithShow) name:NavigationBarShowNotification object:nil];
    
    [self setupRefresh];
}

-(void)adjustTableViewContentInsetWithHidden{
    if (self.view.superview.tag != 9999){
        self.tableView.contentInset = UIEdgeInsetsMake( NavMaxY , 0, TabBarH, 0);
    }
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

-(void) adjustTableViewContentInsetWithShow{
    if (self.view.superview.tag != 9999){
        self.tableView.contentInset = UIEdgeInsetsMake( NavMaxY + TitleVH, 0, TabBarH, 0);
    }
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];//一起移除
    //[self.manager invalidateSessionCancelingTasks:YES];
    //[[ARNetworkTools sharedTools] invalidateSessionCancelingTasks:YES];
}

- (void)tabBarButtonDidRepeatClick{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex
        //&& self.tabBarController.selectedViewController == self.navigationController
        && self.view.isShowingOnKeyWindow) {
        ARFunc
        [self.tableView.mj_header beginRefreshing];
    }
    // 记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (void)titleButtonDidRepeatClick{
    [self tabBarButtonDidRepeatClick];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return arc4random_uniform(20);
    /*
     self.footer.hidden = (self.topics.count == 0);
     */
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     static NSString *ID = @"cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
     cell.backgroundColor = [UIColor clearColor];
     }
     cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
     */
    ARTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ARTopicCellID forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    ARTopicM * topic = self.topics[indexPath.row];
    //    return topic.cellHeight;
    
    //    return [self.topics[indexPath.row] cellHeight];//没有泛型用 get语法
    return self.topics[indexPath.row].cellHeight;//@property (nonatomic, strong) NSMutableArray<ARTopicM *> *topics;用泛型才可以用点语法
}

- (void)setupRefresh{
   
    if ([self showAD]){
        NSArray *imageArray = @[@"http://img.spriteapp.cn/spritead/20170612/194445627195.jpg",
                                @"http://img.spriteapp.cn/spritead/20170612/194558124643.jpg",
                                @"http://pgdt.gtimg.cn/gdt/0/DAALCBEAUAALQABgBZG91dAJ9Xbcmb.jpg/0?ck=b6702b77e6a8e7034439a460c24e8a1d",
                                @"http://wimg.spriteapp.cn//ugc/2017/06/11/20170611150020704685.jpg"];
        
        NSMutableArray *describeArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < imageArray.count; i++) {
            NSString *tempDesc = [NSString stringWithFormat:@"Image Description %zd", i];
            [describeArray addObject:tempDesc];
        }
        ARCarouselImageView *carouselIV = [ARCarouselImageView tg_carouselImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imageArrary:imageArray describeArray:nil placeholderImage:[UIImage imageNamed:@"adph2.jpg"] block:^(NSInteger index) {
            ARLog(@"index: %zd", index)
        }];
        
        carouselIV.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        carouselIV.currentPageIndicatorTintColor = [UIColor redColor];
        
        self.tableView.tableHeaderView = carouselIV;
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    //类似下拉刷新效果
    //self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    //类似静默加载效果
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    //self.tableView.mj_footer.hidden = YES;
}

- (NSString *)a{
    return [self.parentViewController isKindOfClass:[ARNewVC class]] ? @"newlist" : @"list";
}

- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.params = parameters;
    
    ARNetworkTools *tools = [ARNetworkTools sharedTools];
    //[tools.tasks makeObjectsPerformSelector:@selector(cancel)];
    [tools request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            if (self.params != parameters) return ;
            if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
                [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            }
            [self.tableView.mj_header endRefreshing];
            return;
        }
        if (self.params != parameters) return ;
        //AFNWriteToPlist(new_topics)
        _maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [ARTopicM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        self.page = 0;
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}

- (void)loadMoreTopics{
    [self.tableView.mj_header endRefreshing];
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    self.page++;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"page"] = @(self.page);
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = _maxtime;
    self.params = parameters;
    
    ARNetworkTools *tools = [ARNetworkTools sharedTools];
    //[tools.tasks makeObjectsPerformSelector:@selector(cancel)];
    [tools request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            if (self.params != parameters) return ;
            if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
                [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            }
            [self.tableView.mj_footer endRefreshing];
            self.page--;
            return;
        }
        if (self.params != parameters) return ;
        _maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [ARTopicM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{//只会触发下拉刷新
    /*
     if (self.tableView.contentOffset.y <= - (self.tableView.contentInset.top + _header.height)) { // header已经完全出现
     [self headerBeginRefreshing];
     }
     */
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//只会触发上拉加载更多
    /*
     [self dealHeader];
     [self dealFooter];
     */
    if (scrollView.contentOffset.y > _contentOffsetY){//上滚
        //ARLog(@"up %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > 0){
            //隐藏，放入nav
            //通知形式
            //ARLog(@"我要隐藏了～～～～～～～～～～～～ %f",scrollView.contentOffset.y);
            if((scrollView.contentOffset.y - _contentOffsetY) > _contentOffsetSpeed && _contentOffsetSpeed>20){//速度超过20隐藏
                //ARLog(@"~~~~~~~~~~~~~~~~~~~~~%f %f",scrollView.contentOffset.y - _contentOffsetY,_contentOffsetSpeed);//滚速递减则不再发通知
                [[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarHiddenNotification object:nil userInfo:nil];
            }
            _contentOffsetSpeed = scrollView.contentOffset.y - _contentOffsetY;
        }
    }else{
        //显示，回归原位
        //通知形式
        //ARLog(@"dwon %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > 0){
            //ARLog(@"我要显示了^^^^^^^^^^^^^^^^^^^^ %f",scrollView.contentOffset.y);
            if (_contentOffsetY - scrollView.contentOffset.y > _contentOffsetSpeed && _contentOffsetSpeed>20){//速度超过20显示
                //ARLog(@"^^^^^^^^^^^^^^^^^^^^^^^%f %f",_contentOffsetY - scrollView.contentOffset.y,_contentOffsetSpeed);
                [[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarShowNotification object:nil userInfo:nil];
            }
            _contentOffsetSpeed = _contentOffsetY - scrollView.contentOffset.y;
        }else if (fabs(scrollView.contentOffset.y) > NavMaxY && fabs(scrollView.contentOffset.y) < NavMaxY+TitleVH){
            //ARLog(@"我要显示了^^^^^^^^^^^^^^^^^^^^ %f",scrollView.contentOffset.y);
            [[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarShowNotification object:nil userInfo:nil];
        }
    }
    _contentOffsetY = scrollView.contentOffset.y;
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [[SDImageCache sharedImageCache] clearMemory];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ARCommentVC *commentVc = [[ARCommentVC alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}
@end
