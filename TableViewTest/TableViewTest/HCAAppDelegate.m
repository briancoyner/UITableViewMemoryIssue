//
//  HCAAppDelegate.m
//  TableViewTest
//
//  Created by Brian Coyner on 9/30/13.
//  Copyright (c) 2013 Brian Coyner. All rights reserved.
//

#import "HCAAppDelegate.h"

#import "HCAViewController.h"

@implementation HCAAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    HCAViewController *menuViewController = [[HCAViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:navigationController];

    [_window makeKeyAndVisible];
    
    return YES;
}

@end
