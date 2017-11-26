//
//  ARLoginRegisterV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARLoginRegisterV.h"

@interface ARLoginRegisterV()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation ARLoginRegisterV

+(instancetype) loginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

+(instancetype) registerView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][1];
}

-(void) awakeFromNib{
    [super awakeFromNib];
    UIImage * img= _loginRegisterBtn.currentBackgroundImage;
    img = [img stretchableImageWithLeftCapWidth:img.size.width*0.5  topCapHeight:img.size.height*0.5];
    [_loginRegisterBtn setBackgroundImage:img forState:UIControlStateNormal];
}

@end
