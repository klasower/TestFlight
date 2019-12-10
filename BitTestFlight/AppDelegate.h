//
//  AppDelegate.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/16.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setupTabViewController;
- (void)setupLoginViewController;
- (void)setupHomePageViewController;
/**
 *  注册推送
 */
- (void)registerPush;

@end

