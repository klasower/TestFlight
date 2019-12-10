//
//  PgyerNetAPIManager.h
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PgyerNetAPIManager : NSObject

+ (instancetype)sharedManager;

/// 查看自己上传的应用
- (void)listMyWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block;

/// 获取App详细信息
- (void)appDetailWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
