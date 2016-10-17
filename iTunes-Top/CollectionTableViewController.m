//
//  CollectionTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Setup View

- (void)setupView
{
    self.navigationItem.title = @"Top iTunes U Collection";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    
    return cell;
}


@end
