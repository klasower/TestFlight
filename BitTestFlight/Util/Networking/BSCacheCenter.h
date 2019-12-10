//
//  BSCacheCenter.h
//  BitCommunitiesPeace
//
//  Created by chujian.zheng on 2019/5/17.
//  Copyright © 2019 BIT Net Technology(Tian Jin)co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSCacheCenter : NSObject

//缓存请求回来的json对象
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;

//返回一个NSDictionary类型的json数据
+ (id)loadResponseWithPath:(NSString *)requestPath;

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;

+ (BOOL)deleteResponseCache;

+ (NSUInteger)getResponseCacheSize;

@end

NS_ASSUME_NONNULL_END
