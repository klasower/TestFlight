//
//  NSObject+BSCommon.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BSCommon)

#pragma mark Tip M
+ (NSString *)tipFromError:(NSError *)error;
+ (BOOL)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString *)tipStr;
+ (MBProgressHUD *)showHUDQueryStr:(NSString *)titleStr;
+ (NSUInteger)hideHUDQuery;
+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;
+ (void)showStatusBarError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
