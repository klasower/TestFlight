//
//  PgyerNetAPIManager.m
//  BitTestFlight
//
//  Created by chujian.zheng on 2019/12/4.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import "PgyerNetAPIManager.h"
#import "BSNetAPIClient.h"
#import "PgyAppInfoModel.h"

@implementation PgyerNetAPIManager

+ (instancetype)sharedManager {
    static PgyerNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

/// 查看自己上传的应用
- (void)listMyWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block {

    [[BSNetAPIClient sharedClient] requestWithPath:@"apiv2/app/listMy" params:params type:Post block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        id resultData = [data valueForKey:@"data"];
        if (resultData) {
            NSArray *apps = [PgyAppInfoModel mj_objectArrayWithKeyValuesArray:resultData[@"list"]];
            block(apps, nil);
        }else {
            block(nil, error);
        }
    }];
}

/// 获取App详细信息
- (void)appDetailWithParams:(NSDictionary * _Nullable)params andBlock:(void (^)(id data, NSError *error))block {
    
    [[BSNetAPIClient sharedClient] requestWithPath:@"apiv2/app/view" params:params type:Post block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        id resultData = [data valueForKey:@"data"];
        if (resultData) {
            PgyAppInfoModel *app = [PgyAppInfoModel mj_objectWithKeyValues:resultData];
            block(app, nil);
        }else {
            block(nil, error);
        }
    }];
}

@end
