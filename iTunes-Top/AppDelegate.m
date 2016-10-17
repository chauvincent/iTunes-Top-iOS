//
//  AppDelegate.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"

@interface AppDelegate ()

@property (strong, nonatomic) RootTabBarController *rootTabBarVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup Styling
    [self setupTabBar];
    [self setupNavigation];
    
    // Setup Root View Controller as TabBarController
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.rootTabBarVC = [[RootTabBarController alloc] init];
    self.window.rootViewController = self.rootTabBarVC;
    [self.window makeKeyAndVisible];
    
    // Image Cache Setup
    if (!self.imgCache)
    {
        self.imgCache = [[NSCache alloc] init];
    }
    
    return YES;
}

- (void)setupTabBar
{
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTranslucent:NO];
}

- (void)setupNavigation
{
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
}

@end
