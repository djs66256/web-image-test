//
//  MainTableViewController.m
//  Webimage
//
//  Created by daniel on 2017/4/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "MainTableViewController.h"
#import "UIWebProtocolViewController.h"
#import "UIWebFileViewController.h"
#import "WKWebFileViewController.h"
#import "WKWebProtocolViewController.h"
#import "WKWebViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"UIWebview + Protocol";
        }
        else {
            cell.textLabel.text = @"WKWebview + Protocol";
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"UIWebview + file://";
        }
        else {
            cell.textLabel.text = @"WKWebview + file://";
        }
    }
    else {
        cell.textLabel.text = @"WKWebview";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *controller = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            controller = [UIWebProtocolViewController new];
        }
        else {
            controller = [WKWebProtocolViewController new];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            controller = [UIWebFileViewController new];
        }
        else {
            controller = [WKWebFileViewController new];
        }
    }
    else {
        controller = [WKWebViewController new];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
