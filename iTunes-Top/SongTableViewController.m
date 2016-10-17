//
//  SongTableViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "SongTableViewController.h"
#import "Constants.h"
#import "PreviewAudioView.h"
#import "StoreItemTableViewCell.h"
#import "NetworkManager.h"

@interface SongTableViewController ()

@property (strong, nonatomic) PreviewAudioView *previewView;
@property (strong, nonatomic) NSMutableArray *allSongs;

@end

@implementation SongTableViewController

#pragma mark Lazy Init

- (PreviewAudioView *)previewView
{
    if (!_previewView)
    {
        _previewView = [[PreviewAudioView alloc] init];
    }
    return _previewView;
}

- (NSMutableArray *)allSongs
{
    if (!_allSongs)
    {
        _allSongs = [NSMutableArray array];
    }
    return _allSongs;
}

- (instancetype)init
{
    if (self = [super init])
    {
        // Subscribe to RootTabBar's Finished All Downloads Notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedSongs:) name:kObserverFinishedSongs object:nil];
    }
    
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self.tableView registerClass:[StoreItemTableViewCell class] forCellReuseIdentifier:@"SongCell"];
}

#pragma mark - NSNotificationCenter

- (void)finishedSongs:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *allObjects = [[notification object] mutableCopy];
        self.allSongs = allObjects;
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"Observer Did Not Get Caught");
    }
}

#pragma mark - Setup View

- (void)setupView
{
    // Setup Navigation
    self.navigationItem.title = @"Top Songs";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allSongs count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.previewView showMenu:self.allSongs[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SongCell";
    
    StoreItemTableViewCell *cell = (StoreItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[StoreItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Song *song = self.allSongs[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld.", indexPath.row + 1];
    cell.nameLabel.text = song.name;
    
    [cell setImage:song.imageLink];
    
    return cell;
}



@end
