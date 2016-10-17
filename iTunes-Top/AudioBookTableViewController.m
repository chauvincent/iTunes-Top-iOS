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
#import "AudioBook.h"
#import "NetworkManager.h"
#import "PreviewAudioView.h"

@interface AudioBookTableViewController ()

@property (strong, nonatomic) NSMutableArray *allAudio;
@property (strong, nonatomic) PreviewAudioView *previewView;

@end

@implementation AudioBookTableViewController

#pragma mark Lazy Init

- (PreviewAudioView *)previewView
{
    if (!_previewView)
    {
        _previewView = [[PreviewAudioView alloc] init];
    }
    return _previewView;
}

- (NSMutableArray *)allAudio
{
    if (!_allAudio)
    {
        _allAudio = [NSMutableArray array];
    }
    return _allAudio;
}

#pragma mark - View Lifecycle

- (instancetype)init
{
    if (self = [super init])
    {
        // Subscribe to RootTabBar's Finished Audio Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedAudio:) name:kObserverFinishedAudioBook object:nil];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    
    [self.tableView registerClass:[StoreItemTableViewCell class] forCellReuseIdentifier:@"AudioCell"];
}

#pragma mark - NSNotificationCenter

- (void)finishedAudio:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *allObjects = [[notification object] mutableCopy];
        self.allAudio = allObjects;
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
    self.navigationItem.title = @"Top Audio";
    [self.tableView registerClass:[StoreItemTableViewCell class] forCellReuseIdentifier:@"AudioCell"];
}

#pragma mark - <UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allAudio count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.previewView showMenu:self.allAudio[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AudioCell";
    
    StoreItemTableViewCell *cell = (StoreItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[StoreItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    AudioBook *audioBook = self.allAudio[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld.", indexPath.row + 1];
    cell.nameLabel.text = audioBook.name;
    
    [cell setImage:audioBook.imageLink];
    
    return cell;
}

@end
