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
    // Do any additional setup after loading the view from its nib.
}

- (UIImageView *)addView{
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
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[]
}




@end
