//
//  NavigationController.m
//  One Click
//
//  Created by David Woldenberg on 1/27/15.
//  Copyright (c) 2015 davidwoldenberg. All rights reserved.
//

#import "NavigationController.h"
#import "VideoListViewController.h"

@implementation NavigationController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* Debug
    Timing_MarkStartTime();*/
    
    /* Initialize FB session - From FB SDK sample
    if (!OptionsModel.sharedInstance.fbsession.isOpen) {
        // create a fresh session object
        OptionsModel.sharedInstance.fbsession = [[FBSession alloc] initWithPermissions:@[@"publish_stream", @"video_upload"]];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (OptionsModel.sharedInstance.fbsession.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [OptionsModel.sharedInstance.fbsession openWithCompletionHandler:^(FBSession *session,
                                                                               FBSessionState status,
                                                                               NSError *error) {
            }];
        }
    }*/
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VideoListViewController sharedInstance]];
    //self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[TestCameraViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
