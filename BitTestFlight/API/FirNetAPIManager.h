//
//  FirNetAPIManager.h
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/18.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirNetAPIManager : NSObject

+ (instancetype)sharedManager;

/// 查看自己上传的应用列表
- (void)appsWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block;

/// 查看应用详细信息
- (void)appDetailWithID:(NSString *)ID Params:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取 download_token
- (void)downloadTokenWithID:(NSString *)ID Params:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
