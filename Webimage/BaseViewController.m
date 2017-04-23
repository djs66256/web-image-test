//
//  BaseViewController.m
//  Webimage
//
//  Created by daniel on 2017/4/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageURLProtocol.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)htmlWithImage:(NSString *)path {
    return [NSString stringWithFormat:@""
    "<html>"
    "<body>"
    "<h1>Hello world</h1>"
    "<img src=\"%@\" />"
    "</body>"
    "</html>", path];
}

- (NSString *)webImageHtml {
    return [self htmlWithImage:@"https://www.baidu.com/img/bd_logo1.png"];
}

- (NSString *)imagePath {
    return [[NSBundle mainBundle] pathForResource:@"baidu_logo" ofType:@"png"];
}

- (NSString *)fileImageHtml {
    NSString *fileUrl = [NSString stringWithFormat:@"file://%@", self.imagePath];
//    fileUrl = @"file:///Users/daniel/Documents/workspace/test/Webimage/Webimage/baidu_logo.png";
    NSLog(@"[%@]%@", @([[NSFileManager defaultManager] fileExistsAtPath:fileUrl]), fileUrl);
    
    return [self htmlWithImage:fileUrl];
}

- (WKWebView *)WKWebView {
    if (_WKWebView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _WKWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _WKWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_WKWebView];
    }
    return _WKWebView;
}

- (UIWebView *)UIWebView {
    if (_UIWebView == nil) {
        _UIWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _UIWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_UIWebView];
    }
    return _UIWebView;
}

- (void)registerProtocol {
    [NSURLProtocol registerClass:[ImageURLProtocol class]];
}

- (void)unregisterProtocol {
    [NSURLProtocol unregisterClass:[ImageURLProtocol class]];
}

@end
