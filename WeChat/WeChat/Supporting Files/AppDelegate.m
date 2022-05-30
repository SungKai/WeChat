//
//  AppDelegate.m
//  WeChat
//
//  Created by 宋开开 on 2022/5/28.
//

#import "AppDelegate.h"
#import "LoginVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LoginVC *loginVC = [[LoginVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
