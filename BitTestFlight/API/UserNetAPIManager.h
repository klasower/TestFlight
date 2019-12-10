//
//  UserNetAPIManager.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/22.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//  用户相关的网络请求(包含登录/注册/个人信息等)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserNetAPIManager : NSObject

+ (instancetype)sharedManager;

/// 密码登录
- (void)loginWithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
@end

NS_ASSUME_NONNULL_END
