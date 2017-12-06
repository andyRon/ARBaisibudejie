//
//  ARADVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/3.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARADVC.h"
#import <DALabeledCircularProgressView.h>
#import "ARADM.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ARMainVC.h"
#import "ARPushGuideV.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface ARADVC ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressV;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic, weak) UIImageView *adView;
@property (nonatomic, strong) ARADM *item;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ARADVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupProgressView];
    [self setupLaunchImage];
    [self loadAdData];
    _timer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (UIImageView *)adView{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContainView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}

- (void)tap{
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url options:nil completionHandler:nil];
    }
}
- (IBAction)clickJump:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[ARMainVC alloc] init];
    [_timer invalidate];
}

- (void)setupProgressView {
    self.progressV.roundedCorners = YES;
    self.progressV.progressLabel.textColor = [UIColor redColor];
    self.progressV.trackTintColor = [UIColor redColor];
    self.progressV.progressTintColor = ARGrayColor(242);
    self.progressV.hidden = YES;
    self.progressV.progressLabel.text = @"";
    self.progressV.thicknessRatio = 0.1;
    [self.progressV setProgress:0 animated:NO];
}

- (void)timeChange{
    static int i = 30;
    self.progressV.hidden = NO;
    CGFloat progress = 1.0 * (30.0 - i + 1) / 30.0;
    [self.progressV setProgress:progress animated:YES];
    //[self.progressV.progressLabel setText:[NSString stringWithFormat:@"%.0f%%",progress * 100]];
    
    if (i == 0) {
        self.progressV.hidden = YES;
        [self clickJump:nil];
    }
    i--;
    //[_jumpBtn setTitle:[NSString stringWithFormat:@"跳转 %d",i/10] forState:UIControlStateNormal];
}

- (void)setupLaunchImage{
    if (iphone6P) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iphone4) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

- (void)loadAdData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        _item = [ARADM mj_objectWithKeyValues:adDict];
        CGFloat h = ScreenW / _item.w * _item.h;
        
        if (h>0) {
            //self.adView.frame = CGRectMake(0, 0, ScreenW, h);
            self.adView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
            self.adView.contentMode = UIViewContentModeScaleToFill;
            [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"测试%@",error);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"视图加载完成");
}

- (void)dealloc {
    NSLog(@"销毁");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"nib加载完成");
}

//视图将要出现
//- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"%s", __FUNCTION__);
//    [super viewWillAppear:animated];
//}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
}

@end
