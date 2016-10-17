//
//  CollectionTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "Constants.h"

@interface CollectionTableViewController ()

@property (strong, nonatomic) NSMutableArray *allCollections;

@end

@implementation CollectionTableViewController

-(NSMutableArray *)allCollections
{
    if (!_allCollections)
    {
        _allCollections = [NSMutableArray array];
    }
    return _allCollections;
}

-(instancetype)init
{
    if (self = [super init])
    {
        // Subscribe to RootTabBar's Finished All Downloads Notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedCollection:) name:kObserverFinishedCollection object:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    [self.tableView registerClass:[StoreItemTableViewCell class] forCellReuseIdentifier:@"CollectionCell"];
}

#pragma mark - Setup View

- (void)setupView
{
    self.navigationItem.title = @"Top iTunes U Collection";
}

#pragma mark - NSNotificationCenter

- (void)finishedCollection:(NSNotification *)notification
{
    NSLog(@"called");
    if ([notification.object isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *allObjects = [[notification object] mutableCopy];
        self.allCollections = allObjects;
        NSLog(@"CAUGHT");
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"Observer Did Not Get Caught");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.allCollections count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectionCell";
    
    StoreItemTableViewCell *cell = (StoreItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[StoreItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    iTunesUCollection *collection = self.allCollections[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld.", indexPath.row + 1];
    cell.nameLabel.text = collection.name;
    [cell setImage:collection.imageLink];
    
    return cell;
}


@end
