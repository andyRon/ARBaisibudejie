//
//  ARSettingVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARSettingVC.h"
#import <SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ARFileTool.h"

static NSString * const ID = @"cell";

@interface ARSettingVC ()

@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation ARSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [SVProgressHUD showWithStatus:@"正在计算缓存大小。。。"];
    [ARFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

- (void)jump{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [self sizeStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ARFileTool removeDirectoryPath:CachePath];
    _totalSize = 0;
    [self.tableView reloadData];
}

- (NSString *)sizeStr{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"清除缓存";
    if (totalSize > 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,totalSize / 1000.0 / 1000.0];
    } else if (totalSize > 1000) {
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,totalSize / 1000.0];
    } else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%ldB)",sizeStr,(long)totalSize];
    }
    return sizeStr;
}

@end
