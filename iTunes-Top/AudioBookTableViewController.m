//
//  AudioBookTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "AudioBookTableViewController.h"
#import "Constants.h"
#import "StoreItemTableViewCell.h"

@interface AudioBookTableViewController ()

@property (strong, nonatomic) NSMutableArray *allSongs;

@end

@implementation AudioBookTableViewController

- (instancetype)init
{
    if (self = [super init])
    {
        // Subscribe to RootTabBar's Finished All Downloads Notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedAllSongs:) name:kObserverFinishedSongs object:nil];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Setup View

- (void)setupView
{
    self.navigationItem.title = @"Top Audio";
    [self.tableView registerClass:[StoreItemTableViewCell class] forCellReuseIdentifier:@"AudioCell"];
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
