//
//  AppDelegate.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSAppDelegate.h"
#import "SSMapRootViewController.h"

@interface SSAppDelegate ()

@end

@implementation SSAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    SSMapRootViewController *aRootViewController = [[SSMapRootViewController alloc] init];
    UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:aRootViewController];
    self.window.rootViewController = aNavigationController;
    
    return YES;
}

@end
