//
//  AppDelegate.m
//  One Click
//
<<<<<<< HEAD
//  Created by David Woldenberg on 4/21/15.
=======
//  Created by David Woldenberg on 1/27/15.
>>>>>>> ee01d12988816c0010ed61c2e6fc05f90065535a
//  Copyright (c) 2015 davidwoldenberg. All rights reserved.
//

#import "AppDelegate.h"
<<<<<<< HEAD
=======
#import "MainController.h"
>>>>>>> ee01d12988816c0010ed61c2e6fc05f90065535a

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
<<<<<<< HEAD
    return YES;
=======
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainController *mainController = [[MainController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
    
>>>>>>> ee01d12988816c0010ed61c2e6fc05f90065535a
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
