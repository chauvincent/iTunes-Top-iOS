//
//  SongTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "SongTableViewController.h"
#import "Constants.h"

@interface SongTableViewController ()

@end

@implementation SongTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - NSNotificationCenter


#pragma mark - Setup View

- (void)setupView
{
    // Setup Navigation
    self.navigationItem.title = @"Top Songs";
    

}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    return cell;
}



@end
