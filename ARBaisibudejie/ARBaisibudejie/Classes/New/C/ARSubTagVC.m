//
//  ARSubTagVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/7.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARSubTagVC.h"
#import "ARSubTagM.h"
#import "ARSubTagCell.h"
#import "ARNetworkTools.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const ID = @"cell";

@interface ARSubTagVC ()

@property (nonatomic, strong) NSArray *subTags;

@end

@implementation ARSubTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"ARSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    self.title = @"推荐标签";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ARColor(220, 220, 221);
    [SVProgressHUD showWithStatus:@"正在加载ing....."];
    [self setupRefresh];
}

- (void)setupRefresh{
    
}

- (void)loadData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [[ARNetworkTools sharedTools] request:GET urlString:CommonURL parameters:parameters finished:^(id responseObject, NSError * error) {
        if (error != nil) {
            [SVProgressHUD dismiss];
            return;
        }
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        _subTags = [ARSubTagM mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    //[[ARNetworkTools sharedTools].tasks makeObjectsPerformSelector:@selector(cancel)];//取消之前的请求 移至工具类中
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.subTags[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
