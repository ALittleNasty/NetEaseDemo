//
//  YYContentViewController.m
//  NetEaseDemo
//
//  Created by 胡阳 on 16/2/17.
//  Copyright © 2016年 apple.com. All rights reserved.
//

#import "YYContentViewController.h"

@interface YYContentViewController ()

@end

static NSString *ID = @"contentCellID";

@implementation YYContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd",self.title, indexPath.row] ;
    cell.textLabel.textAlignment = NSTextAlignmentCenter ;
    return cell;
}

@end
