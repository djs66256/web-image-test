//
//  WKWebFileViewController.m
//  Webimage
//
//  Created by daniel on 2017/4/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "WKWebFileViewController.h"

@interface WKWebFileViewController ()

@end

@implementation WKWebFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerProtocol];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"wk_file" withExtension:@"html"];
    [self.WKWebView loadFileURL:fileUrl allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
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
