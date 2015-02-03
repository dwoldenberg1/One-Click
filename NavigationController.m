//
//  NavigationController.m
//  One Click
//
//  Created by David Woldenberg on 1/27/15.
//  Copyright (c) 2015 davidwoldenberg. All rights reserved.
//

#import "NavigationController.h"
#import "MainFeedController.h"

@implementation NavigationController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[MainFeedController sharedInstance]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
