//
//  AudioBookTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "AudioBookTableViewController.h"
#import "Constants.h"

@interface AudioBookTableViewController ()

@end

@implementation AudioBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

}

#pragma mark - Setup View

- (void)setupView
{
    self.navigationItem.title = @"Top Audio";
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AudioCell" forIndexPath:indexPath];
    
    return cell;
}

@end
