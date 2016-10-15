//
//  RootTabBarController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "RootTabBarController.h"
#import "FeaturedViewController.h"

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
    FeaturedViewController *vc = [[FeaturedViewController alloc] init];
    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:vc];
 
    
    
    self.viewControllers = @[vcNav];
    
}

@end
