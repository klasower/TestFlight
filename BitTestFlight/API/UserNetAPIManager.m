//
//  UserNetAPIManager.m
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/22.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "UserNetAPIManager.h"
#import "BSNetAPIClient.h"

#import "User.h"
#import "Login.h"

@implementation UserNetAPIManager

+ (instancetype)sharedManager {
    static UserNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)loginWithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block {
    [[BSNetAPIClient sharedClient] requestWithPath:@"v1/user/signIn" params:params type:Post block:^(id _Nonnull data, NSError * _Nonnull error) {
        id resultData = [data valueForKey:@"data"];
        if (resultData) {
            User *user = [User mj_objectWithKeyValues:resultData];
            if (user) {
                [Login doLogin:resultData];
            }
            block(user, nil);
        }else {
            block(nil, error);
        }
    }];
}

@end
