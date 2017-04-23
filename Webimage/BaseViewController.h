//
//  BaseViewController.h
//  Webimage
//
//  Created by daniel on 2017/4/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseViewController : UIViewController

- (NSString *)webImageHtml;
- (NSString *)fileImageHtml;
- (NSString *)htmlWithImage:(NSString *)path;

- (void)registerProtocol;
- (void)unregisterProtocol;

- (NSString *)imagePath;

@property (strong, nonatomic) UIWebView *UIWebView;
@property (strong, nonatomic) WKWebView *WKWebView;

@end
