//
//  ARADVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/3.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARADVC.h"
#import <DALabeledCircularProgressView.h>

@interface ARADVC ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressV;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@end

@implementation ARADVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
