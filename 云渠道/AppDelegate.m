//
//  AppDelegate.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.

#import "AppDelegate.h"
#import "CYLTabBarControllerConfig.h"
#import "LoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知，退出登陆时回到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeBackLoginVC) name:@"goLoginVC" object:nil];
    
    
//    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    _window.rootViewController = tabBarControllerConfig.tabBarController;
//    if ([logIndentifier isEqualToString:@"logInSuccessdentifier"]) {
//
//
//
//    }else {
//
//        //未登录
//        LoginVC *mainLogin_vc = [[LoginVC alloc] init];
//        UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
//        mainLogin_nav.navigationBarHidden = YES;
//        _window.rootViewController = mainLogin_nav;
//    }
    
    
    return YES;
}

- (void)comeBackLoginVC {
    //未登录
    _window .alpha = 0;
    _window = nil;
    _window =[[UIWindow alloc]init];
    LoginVC *mainLogin_vc = [[LoginVC alloc] init];
    UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
    mainLogin_nav.navigationBarHidden = YES;
    _window.rootViewController = mainLogin_nav;
    [_window makeKeyAndVisible];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
