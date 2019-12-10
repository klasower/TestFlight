//
//  AppDelegate.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/16.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"

#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

#import "Login.h"
#import "BSNetAPIClient.h"

#import "LoginVC.h"
#import "BSTabBarController.h"
#import "HomePageVC.h"
#import "BaseNavigationController.h"

#if DEBUG
#import <FLEXManager.h>
#endif

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
#if DEBUG
    
    [[FLEXManager sharedManager] setNetworkDebuggingEnabled:YES];
    
#endif
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"0a96c2aad8d6ef67b61fee11"
                  channel:@"App Store"
         apsForProduction:NO
    advertisingIdentifier:nil];
    
    //网络
    //网络请求的时候在顶部会有个小菊花转动
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
//    if ([Login isLogin]) {
//        [self setupTabViewController];
//    }else{
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        [self setupLoginViewController];
//    }
    
    [self setupHomePageViewController];
    
    [self.window makeKeyAndVisible];
    
    [self debug];
    
    return YES;
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

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
  [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
  // Required
  NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
  completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - Push
- (void)registerPush {
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                 categories:[NSSet setWithObject:categorys]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
}

#pragma mark - Methods Private
- (void)setupLoginViewController{
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:loginVC]];
}

- (void)setupTabViewController{
    BSTabBarController *tabBarVC = [[BSTabBarController alloc] init];
    tabBarVC.tabBar.translucent = YES;
    
    [self.window setRootViewController:tabBarVC];
}

- (void)setupHomePageViewController {
    HomePageVC *homePageVC = [[HomePageVC alloc] init];
    BaseNavigationController *homePage_nav = [[BaseNavigationController alloc] initWithRootViewController:homePageVC];
    
    [self.window setRootViewController:homePage_nav];
}

- (void)debug {
    MJWeakSelf
    [Debugo fireWithConfiguration:^(DGConfiguration * _Nonnull configuration) {
        [configuration setupActionPlugin:^(DGActionPluginConfiguration * _Nonnull actionConfiguration) {
                    [actionConfiguration addCommonActionWithTitle:@"切换环境" handler:^(DGAction * _Nonnull action) {
                        [weakSelf switchEnvironment:action];
                    }];
                    
                    [actionConfiguration addCommonActionWithTitle:@"退出登录" handler:^(DGAction * _Nonnull action) {
                        // 已登录的状态要抹掉
                        if ([Login isLogin]) {
                            [Login doLogout];
                        }
                        // 跳转到登录页面
//                        [weakSelf setupLoginViewController];
                    }];
                    
                    [actionConfiguration addCommonActionWithTitle:@"FLEX" handler:^(DGAction * _Nonnull action) {
        #if DEBUG
                        [[FLEXManager sharedManager] showExplorer];
        #endif
                    }];
                }];
    }];
}

#pragma mark - 切换环境
- (void)switchEnvironment:(DGAction * _Nonnull)action {
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"切换环境" message:@"😁切换完成请重新登录~" preferredStyle:UIAlertControllerStyleActionSheet];
    // 获取api环境数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BSNetURL" ofType:@"plist"];
    NSDictionary *urlDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    for (NSString *environment in urlDic.allKeys) {
        NSString *url = urlDic[environment];
        [alerController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@(%@)", environment, url] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [BSNetAPIClient changeBaseURLStrTo:url];
            // 已登录的状态要抹掉
            if ([Login isLogin]) {
                [Login doLogout];
            }
            // 跳转到登录页面
//            [self setupLoginViewController];
        }]];
    }
    
    [alerController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
        
    }]];
    
    [[Debugo topViewController] presentViewController:alerController animated:YES completion:nil];
}

@end
