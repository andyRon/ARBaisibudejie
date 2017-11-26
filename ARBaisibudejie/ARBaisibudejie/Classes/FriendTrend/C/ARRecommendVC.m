//
//  ARRecommendVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARRecommendVC.h"
#import "ARNetworkTools.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "ARRecommendCategoryCell.h"
#import "ARRecommendUserCell.h"
#import "ARRecommendCategoryM.h"
#import "ARRecommendUserM.h"

@interface ARRecommendVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableV;
@property (weak, nonatomic) IBOutlet UITableView *userTableV;
@property (nonatomic, strong) NSMutableDictionary *params;
//@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static NSString * const ARCategoryId = @"category";
static NSString * const ARUserId = @"user";

@implementation ARRecommendVC

//- (AFHTTPSessionManager *)manager{
//    if (!_manager) {
//        _manager = [AFHTTPSessionManager manager];
//    }
//    return _manager;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    [self setupTableView];
    [self setupRefresh];
    [self loadCategories];
}

- (void)loadCategories{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    ARNetworkTools *tools = [ARNetworkTools sharedTools];
    [tools request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
            return;
        }
        [SVProgressHUD dismiss];
        self.categories = [ARRecommendCategoryM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableV reloadData];
        [self.categoryTableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableV.mj_header beginRefreshing];
    }];
    
    //    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    //        [SVProgressHUD dismiss];
    //        self.categories = [ARRecommendCategoryM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    //        [self.categoryTableV reloadData];
    //        [self.categoryTableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    //        [self.userTableV.mj_header beginRefreshing];
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    //    }];
}

- (void)setupTableView{
    [self.categoryTableV registerNib:[UINib nibWithNibName:NSStringFromClass([ARRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:ARCategoryId];
    [self.userTableV registerNib:[UINib nibWithNibName:NSStringFromClass([ARRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:ARUserId];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableV.contentInset = self.categoryTableV.contentInset;
    self.userTableV.rowHeight = 70;
}

- (void)setupRefresh{
    self.userTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableV.mj_header.automaticallyChangeAlpha = YES;
    self.userTableV.mj_footer.hidden = YES;
}

- (void)loadNewUsers{
    [self.userTableV.mj_footer endRefreshing];
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    ARRecommendCategoryM *rc = self.categories[self.categoryTableV.indexPathForSelectedRow.row];
    rc.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    ARNetworkTools *tools = [ARNetworkTools sharedTools];
    //[tools.tasks makeObjectsPerformSelector:@selector(cancel)];
    [tools request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            if (self.params != params) return;
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            [self.userTableV.mj_header endRefreshing];
            return;
        }
        NSArray *users = [ARRecommendUserM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:users];
        rc.total = [responseObject[@"total"] integerValue];
        if (self.params != params) return;
        [self.userTableV reloadData];
        [self.userTableV.mj_header endRefreshing];
        [self checkFooterState];
    }];
    
    //    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    //        NSArray *users = [ARRecommendUserM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    //        [rc.users removeAllObjects];
    //        [rc.users addObjectsFromArray:users];
    //        rc.total = [responseObject[@"total"] integerValue];
    //        if (self.params != params) return;
    //        [self.userTableV reloadData];
    //        [self.userTableV.mj_header endRefreshing];
    //        [self checkFooterState];
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        if (self.params != params) return;
    //        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
    //        [self.userTableV.mj_header endRefreshing];
    //    }];
}

- (void)loadMoreUsers{
    [self.userTableV.mj_header endRefreshing];
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    ARRecommendCategoryM *category = self.categories[self.categoryTableV.indexPathForSelectedRow.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    ARNetworkTools *tools = [ARNetworkTools sharedTools];
    //[tools.tasks makeObjectsPerformSelector:@selector(cancel)];
    [tools request:GET urlString:@"http://api.budejie.com/api/api_open.php" parameters:params finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            if (self.params != params) return;
            category.currentPage--;
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            [self.userTableV.mj_footer endRefreshing];
            return;
        }
        NSArray *users = [ARRecommendUserM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:users];
        if (self.params != params) return;
        [self.userTableV reloadData];
        [self checkFooterState];
    }];
    
    //    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    //        NSArray *users = [ARRecommendUserM mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    //        [category.users addObjectsFromArray:users];
    //        if (self.params != params) return;
    //        [self.userTableV reloadData];
    //        [self checkFooterState];
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        if (self.params != params) return;
    //        category.currentPage--;
    //        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
    //        [self.userTableV.mj_footer endRefreshing];
    //    }];
}

- (void)checkFooterState{
    ARRecommendCategoryM *rc = self.categories[self.categoryTableV.indexPathForSelectedRow.row];
    self.userTableV.mj_footer.hidden = (rc.users.count == 0);
    if (rc.users.count == rc.total) {
        [self.userTableV.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableV.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableV) return self.categories.count;
    [self checkFooterState];
    return [self.categories[self.categoryTableV.indexPathForSelectedRow.row] users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableV) {
        ARRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ARCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        ARRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ARUserId];
        cell.user = [self.categories[self.categoryTableV.indexPathForSelectedRow.row] users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableV) {
        [self.userTableV.mj_header endRefreshing];
        [self.userTableV.mj_footer endRefreshing];
        
        ARRecommendCategoryM *rc = self.categories[indexPath.row];
        if (rc.users.count) {
            [self.userTableV reloadData];
        } else {
            [self.userTableV reloadData];
            [self.userTableV.mj_header beginRefreshing];
        }
    }
}

- (void)dealloc{
    //[self.manager.operationQueue cancelAllOperations];
    [[ARNetworkTools sharedTools].operationQueue cancelAllOperations];
}
@end
