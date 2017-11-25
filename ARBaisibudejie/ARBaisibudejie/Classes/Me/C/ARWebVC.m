//
//  ARWebVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARWebVC.h"
#import <WebKit/WebKit.h>

@interface ARWebVC ()
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) WKWebView *webV;

@end

@implementation ARWebVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc] init];
    _webV = webView;
    [self.contentV addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (IBAction)goBack:(id)sender {
    [self.webV goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webV goForward];
}

- (IBAction)reload:(id)sender {
    [self.webV reload];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _webV.frame = self.contentV.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.backItem.enabled = self.webV.canGoBack;
    self.forwardItem.enabled = self.webV.canGoForward;
    self.title = self.webV.title;
    self.progressV.progress = self.webV.estimatedProgress;
    self.progressV.hidden = self.webV.estimatedProgress >= 1;
}

- (void)dealloc{
    [self.webV removeObserver:self forKeyPath:@"canGoBack"];
    [self.webV removeObserver:self forKeyPath:@"title"];
    [self.webV removeObserver:self forKeyPath:@"canGoForward"];
    [self.webV removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
