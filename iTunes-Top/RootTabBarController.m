//
//  RootTabBarController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "RootTabBarController.h"
#import "FeaturedViewController.h"
#import "SongTableViewController.h"
#import "AudioBookTableViewController.h"
#import "CollectionTableViewController.h"
#import "NetworkManager.h"
#import "JSONParser.h"
#import "Constants.h"

@interface RootTabBarController ()

@property (strong, nonatomic) NSArray *allCategory;
@property (strong, nonatomic) NSMutableArray *allSongs;
@property (strong, nonatomic) NSMutableArray *allAudio;
@property (strong, nonatomic) NSMutableArray *allCollection;

@end

@implementation RootTabBarController

#pragma mark - Lazy Init

- (NSArray *)allCategory
{
    if (!_allCategory)
    {
        _allCategory = [NSMutableArray array];
    }
    return _allCategory;
}

- (NSMutableArray *)allSongs
{
    if (!_allSongs)
    {
        _allSongs = [NSMutableArray array];
    }
    return _allSongs;
}

- (NSMutableArray *)allAudio
{
    if (!_allAudio)
    {
        _allAudio = [NSMutableArray array];
    }
    return _allAudio;
}

- (NSMutableArray *)allCollection
{
    if (!_allCollection)
    {
        _allCollection = [NSMutableArray array];
    }
    return _allCollection;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupControllers];

    // Download and Setup Model For Entire App
    [self downloadAll];
}

#pragma mark - Setup Views

- (void)setupControllers
{
    // Featured View Controller
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    FeaturedViewController *featuredVC = [[FeaturedViewController alloc] initWithCollectionViewLayout:layout];
    UINavigationController *featuredNav = [[UINavigationController alloc] initWithRootViewController:featuredVC];
    featuredNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Featured" image:[UIImage imageNamed:@"home_btn"] tag:0];
    
    // Song Table View Controller
    SongTableViewController *songVC = [[SongTableViewController alloc] init];
    UINavigationController *songNav = [[UINavigationController alloc] initWithRootViewController:songVC];
    songNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top Songs" image:[UIImage imageNamed:@"songs_icon"] tag:1];

    // Audio Table View Controller
    AudioBookTableViewController *audioVC = [[AudioBookTableViewController alloc] init];
    UINavigationController *audioNav = [[UINavigationController alloc] initWithRootViewController:audioVC];
    audioNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top Audio Books" image:[UIImage imageNamed:@"audio_icon"] tag:2];

    // Collection Table View Controller
    CollectionTableViewController *collectionVC = [[CollectionTableViewController alloc] init];
    UINavigationController *collectionNav = [[UINavigationController alloc] initWithRootViewController:collectionVC];
    collectionNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top Collection" image:[UIImage imageNamed:@"collection_icon"] tag:3];

    // Add All Navigation Controllers to TabBarController
    self.viewControllers = @[featuredNav, songNav, audioNav, collectionNav];
}

#pragma mark - Setup Model

- (void)downloadAll
{
    JSONParser *parser = [[JSONParser alloc] init];
    dispatch_group_t serviceGroup = dispatch_group_create();
    dispatch_group_enter(serviceGroup);
    
    // Top Collection
    [NetworkManager getDataFromEndpoint:kEndpointCollection withCompletion:^(bool success, NSArray *entry) {
        
        [parser parseCollectionJSONWithEntry:entry withCompletion:^(NSMutableArray *collection) {

            self.allCollection = collection;
            dispatch_group_leave(serviceGroup);
        }];

    }];
    
    dispatch_group_enter(serviceGroup);
    
    // Top Songs
    [NetworkManager getDataFromEndpoint:kEndpointSongs withCompletion:^(bool success, NSArray *entry) {
        
        [parser parseSongJSONWithEntry:entry withCompletion:^(NSMutableArray *allSongs) {
            
            self.allSongs = allSongs;
            dispatch_group_leave(serviceGroup);
            
        }];
        
    }];
    
    dispatch_group_enter(serviceGroup);
    
    // Top AudioBooks
    [NetworkManager getDataFromEndpoint:kEndpointAudioBook withCompletion:^(bool success, NSArray *entry) {
        
        [parser parseAudioBookJSONWithEntry:entry withCompletion:^(NSMutableArray *allAudioBooks) {
            
            self.allAudio = allAudioBooks;
            dispatch_group_leave(serviceGroup);
            
        }];
        
    }];
    
    // All Tasks Finished
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        
        self.allCategory = [@[self.allSongs, self.allAudio, self.allCollection] mutableCopy];
    
        // Notify all VC's
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserverFinishedAll object:self.allCategory];
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserverFinishedCollection object:self.allCollection];
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserverFinishedSongs object:self.allSongs];
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserverFinishedAudioBook object:self.allAudio];
        
    });
}

@end
