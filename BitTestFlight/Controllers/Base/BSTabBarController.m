//
//  BSTabBarController.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "BSTabBarController.h"
#import "RDVTabBarItem.h"

#import "BaseNavigationController.h"

#import "HomePageVC.h"

@interface BSTabBarController()<RDVTabBarControllerDelegate>

@end

@implementation BSTabBarController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewControllers];
}

- (void)setupViewControllers {
    HomePageVC *homePageVC = [[HomePageVC alloc] init];
    BaseNavigationController *homePage_nav = [[BaseNavigationController alloc] initWithRootViewController:homePageVC];
    
    HomePageVC *homePageVC2 = [[HomePageVC alloc] init];
    BaseNavigationController *homePage_nav2 = [[BaseNavigationController alloc] initWithRootViewController:homePageVC2];
    
    HomePageVC *homePageVC3 = [[HomePageVC alloc] init];
    BaseNavigationController *homePage_nav3 = [[BaseNavigationController alloc] initWithRootViewController:homePageVC3];
    
    [self setViewControllers:@[homePage_nav, homePage_nav2, homePage_nav3]];
    
    [self customizeTabBarForController];
    
    self.delegate = self;
}

- (void)customizeTabBarForController {
    NSArray *tabBarItemImages = @[@"homepage", @"homepage", @"homepage"];
    NSArray *tabBarItemTitles = @[@"首页1", @"首页2", @"首页3"];
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName: kColorText1}];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName: kColorMain}];
        item.badgePositionAdjustment = UIOffsetMake(0, kSafeArea_Bottom / 2);
        index++;
    }
}

#pragma mark - RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    
    return YES;
}
@end
