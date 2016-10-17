//
//  RootTabBarController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "RootTabBarController.h"
#import "FeaturedViewController.h"
#import "SongTableViewController.h"
#import "AudioBookTableViewController.h"
#import "CollectionTableViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupControllers];
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
    
    // Add All Navigation Controllers
    self.viewControllers = @[featuredNav, songNav, audioNav, collectionNav];
}

@end
