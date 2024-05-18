//
//  AppDelegate.m
//  shimmer
//
//  Created by kevin on 21/2/24.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@end

@implementation AppDelegate{
    UIBackgroundTaskIdentifier bgTask;
    NSUInteger counter;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //UINavigationController *launch = [[UINavigationController alloc] initWithRootViewController:[[LaunchViewController alloc]init]];
    UINavigationController *main = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc]init]];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    //double delayInSeconds = 2.0;
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //    self.window.rootViewController = main;
     //   [self.window makeKeyAndVisible];
    //});
    return YES;
}

/*
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
*/

//后台处理
- (void)applicationBackgroundHandler {
    UIApplication* app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:self->bgTask];
        self->bgTask = UIBackgroundTaskInvalid;
    }];
    // Start the long-running task
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            NSLog(@"counter:%ld", (long)self->counter++);
            sleep(1);
        }
    });
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{[self applicationBackgroundHandler]; }];
    if (backgroundAccepted){
        NSLog(@"backgrounding accepted");
    }
    [self applicationBackgroundHandler];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

