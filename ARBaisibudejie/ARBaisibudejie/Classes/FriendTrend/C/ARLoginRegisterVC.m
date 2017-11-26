//
//  ARLoginRegisterVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARLoginRegisterVC.h"
#import "ARLoginRegisterV.h"
#import "ARThirdLoginV.h"

@interface ARLoginRegisterVC ()

@property (weak, nonatomic) IBOutlet UIView *middleV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleVLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ARLoginRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ARLoginRegisterV * loginV = [ARLoginRegisterV loginView];
    ARLoginRegisterV * regV = [ARLoginRegisterV registerView];
    
    [self.middleV addSubview:loginV];
    [self.middleV addSubview:regV];
    //    regV.x = self.middleV.width * 0.5;
    
    ARThirdLoginV *fastLoginV = [ARThirdLoginV fastLoginView];
    [self.bottomView addSubview:fastLoginV];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    ARLoginRegisterV *loginV = self.middleV.subviews[0];
    loginV.frame = CGRectMake(0, 0, self.middleV.width * 0.5, self.middleV.height);//XIB最外层要管，内部由约束管
    ARLoginRegisterV *regV = self.middleV.subviews[1];
    regV.frame = CGRectMake( self.middleV.width * 0.5, 0,self.middleV.width * 0.5, self.middleV.height);//XIB最外层要管，内部由约束管
    
    ARThirdLoginV *fastLoginV = self.bottomView.subviews.firstObject;
    fastLoginV.frame = self.bottomView.bounds;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchLoninOrRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    _middleVLeadingConstraint.constant = (_middleVLeadingConstraint.constant == 0) ? -self.middleV.width * 0.5 : 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
