//
//  WKWebViewController.m
//  Webimage
//
//  Created by daniel on 2017/4/23.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) NSURL *cacheUrl;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cacheUrl = [NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"wk_image" withExtension:@"html"];
    NSURL *cacheHtmlUrl = [self.cacheUrl URLByAppendingPathComponent:@"wk_image.html"];
    [[NSFileManager defaultManager] removeItemAtURL:cacheHtmlUrl error:nil];
    [[NSFileManager defaultManager] copyItemAtURL:htmlUrl toURL:cacheHtmlUrl error:nil];
    self.WKWebView.navigationDelegate = self;
    [self.WKWebView loadFileURL:cacheHtmlUrl allowingReadAccessToURL:self.cacheUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSArray *urls = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492717673480&di=31b126af31f6ff98201fec70315bfb7c&imgtype=0&src=http%3A%2F%2Fwww.yaochanglai.com%2Fd%2Ffile%2Fziranmima%2Fguaiyizhiwu%2F20170307%2Fxxj2551dswdufrdm5.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492717673479&di=cf7d0d913efe52ff1888cda7b4a37278&imgtype=0&src=http%3A%2F%2Fpic74.nipic.com%2Ffile%2F20150728%2F18138004_201107753000_2.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492717673479&di=d4fdce71f14b98831fa384701f4014e4&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20131025%2FImg388904988.jpg",
                      @"error"];
    for (NSString *url in urls) {
        // 预加载一个空的占位节点
        [self.WKWebView evaluateJavaScript:[NSString stringWithFormat:@"appendImage('%@')", url] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
            
        }];
        
        // 这里伪造一个进图条
        __block NSInteger progress = 0;
        if ([url hasPrefix:@"http"]) [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            progress += 5;
            [self.WKWebView evaluateJavaScript:[NSString stringWithFormat:@"updateProgress('%@', '%zd')", url, progress] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
                
            }];
            if (progress >= 100) {
                [timer invalidate];
            }
        }];
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [self.WKWebView evaluateJavaScript:[NSString stringWithFormat:@"updateError('%@', '%@')", url, error.localizedDescription] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
                    
                }];
            }
            else {
                NSURL *fileUrl = [self.cacheUrl URLByAppendingPathComponent:url.lastPathComponent];
                [data writeToURL:fileUrl atomically:YES];
                [self.WKWebView evaluateJavaScript:[NSString stringWithFormat:@"updateImage('%@', '%@')", url, fileUrl.absoluteString] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
                    
                }];
            }
        }] resume];
    }
}


@end
