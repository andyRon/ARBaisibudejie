//
//  ARPicNewV.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARPicNewV.h"
#import "ARTopicNewM.h"
#import "ARSeeBigPicNewVC.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import <FLAnimatedImage.h>

@interface ARPicNewV()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderV;
@property (weak, nonatomic) IBOutlet UIImageView *gifV;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView  *progressV;

@end

@implementation ARPicNewV
{
    NSString * _url;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageV.userInteractionEnabled = YES;
    [self.imageV addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)] ];
    
    self.progressV.roundedCorners = YES;
    self.progressV.progressLabel.textColor = [UIColor redColor];
    //self.progressV.trackTintColor = [UIColor clearColor];
    self.progressV.progressTintColor = [UIColor lightGrayColor];
    //self.progressV.thicknessRatio = 0.2f;
    //self.progressV.clockwiseProgress = NO;//顺时针
}

-(void) seeBigPic{
    ARSeeBigPicNewVC *vc = [[ARSeeBigPicNewVC alloc] init];
    vc.topic = self.topic;
    //    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(ARTopicNewM *)topic{
    _topic = topic;
    _url = @"";
    self.placeholderV.hidden = NO;
    self.progressV.hidden = YES;
    self.progressV.progressLabel.text = @"";
    [self.progressV setProgress:topic.picProgress animated:NO];
    self.imageV.animatedImage = nil;
    self.imageV.image = nil;
    
    [self.imageV tg_setOriginImage:topic.image thumbnailImage:topic.image_small placeholder:nil progress:^(NSInteger receivedSize, NSInteger expectedSize,NSURL * _Nullable targetURL) {
        self.progressV.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        topic.picProgress = progress<=0.01 ? 0.01 : progress;
        [self.progressV setProgress:topic.picProgress animated:YES];
        [self.progressV.progressLabel setText:[NSString stringWithFormat:@"%.0f%%",topic.picProgress * 100]];
        ARLog(@"%f,%@,%@",progress,self.progressV.progressLabel.text,NSStringFromCGRect(self.progressV.progressLabel.frame));
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.placeholderV.hidden = YES;
        self.progressV.hidden = YES;
        //移至线程中
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = topic.width > 0 && topic.height > 0 ? imageW * topic.height / topic.width : 200;//大图等比例缩小至topic.middleFrame.size.width，小图等比例放大至topic.middleFrame.size.width
            //UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            UIGraphicsBeginImageContextWithOptions(self.topic.middleFrame.size,0, [UIScreen mainScreen].scale);
            [self.imageV.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageV.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        if ([topic.images_gif.pathExtension.lowercaseString isEqualToString:@"gif"]) {
            _url = topic.images_gif;
            [self tg_gifForUrl:_url];
        }
    }];
    
    
    self.gifV.hidden = ![topic.type.lowercaseString isEqualToString:@"gif"];
    self.gifV.hidden = ![topic.images_gif.lowercaseString hasSuffix:@"gif"];
    self.gifV.hidden = ![topic.images_gif.pathExtension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigPictureBtn.hidden = NO;
        self.imageV.contentMode = UIViewContentModeTop;//UIViewContentModeScaleToFill改成UIViewContentModeTop只显示开始部分
        self.imageV.clipsToBounds = YES;//超出部分剪掉
        //移至下载图片线程的完成block中
    } else {
        self.seeBigPictureBtn.hidden = YES;
        self.imageV.contentMode = UIViewContentModeScaleToFill;
        self.imageV.clipsToBounds = NO;
    }
}

- (void)tg_gifForUrl:(NSString*)url{
    id obj = [[self getCache] objectForKey:url];
    if (obj != nil ) {
        self.imageV.animatedImage= (FLAnimatedImage*)obj;
        //ARLog(@"缓存中的 -- %@",url);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        FLAnimatedImage *flImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [[self getCache] setObject:flImage forKey:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            //ARLog(@"下载的 -- %@",url);
            if (_url == url){
                self.imageV.animatedImage= flImage;
            }else{
                //ARLog(@"# 错位了 不用设置gif（重用机制造成的，原理请参考SDWebImage）#");
            }
        });
    });
}

- (NSCache*)getCache{
    static NSCache * cache =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc]init];
        cache.countLimit = GIFCacheCountLimit;//关键
        //ARLog(@"-- 自己的缓存策略 --");
    });
    return cache;
}

@end
