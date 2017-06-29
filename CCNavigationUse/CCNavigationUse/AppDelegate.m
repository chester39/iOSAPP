//
//  AppDelegate.m
//      CCNavigationUse
//      Chen Chen @ June 11th, 2015
//

#import "AppDelegate.h"
#import "CCViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 系统代理方法

/**
 *  应用启动方法
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CCViewController *ccvc = [[CCViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] init];
    [nav addChildViewController:ccvc];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 *  应用将要失去焦点方法
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"应用将要失去焦点，%s", __func__);
}

/**
 *  应用已经进入后台方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"应用已经进入后台，%s", __func__);
}

/**
 *  应用将要进入前台方法
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"应用将要进入前台，%s", __func__);
}

/**
 *  应用已经成为焦点方法
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"应用已经成为焦点，%s", __func__);
}

/**
 *  应用将要终止方法
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"应用将要终止，%s", __func__);
}

@end
