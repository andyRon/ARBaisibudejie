//
//  ARFriendTrendVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARFriendTrendVC.h"
#import "ARLoginRegisterVC.h"
#import "ARRecommendVC.h"

@interface ARFriendTrendVC ()

@end

@implementation ARFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.title = @"我的关注";
    
}

- (void)friendsRecomment{
    ARFunc
    ARRecommendVC * recommendVC = [[ARRecommendVC alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (IBAction)loginRegister:(id)sender {
    [self presentViewController:[[ARLoginRegisterVC alloc] init] animated:YES completion:nil];
}

@end

