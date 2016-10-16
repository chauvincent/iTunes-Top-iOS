//
//  RootTabBarController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "RootTabBarController.h"
#import "FeaturedCollectionViewController.h"

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
    FeaturedCollectionViewController *featuredVC = [[FeaturedCollectionViewController alloc] initWithCollectionViewLayout:layout];
    UINavigationController *featuredNav = [[UINavigationController alloc] initWithRootViewController:featuredVC];
 
    

    
    // Add All Navigation Controllers
    self.viewControllers = @[featuredNav];
}

@end
