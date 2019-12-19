//
//  FirNetAPIManager.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/18.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "FirNetAPIManager.h"
#import "BSNetAPIClient.h"
#import "FirAppInfoModel.h"

@implementation FirNetAPIManager

+ (instancetype)sharedManager {
    static FirNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

/// 查看自己上传的应用列表
- (void)appsWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block {
    [[BSNetAPIClient sharedClient] requestWithPath:@"apps" params:params type:Get block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        id resultData = [data valueForKey:@"items"];
        if (resultData) {
            NSArray *apps = [FirAppInfoModel mj_objectArrayWithKeyValuesArray:resultData];
            block(apps, nil);
        }else {
            block(nil, error);
        }
    }];
}

/// 查看应用详细信息
- (void)appDetailWithID:(NSString *)ID Params:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block {
    NSString *path = [NSString stringWithFormat:@"apps/%@", ID];
    
    [[BSNetAPIClient sharedClient] requestWithPath:path params:params type:Get block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        if (data) {
            FirAppInfoModel *app = [FirAppInfoModel mj_objectWithKeyValues:data];
            block(app, nil);
        }else {
            block(nil, error);
        }
    }];
}

/// 获取 download_token
- (void)downloadTokenWithID:(NSString *)ID Params:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block {
    
    NSString *path = [NSString stringWithFormat:@"apps/%@/download_token", ID];
    
    [[BSNetAPIClient sharedClient] requestWithPath:path params:params type:Get block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        id resultData = [data valueForKey:@"download_token"];
        if (resultData) {
            block(resultData, nil);
        }else {
            block(nil, error);
        }
    }];
}

@end
