//
//  Login.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"

#define kLoginStatus @"login_status"
#define kLoginUserDict @"user_dict"
#define kLoginDataListPath @"login_data_list_path.plist"

static User *curLoginUser;

@implementation Login

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    if (loginStatus.boolValue && [Login curLoginUser]) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)doLogin:(NSDictionary *)loginData{

    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        [defaults setObject:[loginData mj_JSONString] forKey:kLoginUserDict];
        curLoginUser = [User mj_objectWithKeyValues:loginData];
        [defaults synchronize];
        
        [self saveLoginData:loginData];
    }else{
        [Login doLogout];
    }
}

+ (NSMutableDictionary *)readLoginDataList{
    NSMutableDictionary *loginDataList = [NSMutableDictionary dictionaryWithContentsOfFile:[self loginDataListPath]];
    if (!loginDataList) {
        loginDataList = [NSMutableDictionary dictionary];
    }
    return loginDataList;
}

+ (BOOL)saveLoginData:(NSDictionary *)loginData{
    BOOL saved = NO;
    if (loginData) {
        NSMutableDictionary *loginDataList = [self readLoginDataList];
        User *curUser = [User mj_objectWithKeyValues:loginData];
        if (curUser.userId.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.userId];
            saved = YES;
        }
        
        if (saved) {
            saved = [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
        }
    }
    return saved;
}

+ (NSString *)loginDataListPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingPathComponent:kLoginDataListPath];
}

+ (void)doLogout {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [defaults synchronize];
}

+ (User *)curLoginUser{
    if (!curLoginUser) {
        NSString *loginJsonStr = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        NSDictionary *loginData = [loginJsonStr mj_JSONObject];
        curLoginUser = loginData? [User mj_objectWithKeyValues:loginData] : nil;
    }
    return curLoginUser;
}

@end
