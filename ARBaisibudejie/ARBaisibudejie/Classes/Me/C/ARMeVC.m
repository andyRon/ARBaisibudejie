//
//  ARMeVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARMeVC.h"
#import "ARSettingVC.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ARSquareM.h"
#import "ARSquareCell.h"
#import "ARWebVC.h"

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const onemargin = 1;
#define itemWH (ScreenW - (cols - 1) * onemargin) / cols

@interface ARMeVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionV;

@end

@implementation ARMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [mgr GET:CommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        _squareItems = [ARSquareM mj_objectArrayWithKeyValuesArray:dictArr];
        [self resloveData];
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionV.height = rows * itemWH;
        self.tableView.tableFooterView = self.collectionV;//MARK:2
        [self.collectionV reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)resloveData {//一行补足剩余空白
    NSInteger exter = self.squareItems.count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            [self.squareItems addObject:[[ARSquareM alloc] init]];
        }
    }
}

- (void)setupNavBar {
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    self.navigationItem.title = @"我的";
    
}

- (void)setupFootView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = onemargin;
    layout.minimumLineSpacing = onemargin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 1) collectionViewLayout:layout];
    _collectionV = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;//MARK:1
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"ARSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)night:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)setting{
    ARSettingVC *settingVC = [[ARSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)tabBarButtonDidRepeatClick {
    if (self.view.window == nil) return;
    ARFunc
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ARSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ARSquareM *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    ARWebVC *webVc = [[ARWebVC alloc] init];
    webVc.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVc animated:YES];
}


@end
