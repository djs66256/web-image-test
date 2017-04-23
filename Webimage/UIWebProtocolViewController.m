//
//  UIWebProtocolViewController.m
//  Webimage
//
//  Created by daniel on 2017/4/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "UIWebProtocolViewController.h"

@interface UIWebProtocolViewController ()

@end

@implementation UIWebProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerProtocol];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.UIWebView loadHTMLString:[self webImageHtml] baseURL:[NSURL URLWithString:@"file://"]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self unregisterProtocol];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
